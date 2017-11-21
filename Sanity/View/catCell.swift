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
        //nameField.text = "New Category"
        budgetField.text = "$0.00"
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
        let amountDisplay = Double(budgetField.text!)
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        
        let ADString = budgetField.text!
        let ADParts = ADString.components(separatedBy: ".")
        if (ADParts.count <= 2 && ADString.range(of: "..") == nil ) {
            budgetField.text = formatter.string(from: NSNumber(value:amountDisplay!))
            doubletoStore = amountDisplay!
        }
        else {
            budgetField.text = "Invalid Number"
            doubletoStore = 0
        }
    }
    
    func textIsValidCurrencyFormat(text: String) -> Bool {
        var isValidCurrencyFormat = false
        
        var numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.currency
        var number = numberFormatter.number(from: text)
        
        if number != nil {
            let numberParts = text.components(separatedBy: ".")
            if numberParts.count == 2 {
                let decimalArray = Array(numberParts[1])
                if decimalArray.count <= 2 {
                    if text == text.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) {
                        isValidCurrencyFormat = true
                    }
                }
            } else {
                if text == text.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) {
                    isValidCurrencyFormat = true
                }
            }
            
        }
        
        return isValidCurrencyFormat
    }
    
    
}
