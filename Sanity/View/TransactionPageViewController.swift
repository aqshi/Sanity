//
//  TransactionPageViewController.swift
//  Sanity
//
//  Created by Max Wong on 10/14/2017.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import UIKit

class TransactionPageViewController: UIViewController {
    
    @IBOutlet weak var transactionNameLabel: UILabel!
    @IBOutlet weak var transactionAmountLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        myDate.datePickerMode = UIDatePickerMode.date
        
        transactionNameLabel.text = NSLocalizedString("transactionNameTag", comment: "Tag for name label")
        
        transactionAmountLabel.text = NSLocalizedString("transactionAmountLabel", comment: "Tag for amount label")
        confirmButton.setTitle(NSLocalizedString("transactionCreationConfirmTag", comment: "Tag for confirm button"), for: .normal)
        
        cancelButton.setTitle(NSLocalizedString("transactionCreationCancelTag", comment: "Tag for cancel button"), for: .normal)
        
        if(globalColor == 1){
            self.view.backgroundColor = UIColor .darkGray
        }
        else{
            self.view.backgroundColor = UIColor .white
        }
        //First we need to populate with stuff already there
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.confirmButton.alpha = 0
        self.cancelButton.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.3, options: .curveEaseOut, animations: {
            self.confirmButton.alpha = 1
            self.cancelButton.alpha = 1
        }, completion: nil)
        nameField.text = Dummy.user.budgetList[globalBudget]?.categoryList[globalCat]?.purchaseList[globalPurchase]?.name
        memoField.text = Dummy.user.budgetList[globalBudget]?.categoryList[globalCat]?.purchaseList[globalPurchase]?.memo
        amountField.text = String(format:"%.2f",(Dummy.user.budgetList[globalBudget]?.categoryList[globalCat]?.purchaseList[globalPurchase]?.price)!)
        doubletoStore = (Dummy.user.budgetList[globalBudget]?.categoryList[globalCat]?.purchaseList[globalPurchase]?.price)!
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
        
        let ADString = amountField.text!
        let ADParts = ADString.components(separatedBy: ".")
        if (ADParts.count <= 2 && ADString.range(of: "..") == nil) {
            amountField.text = formatter.string(from: NSNumber(value:amountDisplay!))
            doubletoStore = amountDisplay!
        }
        else {
            amountField.text = "Invalid Number"
            doubletoStore = 0
        }
        
    }
    
    
    //Store the Changes permanently
    @IBAction func saveChanges(_ sender: Any) {
        var nametoStore : String = ""
        var memotoStore : String = ""
        nametoStore = nameField.text!
        memotoStore = memoField.text!
        if(nametoStore == "") {
            return
        }
        recorddate(myDate)
        
        //crate purchase
        let purchase = Purchase(name: nametoStore , price: doubletoStore ,date: selectedDate, memo: memotoStore)
       
        //add it to dummy
    Dummy.user.budgetList[globalBudget]?.categoryList[globalCat]?.purchaseList[nametoStore] = purchase
        
        //remove the old one
        if nametoStore != globalPurchase {
                   Dummy.user.budgetList[globalBudget]?.categoryList[globalCat]?.purchaseList.removeValue(forKey: globalPurchase)
                  }
        for(String, _) in (Dummy.user.budgetList){
            for(String, _) in (Dummy.user.budgetList[String]?.categoryList)! {
                Dummy.user.budgetList[globalBudget]?.categoryList[String]?.calcUsed()
            }
            Dummy.user.budgetList[String]?.update()
        }
        Dummy.user2 = Dummy.user
        //reset the global Purchase
        globalPurchase = nametoStore
        DispatchQueue.main.async {
            Dummy.dc.pushUserToFirebase(user: Dummy.user)
            print("Updated \(Dummy.user)")
        }
    }
    
    
    
   

}
