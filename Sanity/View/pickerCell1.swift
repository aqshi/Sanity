//
//  pickerCell1.swift
//  Sanity
//
//  Created by Eliseo Monzon on 10/14/17.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import UIKit

class pickerCell1: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var datePicker: UIPickerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.text = NSLocalizedString("pickerCellOneTitleTag", comment: "Tag for title of pickerCell1")
        self.datePicker.delegate = self
        self.datePicker.dataSource = self
    }
    let days = ["Don't","1st","2nd","3rd","4th","5th","6th","7th","8th"
    ,"9th","10th","11th","12th","13th","14th","15th","16th",
     "17th","18th","19th","20th","21st","22nd","23rd","24th","25th",
     "26th","27th","28th","29th","30th","31st"]

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return days[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return days.count
    }
    
    //This is where we record the picker selection
    var dateChosen : Int = 0;
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        dateChosen = row
    }
    
    

}
