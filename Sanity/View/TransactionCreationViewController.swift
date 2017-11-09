//
//  TransactionCreationViewController.swift
//  Sanity
//
//  Created by Max Wong on 10/14/2017.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import UIKit

class TransactionCreationViewController: UIViewController , UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var transactionNameTextField: UITextField!
    @IBOutlet weak var TransactionAmountTextField: UITextField!
    @IBOutlet weak var TransactionDescriptionTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.transactionNameTextField.delegate = self as? UITextFieldDelegate
        self.TransactionAmountTextField.delegate = self as? UITextFieldDelegate
        self.TransactionDescriptionTextField.delegate = self as? UITextFieldDelegate
        recordDate(self)
        
        TransactionAmountTextField.text = "$0.00"
        
        // Do any additional setup after loading the view.
        tipPicker.dataSource = self
        tipPicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Keyboard Logic//Keyboard Logic//Keyboard Logic//Keyboard Logic//Keyboard Logic
    //Keyboard Logic//Keyboard Logic//Keyboard Logic//Keyboard Logic//Keyboard Logic
    //Keyboard Logic//Keyboard Logic//Keyboard Logic//Keyboard Logic//Keyboard Logic
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func clearField(_ sender: Any) {
        TransactionAmountTextField.text = ""
    }
    
    var doubletoStore : Double = 0
    @IBAction func formatNumbers(_ sender: Any) {
        let amountDisplay = Double(TransactionAmountTextField.text!)
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        let ADString = TransactionAmountTextField.text!
        let ADParts = ADString.components(separatedBy: ".")
        if (ADParts.count <= 2 && ADString.range(of: "..") == nil) {
            TransactionAmountTextField.text = formatter.string(from: NSNumber(value:amountDisplay!))
            doubletoStore = amountDisplay!
        }
        else {
            TransactionAmountTextField.text = "Invalid Number"
            doubletoStore = 0
        }
        
        //update tip label
       
        tipPercent = percentChosen * 0.05
        tipToAdd = doubletoStore * tipPercent
        formatter.numberStyle = .currency
        tipDisplay.text = formatter.string(from: NSNumber(value:doubletoStore * tipPercent))
    }
    
    //datePicker//datePicker//datePicker//datePicker//datePicker//datePicker
    @IBOutlet weak var myDate: UIDatePicker!
    var selectedDate : String = ""
    @IBAction func recordDate(_ sender: Any) {
        myDate.datePickerMode = UIDatePickerMode.date
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        selectedDate = dateFormatter.string(from: myDate.date)
    }
    
    
    //Storage Logic//Storage Logic//Storage Logic//Storage Logic//Storage Logic
    //Storage Logic//Storage Logic//Storage Logic//Storage Logic//Storage Logic
    //Storage Logic//Storage Logic//Storage Logic//Storage Logic//Storage Logic
    //Storage Logic//Storage Logic//Storage Logic//Storage Logic//Storage Logic
    var name : String = ""
    var amnt : Double = 0
    var desc : String = ""
    
    
    
    @IBAction func confirmAddTransaction(_ sender: Any) {
        name = transactionNameTextField.text!
        amnt = doubletoStore + tipToAdd
        desc = TransactionDescriptionTextField.text!
        if(name == "") {
            transactionNameTextField.placeholder = "Name cannot be empty"
            return
        }
        recordDate(myDate)
        print(name)
        print(amnt)
        print(desc)
        let purchase = Purchase(name: name , price: amnt ,date: selectedDate, memo: desc)
        Dummy.user.budgetList[Dummy.currentBudgetName]?.categoryList[Dummy.currentCategoryName]?.purchaseList[name] = purchase
        for(String, _) in (Dummy.user.budgetList){
            for(String, _) in (Dummy.user.budgetList[String]?.categoryList)! {
                Dummy.user.budgetList[globalBudget]?.categoryList[String]?.calcUsed()
            }
            Dummy.user.budgetList[String]?.update()
        }
        Dummy.user2 = Dummy.user
        //User.purchaseOverLimitNotification()
        DispatchQueue.main.async {
            Dummy.dc.pushUserToFirebase(user: Dummy.user)
            print("Add purchase \(Dummy.user)")
            let RemainBalance = Double((Dummy.user.budgetList[Dummy.currentBudgetName]?.categoryList[Dummy.currentCategoryName]?.amountUsed)!) - Double((Dummy.user.budgetList[Dummy.currentBudgetName]?.categoryList[Dummy.currentCategoryName]?.amountLimit)!)
            let RemainRatio = Double((Dummy.user.budgetList[Dummy.currentBudgetName]?.categoryList[Dummy.currentCategoryName]?.amountUsed)!) / Double((Dummy.user.budgetList[Dummy.currentBudgetName]?.categoryList[Dummy.currentCategoryName]?.amountLimit)!)

            let time = Dummy.user.budgetList[Dummy.currentBudgetName]?.recentIntervalResetString;
            if(RemainRatio >= (Dummy.user.budgetList[Dummy.currentBudgetName]?.notificationPercent)!){
                User.purchaseOverLimitNotification(Budgetname: Dummy.currentBudgetName, Categoryname: Dummy.currentCategoryName, AmountLeft: RemainBalance, timeRemain: time!, Repeat: (Dummy.user.budgetList[Dummy.currentBudgetName]?.notificationFrequency)!)
            }
        }
        //Next, Let's update the previous page! the Category creation Page!
        let updater = NSNotification.Name("reloadCat")
        NotificationCenter.default.post(name: updater, object: nil)
    }
    
    //picker for the tip
    
    @IBOutlet weak var tipPicker: UIPickerView!
    let percent = ["0%","5%","10%","15%","20%","25%","30%","35%","40%"
        ,"45%","50%","55%","60%","65%","70%","75%","80%",
         "85%","90%","95%","100%"]
    
    
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
    @IBOutlet weak var tipDisplay: UILabel!
    var tipPercent : Double = 0;
    var tipToAdd : Double = 0;
    
    var percentChosen : Double = 0;
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        percentChosen = Double(row)
        
        tipPercent = percentChosen * 0.05
        tipToAdd = doubletoStore * tipPercent
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        tipDisplay.text = formatter.string(from: NSNumber(value:tipToAdd))
        
        
    }
    

}
