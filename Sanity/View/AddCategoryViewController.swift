//
//  AddCategoryViewController.swift
//  Sanity
//
//  Created by Max Wong on 10/14/2017.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import UIKit

class AddCategoryViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    
    
    var doubletoStore : Double = 0
    @IBAction func hideKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func clear(_ sender: Any) {
        amountField.text = ""
        doubletoStore = 0
    }
    
    @IBAction func format(_ sender: Any) {
        let amountDisplay = Double(amountField.text!)
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        amountField.text = formatter.string(from: NSNumber(value:amountDisplay!))
        doubletoStore = amountDisplay!
    }
  
    
    @IBAction func saveData(_ sender: Any) {
        let cat = Category(
            name: nameField.text! ,
            amountLimit: doubletoStore,
            amountUsed: 0,
            notificationPercent: (Dummy.user.budgetList[globalBudget]!.notificationPercent),
            purchaseList: [String : Purchase]()
        )
        
        //add it to the current budget
        Dummy.user.budgetList[globalBudget]?.categoryList[nameField.text!] = cat
        
        //Update the previous page, the Budget Page
        let updater = NSNotification.Name("reloadBud")
        NotificationCenter.default.post(name: updater, object: nil)
    }
    
    

}
