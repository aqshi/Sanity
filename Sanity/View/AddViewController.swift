//
//  AddViewController.swift
//  Sanity
//
//  Created by QIZUN XIE on 20/11/2017.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import UIKit

class AddViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    @IBOutlet weak var CategoryTF: UITextField!
    @IBOutlet weak var BudgetTF: UITextField!
    @IBOutlet weak var NameTF: UITextField!
    @IBOutlet weak var AmntTF: UITextField!
    @IBOutlet weak var Calendar: UIDatePicker!
    @IBOutlet weak var Description: UITextField!
    @IBOutlet weak var DoneButton: UIBarButtonItem!
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    
   
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView.tag == 1){
            return Dummy.user.budgetList.count
        }
        else{
            if(BudgetTF.text == ""){}
            else{
                return (Dummy.user.budgetList[selectedBudget1]?.categoryList.count)!
            }
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if(pickerView.tag == 2){
            if(BudgetTF.text == ""){}
            else{
                return categoryListHere1[row]
            }
        }
        return budgetlistHere1[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(pickerView.tag == 1){
            selectedBudget1 = budgetlistHere1[row]
            BudgetTF.text = selectedBudget1
            CategoryTF.text = ""
            selectedCat1 = ""
            let temp = Dummy.user.budgetList[selectedBudget1]
            Dummy.currentBudgetName = selectedBudget1
            categoryListHere1.removeAll()
            for (x,_) in (temp?.categoryList)! {
                categoryListHere1.append(x)
            }
        }
        else{
            if(BudgetTF.text == ""){}
            else{
                selectedCat1 = categoryListHere1[row]
                CategoryTF.text = selectedCat1;
                Dummy.currentCategoryName = selectedCat1
            }
        }
    }
    func createBudgetPicker(){
        let BudgetPicker1 = UIPickerView()
        BudgetPicker1.delegate = self
        BudgetPicker1.tag = 1;
        BudgetTF?.inputView = BudgetPicker1
        let BudgetPicker2 = UIPickerView()
        BudgetPicker2.tag = 2;
        BudgetPicker2.delegate = self
        CategoryTF?.inputView = BudgetPicker2
    }

    func createToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let donebutton = UIBarButtonItem(title:"Done", style: .plain, target:self, action:#selector(self.dismissKeyboard))
        toolBar.setItems([donebutton],animated:false)
        toolBar.isUserInteractionEnabled = true
        BudgetTF.inputAccessoryView = toolBar
        CategoryTF.inputAccessoryView = toolBar
        //NameTF.inputDelegate = self;
        //AmntTF.isUserInteractionEnabled = true;
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.DoneButton.isEnabled = false;
        for (x,_) in Dummy.user.budgetList{
            budgetlistHere1.append(x)
        }
        AmntTF.keyboardType = UIKeyboardType.decimalPad;
        createBudgetPicker()
        createToolbar()
        // Do any additional setup after loading the view.
        recordDate(self)
        
        if(globalColor == 1){
            self.view.backgroundColor = UIColor .darkGray
        }
        else{
            self.view.backgroundColor = UIColor .white
        }
    }
    
    func check(){
        if(BudgetTF.text ==
            "" || CategoryTF.text == "" || NameTF.text == "" || AmntTF.text == ""){
            self.DoneButton.isEnabled = false;
        }
        else{
            self.DoneButton.isEnabled = true;
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func dismissKeyboard(){
        self.check()
        view.endEditing(true);
        
    }
    @IBAction func dismissKy(_ sender: Any) {
        self.check()
        self.resignFirstResponder()
    }
    
    @IBAction func dissmissKB(_ sender: Any) {
        self.check()
        self.resignFirstResponder()
    }
    @IBAction func dissmissKYB(_ sender: Any) {
        self.check()
        self.resignFirstResponder()
    }
    @IBAction func CancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: {})
    }
    
    var doubletoStore : Double = 0
    @IBAction func formatNumbers(_ sender: Any) {
        let amountDisplay = Double(AmntTF.text!)
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        let ADString = AmntTF.text!
        let ADParts = ADString.components(separatedBy: ".")
        if (ADParts.count <= 2 && ADString.range(of: "..") == nil) {
            AmntTF.text = formatter.string(from: NSNumber(value:amountDisplay!))
            doubletoStore = amountDisplay!
        }
        else {
            AmntTF.text = "Invalid Number"
            doubletoStore = 0
        }
        
    }
    
    var selectedDate : String = ""
    @IBAction func recordDate(_ sender: Any) {
        Calendar.datePickerMode = UIDatePickerMode.date
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        selectedDate = dateFormatter.string(from: Calendar.date)
    }
    
    var name : String = ""
    var amnt : Double = 0
    var desc : String = ""
    @IBAction func DonePressed(_ sender: Any) {
        self.check()
        if(self.DoneButton.isEnabled){
            
            //store the name
            if(NameTF.text! == "") {
                NameTF.text = "New Transaction"
            }
            name = NameTF.text!
            //make name unique
            var dupeCounter = 1
            
            //TODO: fix this up, pull the name form the pickers. idk how to do it atm
            while (Dummy.user.budgetList[Dummy.currentBudgetName]?.categoryList[Dummy.currentCategoryName]?.purchaseList.keys.contains(name))!{
                name = NameTF.text! + String(dupeCounter)
                dupeCounter += 1
            }
  
            //store the amnt
            amnt = doubletoStore
            desc = Description.text!
            recordDate(Calendar)
            let purchase = Purchase(name: name , price: amnt ,date: selectedDate, memo: desc)
            Dummy.user.budgetList[Dummy.currentBudgetName]?.categoryList[Dummy.currentCategoryName]?.purchaseList[name] = purchase
        
            //TODO: kin/joseph, your stuff goes here (Add to the map).
            for(String, _) in (Dummy.user.budgetList){
                for(String, _) in (Dummy.user.budgetList[String]?.categoryList)! {
                    Dummy.user.budgetList[globalBudget]?.categoryList[String]?.calcUsed()
                }
                Dummy.user.budgetList[String]?.update()
            }
            DispatchQueue.main.async {
                Dummy.dc.pushUserToFirebase(user: Dummy.user)
                print("Add purchase \(Dummy.user)")
                let RemainBalance = Double((Dummy.user.budgetList[Dummy.currentBudgetName]?.categoryList[Dummy.currentCategoryName]?.amountLimit)!) - Double((Dummy.user.budgetList[Dummy.currentBudgetName]?.categoryList[Dummy.currentCategoryName]?.amountUsed)!)
                let RemainRatio = Double((Dummy.user.budgetList[Dummy.currentBudgetName]?.categoryList[Dummy.currentCategoryName]?.amountUsed)!) / Double((Dummy.user.budgetList[Dummy.currentBudgetName]?.categoryList[Dummy.currentCategoryName]?.amountLimit)!)
                
                let time = Dummy.user.budgetList[Dummy.currentBudgetName]?.recentIntervalResetString;
                print((Dummy.user.budgetList[Dummy.currentBudgetName]?.notificationPercent)!)
                if(RemainRatio*100 >= (Dummy.user.budgetList[Dummy.currentBudgetName]?.notificationPercent)!){
                    User.purchaseOverLimitNotification(Budgetname: Dummy.currentBudgetName, Categoryname: Dummy.currentCategoryName, AmountLeft: RemainBalance, timeRemain: time!, Repeat: (Dummy.user.budgetList[Dummy.currentBudgetName]?.notificationFrequency)!)
                }
            }
            
            //reloadMain and dismiss view!
            let notificationNme = NSNotification.Name("reloadMain")
            NotificationCenter.default.post(name: notificationNme, object: nil)
            self.dismiss(animated: true, completion: {})
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
var selectedBudget1: String = ""
var selectedCat1: String = ""
var budgetlistHere1 = [String]()
var categoryListHere1 = [String]()
