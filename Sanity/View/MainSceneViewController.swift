//
//  MainSceneViewController.swift
//  Sanity
//
//  Created by Max Wong on 10/13/2017.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import GoogleSignIn

var globalColor = 1;

class MainSceneViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var newBudgetButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var colorButton: UIBarButtonItem!
    @IBOutlet weak var changeColorButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.rowHeight = 100
        //register the custom cell for use as a normal prototype
        let nibName = UINib(nibName: "budCell", bundle: nil)
        myTableView.register(nibName, forCellReuseIdentifier: "budCell")
        //so we can refresh this view form somewhere else
        let updater = NSNotification.Name("reloadMain")
        NotificationCenter.default.addObserver(self, selector: #selector(self.viewWillAppear(_:)), name: updater, object: nil)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        if(globalColor == 1){
           self.view.backgroundColor = UIColor .darkGray
            myTableView.backgroundColor = UIColor .darkGray
        }
        else{
            self.view.backgroundColor = UIColor .white
            myTableView.backgroundColor = UIColor .white
        }
    }
    
    
    @IBAction func changeColors(_ sender: Any) {
        if(globalColor == 2){
            globalColor = 1
            self.view.backgroundColor = UIColor .darkGray
            myTableView.backgroundColor = UIColor .darkGray
            changeColorButton.setTitle("DayMode", for: .normal)
        }
        else{
            globalColor = 2
            self.view.backgroundColor = UIColor .white
            myTableView.backgroundColor = UIColor .white
            changeColorButton.setTitle("NightMode", for: .normal)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.newBudgetButton.alpha = 0
        self.logoutButton.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.3, options: .curveEaseOut, animations: {
            self.newBudgetButton.alpha = 1
            self.logoutButton.alpha = 1
        }, completion: nil)
        print("BEGIN \(Dummy.user)")
        if(Dummy.delay == true) {
            self.numCells = Dummy.user.budgetList.count
            self.numCells = Dummy.user.budgetList.count
            print(Dummy.user.budgetList.count)
            //ultimate Updater Block!
            for(String, _) in (Dummy.user.budgetList){
                for(String, _) in (Dummy.user.budgetList[String]?.categoryList)! {
                    Dummy.user.budgetList[globalBudget]?.categoryList[String]?.calcUsed()
                }
                Dummy.user.budgetList[String]?.update()
            }
            spentList.removeAll()
            totalList.removeAll()
            nameList.removeAll()
            resetdatesList.removeAll()
            for(Name, Budget) in Dummy.user.budgetList {
                print("Append")
                nameList.append(Name)
                spentList.append(String(format:"%.2f",Budget.budgetUsed))
                totalList.append(String(format:"%.2f",Budget.budgetAmount))
                resetdatesList.append(Budget.nextDateResetString)
            }
            DispatchQueue.main.async {
                self.myTableView.reloadData()
                
            }
            Dummy.delay = false
        } else {
            print("FALSE")
            self.numCells = Dummy.user.budgetList.count
            //ultimate Updater Block!
            for(String, _) in (Dummy.user.budgetList){
                for(String, _) in (Dummy.user.budgetList[String]?.categoryList)! {
                    Dummy.user.budgetList[globalBudget]?.categoryList[String]?.calcUsed()
                }
                Dummy.user.budgetList[String]?.update()
            }
            self.totalList.removeAll()
            self.spentList.removeAll()
            self.nameList.removeAll()
            self.resetdatesList.removeAll()
            for(Name, Budget) in Dummy.user.budgetList {
                self.nameList.append(Name)
                self.spentList.append(String(format:"%.2f", (Budget.budgetAmount - Budget.budgetUsed) ))
                self.totalList.append(String(format:"%.2f",Budget.budgetAmount))
                if(Budget.nextDateResetString != "01 Jan 9999"){
                    resetdatesList.append(Budget.nextDateResetString)
                }
                else {
                    resetdatesList.append("Never")
                }
            }
            self.myTableView.reloadData()
        }
    }
    
    @objc func swiped(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            if (self.tabBarController?.selectedIndex)! == 0 { 
                self.tabBarController?.selectedIndex = 1
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func LogOff(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        performSegue(withIdentifier: "LoggedOut", sender: self)
    }
    
    //Table Logic//Table Logic//Table Logic//Table Logic//Table Logic
    //Table Logic//Table Logic//Table Logic//Table Logic//Table Logic
    //Table Logic//Table Logic//Table Logic//Table Logic//Table Logic
    //Table Logic//Table Logic//Table Logic//Table Logic//Table Logic
    @IBOutlet weak var myTableView: UITableView!
    
    var numCells : Int = 0
    
    var nameList = [String]()
    var spentList = [String]()
    var totalList = [String]()
    var resetdatesList = [String]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numCells = Dummy.user.budgetList.count
        return numCells
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(self.nameList.count)
        print(self.resetdatesList.count)
        let cell = myTableView.dequeueReusableCell(withIdentifier: "budCell", for: indexPath) as! budCell
        cell.budName.text = nameList[indexPath.row]
        cell.limit.text = totalList[indexPath.row]
        cell.remaining.text = spentList[indexPath.row]
        cell.dateReset.text = resetdatesList[indexPath.row]
        return cell
    }
    
    //Remove Item Functionality
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        //first literally remove the item from the map
        let cell = myTableView.cellForRow(at: indexPath)
        let toRemove : String = (cell as! budCell).budName.text!
        //Since it's a budget, remove the categories and purchases
        for(String , _) in (Dummy.user.budgetList[toRemove]?.categoryList)! {
            for(String , _) in (Dummy.user.budgetList[toRemove]?.categoryList[String]?.purchaseList)! {
                Dummy.user.budgetList[globalBudget]?.categoryList[toRemove]?.purchaseList.removeValue(forKey: String)
            }
            Dummy.user.budgetList[globalBudget]?.categoryList.removeValue(forKey: String)
        }
        Dummy.user.budgetList.removeValue(forKey: toRemove)
        myTableView.deleteRows(at: [indexPath] , with: UITableViewRowAnimation.fade )
        
        spentList.removeAll()
        totalList.removeAll()
        nameList.removeAll()
        resetdatesList.removeAll()
        for(Name, Budget) in Dummy.user.budgetList {
            nameList.append(Name)
            spentList.append(String(format:"%.2f", (Budget.budgetAmount - Budget.budgetUsed) ))
            totalList.append(String(format:"%.2f",Budget.budgetAmount))
            if(Budget.nextDateResetString != "01 Jan 9999"){
                resetdatesList.append(Budget.nextDateResetString)
            }
            else {
                resetdatesList.append("Never")
            }
        }
        self.myTableView.reloadData()
        Dummy.user2 = Dummy.user
        DispatchQueue.main.async {
            Dummy.dc.pushUserToFirebase(user: Dummy.user)
            print("Deleted \(Dummy.user)")
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        //MARK:- Fade transition Animation
//        cell.alpha = 0
//        UIView.animate(withDuration: 1) {
//            cell.alpha = 1
//        }
        
        //MARK:- Curl transition Animation
        // cell.layer.transform = CATransform3DScale(CATransform3DIdentity, -1, 1, 1)
        
        // UIView.animate(withDuration: 0.4) {
        //  cell.layer.transform = CATransform3DIdentity
        //}
        
        //MARK:- Frame Translation Animation
        cell.layer.transform = CATransform3DTranslate(CATransform3DIdentity, -cell.frame.width, 1, 1)
        
         UIView.animate(withDuration: 0.5) {
          cell.layer.transform = CATransform3DIdentity
         }
    }
    
    //Table Movement//Table Movement//Table Movement//Table Movement
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = myTableView.cellForRow(at: indexPath)
        Dummy.currentBudgetName = (cell as! budCell).budName.text!
        globalBudget = (cell as! budCell).budName.text!
        toBudgPage()
    }
    func toBudgPage(){
        //Update the page, the Budget Page
        let updater = NSNotification.Name("reloadBud")
        NotificationCenter.default.post(name: updater, object: nil)
        //Then move to it!
        self.performSegue(withIdentifier: "toBudgPage", sender: self)
    }
}




