//
//  Purchase.swift
//  Sanity
//
//  Created by Max Wong on 10/13/2017.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import UIKit

class Purchase: NSObject {
    //var purchaseID: Int?
    var name: String?
    var price: Double?
    var date: String?
    var memo: String?
    //    var category: Category?
    //    var budget: Budget?
    
    init(name: String, price: Double, date: String, memo: String){
        self.name = name
        self.price = price
        //print the Date! Figure it out
        self.date = date
        self.memo = memo
    }
    
    

}
