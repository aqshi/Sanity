//
//  EditBudgetViewController.swift
//  Sanity
//
//  Created by Max Wong on 10/14/2017.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import UIKit

class EditBudgetViewController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource {

    @IBOutlet weak var budgetNameInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        percentagePicker.delegate = self
        dayPicker.delegate = self
        fixedDatePicker.delegate = self
        
        percentagePicker.dataSource = self
        dayPicker.dataSource = self
        fixedDatePicker.dataSource = self
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var intervalChooser: UISegmentedControl!
    override func viewWillAppear(_ animated: Bool) {
        nameField.text = globalBudget
        intervalChooser.selectedSegmentIndex = Int((Dummy.user.budgetList[globalBudget]?.resetInterval)!)!
        
        
        
    }
    
    //fixed date Picker
    @IBOutlet weak var fixedDatePicker: UIPickerView!
    let dates = ["Don't","1st","2nd","3rd","4th","5th","6th","7th","8th"
        ,"9th","10th","11th","12th","13th","14th","15th","16th",
         "17th","18th","19th","20th","21st","22nd","23rd","24th","25th",
         "26th","27th","28th","29th","30th","31st"]
    var fixedDateChosen : Int = 0;
    
    //Percentage Picker
    @IBOutlet weak var percentagePicker: UIPickerView!
    let percent = ["Don't","5","10","15","20","25","30","35","40"
        ,"45","50","55","60","65","70","75","80",
         "85","90","95","100"]
    var percentChosen : Int = 0;
    
    
    //Day of the weekPicker
    @IBOutlet weak var dayPicker: UIPickerView!
    let days = ["Don't","Monday","Tuesday","Wednesday","Thursday","Friday"
        ,"Saturday","Sunday"]
    var dayChosen : Int = 0;
    
    
    
    //IntervalSelector
    var intChosen : Int = 0;
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if(pickerView == percentagePicker){
            return percent[row]
        }
        else if(pickerView == dayPicker){
            return days[row]
        }
        else {
            return dates[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == percentagePicker){
            return percent.count
        }
        else if(pickerView == dayPicker){
            return days.count
        }
        else {
            return dates.count
        }
    }
    
    //This is where we record the picker selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         if(pickerView == percentagePicker){
            percentChosen = row
        }
         else if(pickerView == dayPicker){
            dayChosen = row
        }
         else {
            fixedDateChosen = row
        }
    }
    
    //RADIOS
    @IBOutlet weak var intervalLength: UISegmentedControl!
    
    
    
    
    var newBudgetName : String = ""
    var canChangeFixedDate : Bool = false
    var canChangeInterval : Bool = false
    var canChangeWarning : Bool = false
    @IBAction func confirmChanges(_ sender: Any) {
        newBudgetName = nameField.text!
        
        //If the name was changed
        if (newBudgetName != globalBudget){
            
            //make a copy of the existing budget
            let newBudget = Dummy.user.budgetList[globalBudget]
            
            //put it in the right place
            Dummy.user.budgetList[newBudgetName] = newBudget
            
            //delete the old one
            Dummy.user.budgetList.removeValue(forKey: globalBudget)
            
            //rename!
            globalBudget = newBudgetName
            Dummy.user.budgetList[globalBudget]?.name = newBudgetName
        }
        
        //the percentage date
        if(canChangeWarning){
            Dummy.user.budgetList[globalBudget]?.notificationPercent = Double((percentChosen) * 5)
        }
        
        
        //if it's okay to change the fixed date
        if(canChangeFixedDate){
            Dummy.user.budgetList[globalBudget]?.alwaysResetOn = String(fixedDateChosen)
        }
        
        
        //if it's okay to change the interval settings
        if(canChangeInterval){
            Dummy.user.budgetList[globalBudget]?.resetInterval = String(intervalLength.selectedSegmentIndex)
            Dummy.user.budgetList[globalBudget]?.intervalStartDate = String(dayChosen)
            Dummy.user.budgetList[globalBudget]?.calcInterval()
        }
        
        Dummy.user.budgetList[globalBudget]?.update()
    }
    
    
    //EDITING?
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var button3: UIButton!
    @IBAction func editInterval(_ sender: Any) {
        view3.isHidden = true
        button3.isHidden = true
        button3.isUserInteractionEnabled = false
        canChangeInterval = true
    }
    
    
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var button2: UIButton!
    @IBAction func editFixedDate(_ sender: Any) {
        view2.isHidden = true
        button2.isHidden = true
        button2.isUserInteractionEnabled = false
        canChangeFixedDate = true
    }
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var button1: UIButton!
    @IBAction func editThreshold(_ sender: Any) {
        view1.isHidden = true
        button1.isHidden = true
        button1.isUserInteractionEnabled = false
        canChangeWarning = true
        
    }
    
    
}
