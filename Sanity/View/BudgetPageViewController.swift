//
//  BudgetPageViewController.swift
//  Sanity
//
//  Created by Max Wong on 10/14/2017.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import UIKit

class BudgetPageViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    
    var nameList = [String]()
    var spentList = [Double]()
    var totalList = [Double]()
    var percentList = [Double]()
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.reloadData()
        myTableView.rowHeight = 100
        //register the custom cell for use as a normal prototype
        let nibName = UINib(nibName: "catDisplayCell", bundle: nil)
        myTableView.register(nibName, forCellReuseIdentifier: "catDisplayCell")
        
        //so we can refresh this view form somewhere else
        let updater = NSNotification.Name("reloadBud")
        NotificationCenter.default.addObserver(self, selector: #selector(self.viewDidLoad), name: updater, object: nil)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.addButton.alpha = 0
        self.backButton.alpha = 0
        self.editButton.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.3, options: .curveEaseOut, animations: {
            self.addButton.alpha = 1
            self.backButton.alpha = 1
            self.editButton.alpha = 1
        }, completion: nil)
        
        numCells = (Dummy.user.budgetList[globalBudget]!.categoryList.count)
        
        //ultimate Updater Block!
        for(String, _) in (Dummy.user.budgetList){
            for(String, _) in (Dummy.user.budgetList[String]?.categoryList)! {
            Dummy.user.budgetList[globalBudget]?.categoryList[String]?.calcUsed()
            }
            Dummy.user.budgetList[String]?.update()
        }
        
        myTableView.reloadData()
        nameList.removeAll()
        spentList.removeAll()
        totalList.removeAll()
        percentList.removeAll()
        
        
        for(String, Category) in (Dummy.user.budgetList[globalBudget]?.categoryList)! {
            nameList.append(String)
            totalList.append((Dummy.user.budgetList[globalBudget]?.categoryList[String]?.amountLimit)!)
            spentList.append((Dummy.user.budgetList[globalBudget]?.categoryList[String]?.amountLimit)! - (Dummy.user.budgetList[globalBudget]?.categoryList[String]?.amountUsed)!)
            percentList.append((Dummy.user.budgetList[globalBudget]?.categoryList[String]?.amountUsed)! / (Dummy.user.budgetList[globalBudget]?.categoryList[String]?.amountLimit)! )
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Table Logic//Table Logic//Table Logic//Table Logic//Table Logic
    //Table Logic//Table Logic//Table Logic//Table Logic//Table Logic
    //Table Logic//Table Logic//Table Logic//Table Logic//Table Logic
    //Table Logic//Table Logic//Table Logic//Table Logic//Table Logic
    @IBOutlet weak var myTableView: UITableView!
    
    var numCells : Int = 0
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numCells = (Dummy.user.budgetList[globalBudget]!.categoryList.count)
        return numCells
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "catDisplayCell", for: indexPath) as! catDisplayCell
        cell.catName.text = nameList[indexPath.row]
        cell.total.text = String(format:"%.2f",totalList[indexPath.row])
        cell.progress.text = String(format:"%.2f",percentList[indexPath.row])
        cell.remaining.text = String(format:"%.2f",spentList[indexPath.row])
        return cell
    }
    
    //Remove Item Functionality
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        
        //first literally remove the item from the map
        let cell = myTableView.cellForRow(at: indexPath)
        let toRemove : String = (cell as! catDisplayCell).catName.text!
        //Since it's a category, remove the purchases
        for(String , _) in (Dummy.user.budgetList[globalBudget]?.categoryList[toRemove]?.purchaseList)! {
            Dummy.user.budgetList[globalBudget]?.categoryList[toRemove]?.purchaseList.removeValue(forKey: String)
        }
        Dummy.user.budgetList[globalBudget]?.categoryList.removeValue(forKey: toRemove)
        myTableView.deleteRows(at: [indexPath] , with: UITableViewRowAnimation.fade )
        
        //then rebuild the arrays
        myTableView.reloadData()
        nameList.removeAll()
        spentList.removeAll()
        totalList.removeAll()
        percentList.removeAll()
        
        
        for(String, _) in (Dummy.user.budgetList[globalBudget]?.categoryList)! {
            nameList.append(String)
            totalList.append((Dummy.user.budgetList[globalBudget]?.categoryList[String]?.amountLimit)!)
            spentList.append((Dummy.user.budgetList[globalBudget]?.categoryList[String]?.amountUsed)!)
            percentList.append((Dummy.user.budgetList[globalBudget]?.categoryList[String]?.amountUsed)! / (Dummy.user.budgetList[globalBudget]?.categoryList[String]?.amountLimit)! )
        }
        myTableView.reloadData()
        Dummy.user2 = Dummy.user
        DispatchQueue.main.async {
            Dummy.dc.pushUserToFirebase(user: Dummy.user)
            print("Deleted \(Dummy.user)")
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DTranslate(CATransform3DIdentity, -cell.frame.width, 1, 1)
        
        UIView.animate(withDuration: 0.5) {
            cell.layer.transform = CATransform3DIdentity
        }
    }
    
    //From the Table to the Next Page!
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = myTableView.cellForRow(at: indexPath)
        Dummy.currentCategoryName = (cell as! catDisplayCell).catName.text!
        globalCat = (cell as! catDisplayCell).catName.text!
        toCatPage()
    }
    func toCatPage(){
        //reloadcat
        let updater = NSNotification.Name("reloadCat")
        NotificationCenter.default.post(name: updater, object: nil)
        self.performSegue(withIdentifier: "toCatPage", sender: self)
    }
    
    
    @IBAction func endView(_ sender: Any) {
        let updater = NSNotification.Name("reloadMain")
        NotificationCenter.default.post(name: updater, object: nil)
    }
    
}
