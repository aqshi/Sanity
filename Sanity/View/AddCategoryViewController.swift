//
//  AddCategoryViewController.swift
//  Sanity
//
//  Created by Max Wong on 10/14/2017.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import UIKit

class AddCategoryViewController: UIViewController {
    
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //nameField.text = "New Category"
        amountField.text = "$0.00"
        // Do any additional setup after loading the view.
        if(globalColor == 1){
            self.view.backgroundColor = UIColor .darkGray
        }
        else{
            self.view.backgroundColor = UIColor .white
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.confirmButton.alpha = 0
        self.cancelButton.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.3, options: .curveEaseOut, animations: {
            self.confirmButton.alpha = 1
            self.cancelButton.alpha = 1
        }, completion: nil)
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
    
    @IBAction func clearNameField(_ sender: Any) {
        nameField.text = ""
    }
    
    @IBAction func clear(_ sender: Any) {
        amountField.text = ""
        doubletoStore = 0
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
  
    
    @IBAction func saveData(_ sender: Any) {
        
        if (nameField.text! == ""){
            nameField.text = "New Category"
        }
        
        var catName = nameField.text
        var dupeCounter = 1
        
        while (Dummy.user.budgetList[globalBudget]?.categoryList.keys.contains(catName!))!{
            catName = nameField.text! + String(dupeCounter)
            dupeCounter += 1
        }
        
        
        let cat = Category(
            name: catName! ,
            amountLimit: doubletoStore,
            amountUsed: 0,
            notificationPercent: (Dummy.user.budgetList[globalBudget]!.notificationPercent),
            purchaseList: [String : Purchase]()
        )
        
        //add it to the current budget
        Dummy.user.budgetList[globalBudget]?.categoryList[catName!] = cat
        Dummy.user2 = Dummy.user
        DispatchQueue.main.async {
            Dummy.dc.pushUserToFirebase(user: Dummy.user)
        }
        //Update the previous page, the Budget Page
        let updater = NSNotification.Name("reloadBud")
        NotificationCenter.default.post(name: updater, object: nil)
    }
    
    

}
