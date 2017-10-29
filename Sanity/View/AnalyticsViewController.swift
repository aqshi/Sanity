//
//  AnalyticsViewController.swift
//  Sanity
//
//  Created by Max Wong on 10/14/2017.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import UIKit
import Charts

class AnalyticsViewController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView.tag == 1){
            return Dummy.user.budgetList.count
        }
        else{
            if(BudgetTF.text == ""){}
            else{
                return (Dummy.user.budgetList[selectedBudget]?.categoryList.count)!
            }
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if(pickerView.tag == 2){
            if(BudgetTF.text == ""){}
            else{
                return categoryListHere[row]
            }
        }
        return budgetlistHere[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(pickerView.tag == 1){
            selectedBudget = budgetlistHere[row]
            BudgetTF.text = selectedBudget
            CategoryTF.text = ""
            selectedCat = ""
            let temp = Dummy.user.budgetList[selectedBudget]
            categoryListHere.removeAll()
            for (x,_) in (temp?.categoryList)! {
                categoryListHere.append(x)
            }
        }
        else{
            if(BudgetTF.text == ""){}
            else{
                selectedCat = categoryListHere[row]
                CategoryTF.text = selectedCat;
            }
        }
    }
    @IBOutlet weak var BudgetTF: UITextField!
    
    @IBOutlet weak var CategoryTF: UITextField!
    @IBOutlet weak var chtChart: LineChartView!
    var numbers : [Double] = [] //This is where we are going to store all the numbers. This can be a set of numbers that come from a Realm database, Core data, External API's or where ever else
    @IBAction func budgetTFClicked(_ sender: Any) {
        
        BudgetTF.reloadInputViews();
        
    }
    
    
    
    @IBAction func CategoryTFClicked(_ sender: Any) {
        
        CategoryTF.reloadInputViews()
        
    }
    
    @IBAction func confirmPressed(_ sender: Any) {
        
        if(self.BudgetTF.text == ""){
            
            BudgetTF.placeholder = "Cannot be empty"
            
        }
            
        else if(self.CategoryTF.text == ""){
            
            CategoryTF.placeholder = "Cannot be empty"
            
        }
            
        else{
            
            let tempx = Dummy.user.budgetList[selectedBudget]?.categoryList[selectedCat]?.purchaseList
            
            for(_,y) in tempx!{
                
                numbers.append(y.price!)
                
                print(y)
                
            }
            
            updateGraph()
            
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
        
    }
    
    
    
    @objc func dismissKeyboard(){
        
        view.endEditing(true);
        
    }
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print(Dummy.user)
        
        for (x,_) in Dummy.user.budgetList{
            budgetlistHere.append(x)
        }
        
        createBudgetPicker()
        
        createToolbar()
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    
    
    
    /// This is the button trigger
    
    ///
    
    /// - Parameter sender: Sender
    
    @IBOutlet weak var btnbutton: UIButton!
    
    
    
    
    
    @IBAction func btnbutton(_ sender: Any) {
        
        //let input  = Double(txtTextBox.text!) //gets input from the textbox - expects input as double/int
        
        //numbers.append(input!) //here we add the data to the array.
        
        
        
    }
    
    
    
    func updateGraph(){
        
        var lineChartEntry  = [ChartDataEntry]() //this is the Array that will eventually be displayed on the graph.
        
        
        
        
        
        //here is the for loop
        
        for i in 0..<numbers.count {
            
            
            
            let value = ChartDataEntry(x: Double(i), y: numbers[i]) // here we set the X and Y status in a data chart entry
            
            lineChartEntry.append(value) // here we add it to the data set
            
        }
        
        
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Number") //Here we convert lineChartEntry to a LineChartDataSet
        
        line1.colors = [NSUIColor.blue] //Sets the colour to blue
        
        
        
        let data = LineChartData() //This is the object that will be added to the chart
        
        data.addDataSet(line1) //Adds the line to the dataSet
        
        
        
        
        
        chtChart.data = data //finally - it adds the chart data to the chart and causes an update
        
        chtChart.chartDescription?.text = "My awesome chart" // Here we set the description for the graph
        
    }
    
    
    
}



var selectedBudget: String = ""

var selectedCat: String = ""

var budgetlistHere = [String]()

var categoryListHere = [String]()
