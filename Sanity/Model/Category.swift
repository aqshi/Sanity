//
//  Category.swift
//  Sanity
//
//  Created by Max Wong on 10/13/2017.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import UIKit

struct Category {
    //var categoryID: Int
    var name: String
    var amountLimit: Double
    var amountUsed: Double
    var notificationPercent: Double
    var purchaseList = [String : Purchase]()
    
    init(name: String, amountLimit: Double, amountUsed: Double, notificationPercent: Double,
         purchaseList: [String : Purchase]){

        //var categoryID = ""
        self.name = name
        self.amountLimit = amountLimit
        self.amountUsed = amountUsed
        self.notificationPercent = notificationPercent
        self.purchaseList = purchaseList
    }
    
    
    
    mutating func calcUsed() -> Double {
        self.amountUsed = 0
        for(String , Purchase) in purchaseList{
            amountUsed = amountUsed + Purchase.price!
        }
        return amountUsed
    }
}
