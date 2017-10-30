//
//  EditCategoryViewController.swift
//  Sanity
//
//  Created by Max Wong on 10/14/2017.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import UIKit

class EditCategoryViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        originalName = (Dummy.user.budgetList[globalBudget]?.categoryList[globalCat]?.name)!
        originalDouble = (Dummy.user.budgetList[globalBudget]?.categoryList[globalCat]?.amountLimit)!
        
        name.text = originalName
        amnt.text = String(format:"%.2f", originalDouble)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func SaveEdits(_ sender: Any) {
        
    }
    
    @IBAction func dismiss(_ sender: Any) {
        view.endEditing(true)
    }
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var amnt: UITextField!
    @IBAction func clear(_ sender: Any) {
        amnt.text = ""
    }
    @IBAction func format(_ sender: Any) {
        let amountDisplay = Double(amnt.text!)
         let formatter = NumberFormatter()
               formatter.numberStyle = .currency
              amnt.text = formatter.string(from: NSNumber(value:amountDisplay!))
          doubletoStore = amountDisplay!
    }
    
    
    var originalName : String = ""
    var originalDouble : Double = 0
    var doubletoStore : Double = 0
    var nametoStore : String = ""
    
    @IBAction func saveAll(_ sender: Any) {
        
        nametoStore = name.text!
        
        //update the category HERE
              Dummy.user.budgetList[globalBudget]?.categoryList[globalCat]?.name = nametoStore
                   Dummy.user.budgetList[globalBudget]?.categoryList[globalCat]?.amountLimit = doubletoStore
            
                   //check if name was changed
                   //if not, we're good!
             if nametoStore == globalCat{
             //do nothing we good!
                    } else {
                        //we need to copy the old to another with the right key
                let cat : Category = (Dummy.user.budgetList[globalBudget]?.categoryList[globalCat])!
                           Dummy.user.budgetList[globalBudget]?.categoryList[nametoStore] = cat
                            //then we have to delete the old one
                             Dummy.user.budgetList[globalBudget]?.categoryList.removeValue(forKey: globalCat)
                    }
        
        globalCat = nametoStore
        Dummy.user2 = Dummy.user
        DispatchQueue.main.async {
            Dummy.dc.pushUserToFirebase(user: Dummy.user)
            print("Updated \(Dummy.user)")
        }
        
          //reloadCat
           let updater = NSNotification.Name("reloadCat")
                 NotificationCenter.default.post(name: updater, object: nil)
        
    }
    
    
    
    
}
