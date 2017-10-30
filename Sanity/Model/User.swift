//
//  User.swift
//  Sanity
//
//  Created by Max Wong on 10/13/2017.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import UIKit
import UserNotifications

struct User {
    var userID: String
    var name: String
    var email: String
    var budgetList = [String : Budget]()
    
    init() {
        self.userID = ""
        self.name = ""
        self.email = ""
        self.budgetList = [String: Budget]()
    }
    
    init(userID: String, name: String, email: String, budgetList: [String : Budget]) {
        self.userID = userID
        self.name = name
        self.email = email
        self.budgetList = budgetList
        
    }
    
    static func purchaseOverLimitNotification(Budgetname: String, Categoryname: String, AmountLeft: Double, timeRemain: String, Repeat: String){
        DispatchQueue.main.async{
            let content = UNMutableNotificationContent()
            let budgetn = Budgetname
            let categoryn = Categoryname
            let amoutleft = String(AmountLeft)
            let timeremain = timeRemain
            content.title = "Spending Over Limit under category " + categoryn + " in Budget " + budgetn
            content.body = "Left " + amoutleft + " dollars and reset day on " + timeremain
            content.badge = 1
            //let dateComponents = NSDateComponents()
            //dateComponents.day = 4
            //dateComponents.month = 5
            //let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
            if(Repeat == "0"){
                
            }
            else if(Repeat == "1"){
                print("11111111111111111")
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval:5, repeats:false)
                let request = UNNotificationRequest(identifier:"noti", content:content, trigger:trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            }
            else if(Repeat == "2"){
                print("22222222222222222")
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval:61, repeats:true)
                let request = UNNotificationRequest(identifier:"noti", content:content, trigger:trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            }
        }
    }
    
    
}
