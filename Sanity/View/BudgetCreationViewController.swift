//
//  BudgetCreationViewController.swift
//  Sanity
//
//  Created by Max Wong on 10/14/2017.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import UIKit



class BudgetCreationViewController: UIViewController , UITableViewDelegate , UITableViewDataSource,UIPickerViewDataSource, UIPickerViewDelegate{
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    
    var names : [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = NSLocalizedString("nameTitleTag", comment: "tag of name label")
        percentageLabel.text = NSLocalizedString("percentTag", comment: "tag of percent")
        //nameField.text = "New Budget"
        //sizes of our cells
        myTableView.rowHeight = 70
        myTableView2.rowHeight = 100
        
        //register our custome cells / xib files so we can treat em like prototypes
        let datePick = UINib(nibName:"pickerCell1" , bundle: nil)
        myTableView.register(datePick, forCellReuseIdentifier: "dateCell")
        let intPick = UINib(nibName:"pickerCell2" , bundle: nil)
        myTableView2.register(intPick, forCellReuseIdentifier: "intCell")
        
        //Delegate Picker
        self.percentPicker.delegate = self as! UIPickerViewDelegate
        self.percentPicker.dataSource = self as! UIPickerViewDataSource
      
            //so we can refresh this view form somewhere else
               let updater = NSNotification.Name("reloadBud")
                   NotificationCenter.default.addObserver(self, selector: #selector(self.viewDidLoad), name: updater, object: nil)
        
        if(globalColor == 1){
            self.view.backgroundColor = UIColor .darkGray
            myTableView.backgroundColor = UIColor .darkGray
            myTableView2.backgroundColor = UIColor .darkGray
        }
        else{
            self.view.backgroundColor = UIColor .white
            myTableView.backgroundColor = UIColor .white
            myTableView2.backgroundColor = UIColor .white
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.continueButton.alpha = 0
        self.cancelButton.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.3, options: .curveEaseOut, animations: {
            self.continueButton.alpha = 1
            self.cancelButton.alpha = 1
        }, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func AddItemPick(_ sender: Any) {
        numItemsPick += 1
        myTableView.reloadData()
    }
    
    @IBAction func addItemInterval(_ sender: Any) {
        numItemsInt += 1
        myTableView2.reloadData()
    }
    
    //Date Picker
    @IBOutlet weak var myTableView: UITableView!
    var numItemsPick : Int = 1
    
    @IBOutlet weak var myTableView2: UITableView!
    var numItemsInt : Int = 1
    
    
    
    //Table Functions//Table Functions//Table Functions//Table Functions//Table Functions
    //Table Functions//Table Functions//Table Functions//Table Functions//Table Functions
    //Table Functions//Table Functions//Table Functions//Table Functions//Table Functions
    //Table Functions//Table Functions//Table Functions//Table Functions//Table Functions
    //Number of items to display, and which items to display
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.myTableView{
            return numItemsPick
        }
        else{
            return numItemsInt
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.myTableView{
            let cell = myTableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath) as! pickerCell1;
            return cell
        }
        let cell = myTableView2.dequeueReusableCell(withIdentifier: "intCell", for: indexPath) as! pickerCell2;
        return (cell)
    }
    
    
    //Remove Item Functionality
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        
        if tableView == self.myTableView{
            numItemsPick -= 1
            myTableView.reloadData()
        }
        
        if tableView == self.myTableView2{
            numItemsInt -= 1
            myTableView2.reloadData()
        }
    }
    
    //KeyboardLogic//KeyboardLogic//KeyboardLogic//KeyboardLogic
    //KeyboardLogic//KeyboardLogic//KeyboardLogic//KeyboardLogic
    //KeyboardLogic//KeyboardLogic//KeyboardLogic//KeyboardLogic
    //KeyboardLogic//KeyboardLogic//KeyboardLogic//KeyboardLogic
    @IBAction func keyboardDismiss(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    //Picker Mechanization//Picker Mechanization//Picker Mechanization
    //Picker Mechanization//Picker Mechanization//Picker Mechanization
    //Picker Mechanization//Picker Mechanization//Picker Mechanization
    //Picker Mechanization//Picker Mechanization//Picker Mechanization
    @IBOutlet weak var percentPicker: UIPickerView!
    
    let percent = ["Don't","5","10","15","20","25","30","35","40"
        ,"45","50","55","60","65","70","75","80",
         "85","90","95","100"]
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return percent[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return percent.count
    }
    
    //This is where we record the picker selection
    var percentChosen : Int = 0;
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        percentChosen = row
    }
    //Retrieve for Storage On Confirm//Retrieve for Storage On Confirm
    //Retrieve for Storage On Confirm//Retrieve for Storage On Confirm
    //Retrieve for Storage On Confirm//Retrieve for Storage On Confirm
    //Retrieve for Storage On Confirm//Retrieve for Storage On Confirm
    
    @IBOutlet weak var nameField: UITextField!
    
    
    var mydates : Int = 0
    var myIntervals : Int = 0
    var mystartDates : Int = 0
    @IBAction func recordInput(_ sender: Any) {
        if(nameField.text! == "") {
            nameField.text = "New Budget"
        }
        
        //Table 1 - Date Picker
        for cell in myTableView.visibleCells {
            if let customCell = cell as? pickerCell1 {
                //print(customCell.dateChosen)
                mydates = customCell.dateChosen 
            }
        }
        //Table 2 - Interval Picker
        //my 
        for cell in myTableView2.visibleCells {
            if let customCell = cell as? pickerCell2 {
                mystartDates = customCell.dayChosen
                myIntervals = customCell.intChosen
            }
        }
        
        //Store name here
        var budgetName = nameField.text!

        var dupeCounter = 1
        
        while (Dummy.user.budgetList.keys.contains(budgetName)){
            budgetName = nameField.text! + String(dupeCounter)
            dupeCounter += 1
        }
        
        DispatchQueue.main.async {
            //declare newBudget
            let newBudget = Budget(name: budgetName , intervalStartDate: String(self.mystartDates), intervalResetOn:0, alwaysResetOn: String(self.mydates), resetInterval: String(self.myIntervals), budgetAmount: 0, budgetUsed: 0, notificationPercent: Double((self.percentChosen) * 5), notificationFrequency: "1", categoryList: [String : Category]())

            Dummy.user.budgetList[budgetName] = newBudget
            Dummy.currentBudgetName = budgetName
            globalBudget = budgetName
            Dummy.user2 = Dummy.user
            Dummy.dc.pushUserToFirebase(user: Dummy.user)
        }
    }
    
    @IBAction func updateparent(_ sender: Any) {
        //reloadMain
        let notificationNme = NSNotification.Name("reloadMain")
        NotificationCenter.default.post(name: notificationNme, object: nil)
    }
}
var globalBudget : String = ""
var globalCat : String = ""
var globalPurchase : String = ""
