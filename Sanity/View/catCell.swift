//
//  catCell.swift
//  Sanity
//
//  Created by Eliseo Monzon on 10/14/17.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import UIKit

class catCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.nameField.delegate = self as? UITextFieldDelegate
        self.budgetField.delegate = self as? UITextFieldDelegate
    }
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var budgetField: UITextField!
    
    
    //Store the inputed values
    var name : String = ""
    var budg : Double = 0
    func store(){
        name = nameField.text!
        budg = doubletoStore
    }
  
    
    //KeyboardLogic//KeyboardLogic//KeyboardLogic//KeyboardLogic
    //KeyboardLogic//KeyboardLogic//KeyboardLogic//KeyboardLogic
    //KeyboardLogic//KeyboardLogic//KeyboardLogic//KeyboardLogic
    
    @IBAction func clearField(_ sender: Any) {
        budgetField.text = ""
    }
    
    var doubletoStore : Double = 0
    @IBAction func formatNumbers(_ sender: Any) {
        var amountDisplay = Double(budgetField.text!)
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        budgetField.text = formatter.string(from: NSNumber(value:amountDisplay!))
        doubletoStore = amountDisplay!
    }
    
    
}
