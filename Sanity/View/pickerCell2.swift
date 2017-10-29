//
//  pickerCell1.swift
//  Sanity
//
//  Created by Eliseo Monzon on 10/14/17.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import UIKit

class pickerCell2: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var dayPicker: UIPickerView!
    @IBOutlet weak var interval: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.dayPicker.delegate = self
        self.dayPicker.dataSource = self
    }
    let days = ["Don't","Monday","Tuesday","Wednesday","Thursday","Friday"
                ,"Saturday","Sunday"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return days[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return days.count
    }
    
    //This is where we record the picker selection and the interval
    var dayChosen : Int = 0;
    var intChosen : Int = 0;
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        dayChosen = row
    }
    @IBAction func recordSelection(_ sender: Any) {
        intChosen = interval.selectedSegmentIndex
    }
    
    
    
    
}

