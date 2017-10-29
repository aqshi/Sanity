//
//  TransactionPageViewController.swift
//  Sanity
//
//  Created by Max Wong on 10/14/2017.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import UIKit

class TransactionPageViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //First we need to populate with stuff already there
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameField.text = Dummy.user.budgetList[globalBudget]?.categoryList[globalCat]?.purchaseList[globalPurchase]?.name
        memoField.text = Dummy.user.budgetList[globalBudget]?.categoryList[globalCat]?.purchaseList[globalPurchase]?.memo
        amountField.text = String(format:"%.2f",(Dummy.user.budgetList[globalBudget]?.categoryList[globalCat]?.purchaseList[globalPurchase]?.price)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismiss(_ sender: Any) {
        view.endEditing(true)
    }
    
    //datePicker//datePicker//datePicker//datePicker//datePicker//datePicker
    @IBOutlet weak var myDate: UIDatePicker!
    var selectedDate : String = ""
    @IBAction func recorddate(_ sender: Any) {
        myDate.datePickerMode = UIDatePickerMode.date
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        selectedDate = dateFormatter.string(from: myDate.date)
    }
    
    @IBOutlet weak var memoField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    var doubletoStore : Double = 0
    
    @IBAction func clearfield(_ sender: Any) {
        amountField.text = ""
        doubletoStore = (Dummy.user.budgetList[globalBudget]?.categoryList[globalCat]?.purchaseList[globalPurchase]!.price)!
    }
    
    @IBAction func format(_ sender: Any) {
        let amountDisplay = Double(amountField.text!)
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        amountField.text = formatter.string(from: NSNumber(value:amountDisplay!))
        doubletoStore = amountDisplay!
    }
    
    
    //Store the Changes permanently
    @IBAction func saveChanges(_ sender: Any) {
        var nametoStore : String = ""
        var memotoStore : String = ""
        nametoStore = nameField.text!
        memotoStore = memoField.text!
        recorddate(myDate)
        
        //crate purchase
        let purchase = Purchase(name: nametoStore , price: doubletoStore ,date: selectedDate, memo: memotoStore)
       
        //add it to dummy
    Dummy.user.budgetList[globalBudget]?.categoryList[globalCat]?.purchaseList[nametoStore] = purchase
        
        //remove the old one
        if nametoStore != globalPurchase {
                   Dummy.user.budgetList[globalBudget]?.categoryList[globalCat]?.purchaseList.removeValue(forKey: globalPurchase)
                  }
        //reset the global Purchase
        globalPurchase = nametoStore
    }
    
    
    
   

}
