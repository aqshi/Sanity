//
//  CategoryCreationViewController.swift
//  Sanity
//
//  Created by Max Wong on 10/14/2017.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import UIKit

class CategoryCreationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.rowHeight = 100
        let nibName = UINib(nibName: "catCell", bundle: nil)
        myTableView.register(nibName, forCellReuseIdentifier: "catCell")
        // Do any additional setup after loading the view.
        
        if(globalColor == 1){
            self.view.backgroundColor = UIColor .darkGray
            myTableView.backgroundColor = UIColor .darkGray
        }
        else{
            self.view.backgroundColor = UIColor .white
            myTableView.backgroundColor = UIColor .white
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.addButton.alpha = 0;
        self.confirmButton.alpha = 0
        self.cancelButton.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.3, options: .curveEaseOut, animations: {
            self.addButton.alpha = 1
            self.confirmButton.alpha = 1
            self.cancelButton.alpha = 1
        }, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
   
    //Table Functions//Table Functions//Table Functions//Table Functions//Table Functions
    //Table Functions//Table Functions//Table Functions//Table Functions//Table Functions
    //Table Functions//Table Functions//Table Functions//Table Functions//Table Functions
    //Table Functions//Table Functions//Table Functions//Table Functions//Table Functions
    @IBOutlet weak var myTableView: UITableView!
    @IBAction func addItem(_ sender: Any) {
        numCells += 1
        myTableView.reloadData()
    }
    
    var numCells : Int = 4
    //Number of items to display, and which items to display
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numCells
    }
    
    let list = ["Food","Clothes","Entertainment", "Transportation" ]
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = Bundle.main.loadNibNamed("catCell", owner: self, options: nil)?.first as! catCell;
        let cell = myTableView.dequeueReusableCell(withIdentifier: "catCell", for: indexPath) as! catCell
        makedefault()
        return cell
    }
    
    func makedefault() -> Double{
        var count : Int = 0
        for cell in myTableView.visibleCells {
            if let customCell = cell as? catCell {
               
                customCell.nameField.text = list[count]
                customCell.name = list[count]
                
            }
            count += 1
        }
        
        return 0
    }
    
    //Remove Item Functionality
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
            numCells -= 1
            myTableView.reloadData()
    }
    
    //Retrieve for Storage On Confirm//Retrieve for Storage On Confirm
    //Retrieve for Storage On Confirm//Retrieve for Storage On Confirm
    //Retrieve for Storage On Confirm//Retrieve for Storage On Confirm
    //Retrieve for Storage On Confirm//Retrieve for Storage On Confirm
    var nameList = [String]()
    var budgList = [Double]()
    @IBAction func retrieveVals(_ sender: Any) {
        var budgetName : String = Dummy.currentBudgetName
        
        
        for cell in myTableView.visibleCells {
            if let customCell = cell as? catCell {
                customCell.store()
                //Create the Category to add
                if(customCell.name == "") {
                    customCell.name = "New Category"
                }
                var catName = customCell.name
                var dupeCounter = 1
                
                while (Dummy.user.budgetList[globalBudget]?.categoryList.keys.contains(catName))!{
                    catName = customCell.name + String(dupeCounter)
                    dupeCounter += 1
                }
                
                
                let cat = Category(
                    name: catName,
                    amountLimit: customCell.budg,
                    amountUsed: 0,
                    notificationPercent: (Dummy.user.budgetList[budgetName]!.notificationPercent),
                    purchaseList: [String : Purchase]()
                )
                Dummy.user.budgetList[budgetName]!.categoryList[catName] = cat
            }
        }
        Dummy.user2 = Dummy.user
        Dummy.delay = true
        DispatchQueue.main.async {
            Dummy.dc.pushUserToFirebase(user: Dummy.user)
            print("Pushed \(Dummy.user)")
        }
        //reloadMain
        let notificationNme = NSNotification.Name("reloadMain")
        NotificationCenter.default.post(name: notificationNme, object: nil)
    }
    
    //Keyboard Logic//Keyboard Logic//Keyboard Logic//Keyboard Logic
    //Keyboard Logic//Keyboard Logic//Keyboard Logic//Keyboard Logic
    //Keyboard Logic//Keyboard Logic//Keyboard Logic//Keyboard Logic
    @IBAction func clearKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    

}
