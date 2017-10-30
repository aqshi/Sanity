//
//  CategoryPageViewController.swift
//  Sanity
//
//  Created by Max Wong on 10/14/2017.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import UIKit

class CategoryPageViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.rowHeight = 100
        //register the custom cell for use as a normal prototype
        let nibName = UINib(nibName: "TransCell", bundle: nil)
        myTableView.register(nibName, forCellReuseIdentifier: "TransCell")
        
        //so we can refresh this view form somewhere else
        let updater = NSNotification.Name("reloadCat")
        NotificationCenter.default.addObserver(self, selector: #selector(self.viewDidAppear(_:)), name: updater, object: nil)
        
        print(globalBudget)
        print(globalCat)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(Dummy.user2.userID != "") {
            Dummy.user = Dummy.user2
        }
        if(Dummy.user.budgetList[globalBudget]!.categoryList.count > 0 ){
            self.numCells = (Dummy.user.budgetList[globalBudget]!.categoryList[globalCat]!.purchaseList.count)
        }
        
        //ultimate Updater Block!
        for(String, _) in (Dummy.user.budgetList){
            for(String, _) in (Dummy.user.budgetList[String]?.categoryList)! {
                Dummy.user.budgetList[globalBudget]?.categoryList[String]?.calcUsed()
            }
            Dummy.user.budgetList[String]?.update()
        }
            self.nameList.removeAll()
            self.dateList.removeAll()
            self.priceList.removeAll()
        
        for(String, Purchase) in (Dummy.user.budgetList[globalBudget]?.categoryList[globalCat]?.purchaseList)! {
            self.nameList.append(String)
            self.priceList.append((Dummy.user.budgetList[globalBudget]?.categoryList[globalCat]?.purchaseList[String]?.price)!)
            self.dateList.append((Dummy.user.budgetList[globalBudget]?.categoryList[globalCat]?.purchaseList[String]?.date)!)
        }
        DispatchQueue.main.async {
            self.myTableView.reloadData()
        }
    }
    
    //Table Logic//Table Logic//Table Logic//Table Logic//Table Logic
    //Table Logic//Table Logic//Table Logic//Table Logic//Table Logic
    //Table Logic//Table Logic//Table Logic//Table Logic//Table Logic
    //Table Logic//Table Logic//Table Logic//Table Logic//Table Logic
    @IBOutlet weak var myTableView: UITableView!
    var numCells : Int = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(Dummy.user2.userID != "") {
            Dummy.user = Dummy.user2
        }
        if(Dummy.user.budgetList[globalBudget]!.categoryList.count > 0 ){
            numCells = (Dummy.user.budgetList[globalBudget]!.categoryList[globalCat]!.purchaseList.count)
        } else{
            numCells = 0
        }
        return numCells
    }
    
    var nameList = [String]()
    var priceList = [Double]()
    var dateList = [String]()
    var memoList = [String]()
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "TransCell", for: indexPath) as! TransCell
        
        cell.nameLabel.text = nameList[indexPath.row]
        cell.amountLabel.text = String(format:"%.2f",priceList[indexPath.row])
        cell.dateLabel.text = dateList[indexPath.row]
        
        return cell
    }
    
    //Remove Item Functionality
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        //first literally remove the item from the map
        let cell = myTableView.cellForRow(at: indexPath)
        let toRemove : String = (cell as! TransCell).nameLabel.text!
        Dummy.user.budgetList[globalBudget]?.categoryList[globalCat]?.purchaseList.removeValue(forKey: toRemove)
        Dummy.user2 = Dummy.user
        self.myTableView.deleteRows(at: [indexPath] , with: UITableViewRowAnimation.fade)
        
        //then rebuild the arrays
        
        nameList.removeAll()
        dateList.removeAll()
        priceList.removeAll()
        for(String, Purchase) in (Dummy.user.budgetList[globalBudget]?.categoryList[globalCat]?.purchaseList)! {
            nameList.append(String)
            priceList.append((Dummy.user.budgetList[globalBudget]?.categoryList[globalCat]?.purchaseList[String]?.price)!)
            dateList.append((Dummy.user.budgetList[globalBudget]?.categoryList[globalCat]?.purchaseList[String]?.date)!)
        }
        DispatchQueue.main.async {
            self.myTableView.reloadData()
            Dummy.dc.pushUserToFirebase(user: Dummy.user)
            print("Deleted \(Dummy.user)")
        }
    }
    
    //From the Table to the Next Page!
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        toTransPage()
        let cell = myTableView.cellForRow(at: indexPath)
        Dummy.currentPurchaseName = (cell as! TransCell).nameLabel.text!
        globalPurchase = (cell as! TransCell).nameLabel.text!
    }
    
    func toTransPage(){
        self.performSegue(withIdentifier: "toTransPage", sender: self)
    }
    
    
    @IBAction func toBudgetPage(_ sender: Any) {
        //Update the previous page, the Budget Page
        let updater = NSNotification.Name("reloadBud")
        NotificationCenter.default.post(name: updater, object: nil)
    }
    
    
    
}
