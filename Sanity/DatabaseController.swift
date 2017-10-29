//
//  DatabaseController.swift
//  Sanity
//
//  Created by Max Wong on 10/14/2017.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseDatabase

class DatabaseController: NSObject {
    var ref: DatabaseReference!
    typealias finishedBudget = () -> ()
    typealias finishedCategory = () -> ()
    typealias finishedPurchase = (Bool) -> ()
    typealias finished = (Bool) -> Void

//    var semaphore = DispatchSemaphore(value:1)
//    var semaphore2 = DispatchSemaphore(value:1)
    //var semaphore2 = DispatchSemaphore(value:1)
    override init() {
        ref = Database.database().reference()
    }
    
    func getBudgetObject(userID: String) {
        print("Get Budget Object")

        ref = Database.database().reference().child("Users").child(userID)
        ref.observe(DataEventType.value, with: { (snapshot) in
            if let getData = snapshot.value as? [String:Any] {
//                let _name = getData["Name"] as! String
//                let _email = getData["Email"] as! String
                self.ref.observeSingleEvent(of: .value, with: { (snapshot) in
                    if snapshot.hasChild(("Budgets")){
                        self.ref = Database.database().reference().child("Users").child(userID).child("Budgets")
                        self.ref.observe(.value, with: { snapshot in
                            if snapshot.value is NSNull {
                                print("not found")
                            }
                            else {
                                for child in snapshot.children {
                                    let snap = child as! DataSnapshot
                                    if snap.value != nil {
                                        let dict = snap.value as! [String: Any]
                                        let bName = dict["name"] as! String
                                        let startDate = dict["startDate"] as! String
                                        let resetOn = dict["resetOn"] as! Int
                                        let alwaysResetOn = dict["alwaysResetOn"] as! String
                                        let resetInterval = dict["resetInterval"] as! String
                                        let budgetAmount = dict["budgetAmount"] as! Double
                                        let budgetUsed = dict["budgetUsed"] as! Double
                                        let notificationPercent = dict["notificationPercent"] as! Double
                                        let notificationFrequency = dict["notificationFrequency"] as! String
                                        let categoryArray = [String : Category]()
                                        let newBudget = Budget(name: bName, intervalStartDate: startDate, intervalResetOn: resetOn, alwaysResetOn: alwaysResetOn, resetInterval: resetInterval, budgetAmount: budgetAmount, budgetUsed: budgetUsed, notificationPercent: notificationPercent, notificationFrequency: notificationFrequency, categoryList: categoryArray)
                                        Dummy.user.budgetList[bName] = newBudget
                                    }
                                }
                            }
                        })
                    }
                })
            }

        })
    }
    
    func getCategoryObject(userID: String) {
        print("Get Category Object")
        
        ref = Database.database().reference().child("Users").child(userID)
        ref.observe(DataEventType.value, with: { (snapshot) in
            if let getData = snapshot.value as? [String:Any] {
                self.ref.observeSingleEvent(of: .value, with: { (snapshot) in
                    if snapshot.hasChild(("Budgets")){
                        self.ref = Database.database().reference().child("Users").child(userID).child("Budgets")
                        self.ref.observe(.value, with: { snapshot in
                            if snapshot.value is NSNull {
                                print("not found")
                            } else {
                                for child in snapshot.children {
                                    let snap = child as! DataSnapshot
                                    if snap.value != nil {
                                        let dict = snap.value as! [String: Any]
                                        let bName = dict["name"] as! String
                                        self.ref.child(bName).observeSingleEvent(of: .value, with: { (snapshot) in
                                            if snapshot.hasChild(("categories")){
                                                self.ref = Database.database().reference().child("Users").child(userID).child("Budgets").child(bName).child("categories")
                                                self.ref.observe(.value, with: { snapshot in
                                                    if snapshot.value is NSNull {
                                                        print("not found")
                                                    } else {
                                                        for child in snapshot.children {
                                                            let snap = child as! DataSnapshot
                                                            if snap.value != nil {
                                                                let dict = snap.value as! [String: Any]
                                                                let cName = dict["name"] as! String
                                                                let amountUsed = dict["amountUsed"] as! Double
                                                                let amountLimit = dict["amountLimit"] as! Double
                                                                let cNotificationPercent = dict["notificationPercent"] as! Double
                                                                let purchaseArray = [String : Purchase]()
                                                                let newCategory = Category(name: cName, amountLimit: amountLimit, amountUsed: amountUsed, notificationPercent: cNotificationPercent,purchaseList: purchaseArray)
                                                                Dummy.user.budgetList[bName]?.categoryList[cName] = newCategory
                                                            }
                                                        }
                                                    }
                                                })
                                            }
                                        })
                                    }
                                }
                            }
                        })
                    }
                })
            }
        })
        //getPurchaseObject(userID: userID)
    }
                
    func getPurchaseObject(userID: String)  {
        print("Get Purchase Object")
        ref = Database.database().reference().child("Users").child(userID)
        ref.observe(DataEventType.value, with: { (snapshot) in
            if let getData = snapshot.value as? [String:Any] {
//                let _name = getData["Name"] as! String
//                let _email = getData["Email"] as! String
                self.ref.observeSingleEvent(of: .value, with: { (snapshot) in
                    if snapshot.hasChild(("Budgets")){
                        
                        self.ref = Database.database().reference().child("Users").child(userID).child("Budgets")
                        self.ref.observe(.value, with: { snapshot in
                            if snapshot.value is NSNull {
                                print("not found")
                            } else {
                                
                                for child in snapshot.children {
                                    let snap = child as! DataSnapshot
                                    if snap.value != nil {
                                        let dict = snap.value as! [String: Any]
                                        let bName = dict["name"] as! String
                                        self.ref.child(bName).observeSingleEvent(of: .value, with: { (snapshot) in
                                            if snapshot.hasChild(("categories")){
                                                self.ref = Database.database().reference().child("Users").child(userID).child("Budgets").child(bName).child("categories")
                                                self.ref.observe(.value, with: { snapshot in
                                                    if snapshot.value is NSNull {
                                                        print("not found")
                                                    } else {
                                                        
                                                        for child in snapshot.children {
                                                            let snap = child as! DataSnapshot
                                                            if snap.value != nil {
                                                                let dict = snap.value as! [String: Any]
                                                                let cName = dict["name"] as! String
                                                                self.ref.child(cName).observeSingleEvent(of: .value, with: { (snapshot) in
                                                                    if snapshot.hasChild(("purchases")){
                                                                        self.ref = Database.database().reference().child("Users").child(userID).child("Budgets").child(bName).child("categories").child(cName).child("purchases")
                                                                        self.ref.observe(.value, with: { snapshot in
                                                                            if snapshot.value is NSNull {
                                                                                print("not found")
                                                                            } else {
                                                                                
                                                                                for child in snapshot.children {
                                                                                    let snap = child as! DataSnapshot
                                                                                    if snap.value != nil {
                                                                                        let dict = snap.value as! [String: Any]
                                                                                        let pName = dict["name"] as! String
                                                                                        let price = dict["price"] as! Double
                                                                                        let date = dict["date"] as! String
                                                                                        let memo = dict["memo"] as! String
                                                                                        let newPurchase = Purchase(name: pName, price: price, date: date, memo: memo)
                                                                                        
                                                                                        Dummy.user.budgetList[bName]?.categoryList[cName]?.purchaseList[pName] = newPurchase
                                                                                    }
                                                                                }
                                                                            }
                                                                        })
                                                                    }
                                                                })
                                                            }
                                                        }
                                                    }
                                                })
                                            }
                                        })
                                    }
                                }
                            }
                        })
                    }
                })
            }
        })
        print("End Purchase Object")
    }
    func getUserObject(userID: String){
        print("Get User Object")
        self.ref = Database.database().reference().child("Users").child(userID)
        self.ref.observe(DataEventType.value, with: { (snapshot) in
            if let getData = snapshot.value as? [String:Any] {
                let _name = getData["Name"] as! String
                let _email = getData["Email"] as! String
                let budgetArray = [String : Budget]()
                Dummy.user.email = _email
                Dummy.user.name = _name
                Dummy.user.userID = userID
                Dummy.user.budgetList = budgetArray
            }
        })
        getBudgetObject(userID: userID)
        getCategoryObject(userID: userID)
        getPurchaseObject(userID: userID)

    }
    
    func addBudget(newBudget: Budget) {
        Dummy.user.budgetList[newBudget.name] = newBudget
    }
    func addCategory(budgetName: String, newCategory: Category) {
        Dummy.user.budgetList[budgetName]?.categoryList[newCategory.name] = newCategory
    }
    func addPurchase(budgetName: String, categoryName: String, newPurchase: Purchase) {
        Dummy.user.budgetList[budgetName]?.categoryList[categoryName]?.purchaseList[newPurchase.name!] = newPurchase
    }
    func updateBudget(newBudget: Budget) {
        Dummy.user.budgetList[newBudget.name] = newBudget
    }
    func updateCategory(budgetName: String, newCategory: Category) {
        Dummy.user.budgetList[budgetName]?.categoryList[newCategory.name] = newCategory
    }
    func updatePurchase(budgetName: String, categoryName: String, newPurchase: Purchase) {
        Dummy.user.budgetList[budgetName]?.categoryList[categoryName]?.purchaseList[newPurchase.name!] = newPurchase
    }
    func removeBudget(newBudget: Budget) {
        Dummy.user.budgetList.removeValue(forKey: newBudget.name)
    }
    func removeCategory(budgetName: String, newCategory: Category) {
        Dummy.user.budgetList[budgetName]?.categoryList.removeValue(forKey: newCategory.name)
    }
    func removePurchase(budgetName: String, categoryName: String, newPurchase: Purchase) {
        Dummy.user.budgetList[budgetName]?.categoryList[categoryName]?.purchaseList.removeValue(forKey: newPurchase.name!)
    }
    func pushUserToFirebase(user: User){
        DispatchQueue.global().async {
            print("Push")
            self.ref = Database.database().reference().child("Users").child(user.userID)
            let userData = ["Email": user.email, "Name": user.name]
            self.ref.setValue(userData)
            var purchaseData = [String : Any]()
            var categoryData = [String : Any]()
            var cName = ""
            var pName = ""
            for(budgetName, budgetObject) in user.budgetList {
                print("B")
                for(categoryName, categoryObject) in (user.budgetList[budgetName]?.categoryList)! {
                    cName = categoryName
                    for(purchaseName, purchaseObject) in (user.budgetList[budgetName]?.categoryList[categoryName]?.purchaseList)! {
                        pName = purchaseName
                        purchaseData = ["name": purchaseObject.name, "price": purchaseObject.price, "date": purchaseObject.date, "memo": purchaseObject.memo] as [String : Any]
                    }
                    categoryData = ["name":categoryObject.name, "amountLimit":categoryObject.amountLimit, "amountUsed": categoryObject.amountUsed, "notificationPercent": categoryObject.notificationPercent] as [String : Any]
                }
                let budgetData = ["name": budgetObject.name, "startDate": budgetObject.intervalStartDate, "resetOn": budgetObject.intervalResetOn, "alwaysResetOn": budgetObject.alwaysResetOn, "resetInterval": budgetObject.resetInterval, "budgetAmount": budgetObject.budgetAmount, "budgetUsed": budgetObject.budgetUsed, "notificationPercent": budgetObject.notificationPercent, "notificationFrequency": budgetObject.notificationFrequency] as [String : Any]
                
                self.ref.child("Budgets").child(budgetName).setValue(budgetData)
                
                for(categoryName, categoryObject) in (user.budgetList[budgetName]?.categoryList)! {
                    print("C")
                    cName = categoryName
                    categoryData = ["name":categoryObject.name, "amountLimit":categoryObject.amountLimit, "amountUsed": categoryObject.amountUsed, "notificationPercent": categoryObject.notificationPercent] as [String : Any]
                    self.ref.child("Budgets").child(budgetName).child("categories").child(cName).setValue(categoryData)
                }
                print("Data \(user)")
                
                for(categoryName, categoryObject) in (user.budgetList[budgetName]?.categoryList)! {
                    cName = categoryName
                    for(purchaseName, purchaseObject) in (user.budgetList[budgetName]?.categoryList[cName]?.purchaseList)! {
                        pName = purchaseName
                        purchaseData = ["name": purchaseObject.name, "price": purchaseObject.price, "date": purchaseObject.date, "memo": purchaseObject.memo] as [String : Any]
                        self.ref.child("Budgets").child(budgetName).child("categories").child(cName).child("purchases").child(pName).setValue(purchaseData)
                    }
                }
            }
        }
    }

//    func addBudget(name: String, startDate: String, resetDay: Int, resetDate: String, resetInterval: String,
//                   budgetAmount: Double, budgetUsed: Double, notificationPercent: Double,
//                   notificationFrequency: String) {
//
//        let budgetData = ["Name": name, "StartDate": startDate, "ResetDay": resetDay, "ResetDate": resetDate, "ResetInterval": resetInterval, "BudgetAmount": budgetAmount, "BudgetUsed": budgetUsed, "NotificationPercent": notificationPercent,
//                          "NotificationFrequency": notificationFrequency] as [String : Any]
//
//        ref.child("Users").child(User.userID!).child("Budgets").childByAutoId().updateChildValues(budgetData)
//
//        print("Add Budget End")
//    }
   
//    func dummyfunc (){
//        self.getUserObject(userID:Dummy.user.userID, completionHandler: {(Bool) in
//            self.getBudgetObject(userID: Dummy.user.userID, completionHandler: {() in
//                self.getCategoryObject(userID: Dummy.user.userID, completionHandler: {() in
//                    self.getPurchaseObject(userID: Dummy.user.userID, completionHandler: {(Bool) in
//
//                    })
//                })
//            })
//        })
//    }
    
//    func addPurchaseToArray(pName:String, price:Double, date:String, memo: String, completion: @escaping(Array<Purchase>) -> ()) {
//
//        let newPurchase = Purchase(name: pName, price: price, date: date, memo: memo)
//        self.purchaseArray.append(newPurchase)
//        completion(self.purchaseArray)
//        //semaphore.signal()
//    }
//
//    func addCategoryToArray(cName:String, amountLimit:Double, amountUsed:Double, cNotificationPercent:Double,
//                            purchaseList:Array<Purchase>, completion: @escaping(Array<Category>) -> ()) {
//        //semaphore.wait()
//        let newCategory = Category(name: cName, amountLimit: amountLimit, amountUsed: amountUsed, notificationPercent: cNotificationPercent,purchaseList: self.purchaseArray)
//        self.categoryArray.append(newCategory)
//        completion(self.categoryArray)
//        //semaphore2.signal()
//    }
//
//    func addBudgetToArray(newBudget: Budget, completion: @escaping(Array<Budget>) -> ()) {
//        //semaphore2.wait()
//        self.budgetArray.append(newBudget)
//        completion(self.budgetArray)
//    }
//
//
//    func addBudget(name: String, startDate: String, resetDay: Int, resetDate: String, resetInterval: String,
//                   budgetAmount: Double, budgetUsed: Double, notificationPercent: Double,
//                   notificationFrequency: String, categoryList: Array<Category>) {
//        print("Add Budget")
//        let tempCategory = [Category]()
//        let newBudget = Budget(name: name, startDate: startDate, resetDay: resetDay, resetDate: resetDate, resetInterval: resetInterval, budgetAmount: budgetAmount, budgetUsed: budgetUsed, notificationPercent: notificationPercent, notificationFrequency: notificationFrequency, categoryList: tempCategory)
//        Dummy.user.budgetList.append(newBudget)
//        pushUserToFirebase(user: Dummy.user)
//    }
//
//    func addCategory() {
//
//    }

    
//
//
//    func getUserBudgets(userID: String, completion: @escaping(Array<String>) -> ()) {
//        ref = Database.database().reference().child("Users").child(userID).child("Budgets")
//        ref.observe(.value, with: { snapshot in
//            if snapshot.value is NSNull {
//                print("not found")
//            } else {
//                for child in snapshot.children {
//                    let snap = child as! DataSnapshot
//                    if snap.value != nil {
//                        self.budgetArray.append(snap.key)
////                        let dict = snap.value as! [String: Any]
////                        let name = dict["Name"] as! String
////                        budgetArray.append(name)
//                    } else {
//                        print("bad snap")
//                    }
//                }
//                completion(self.budgetArray)
//            }
//        })
//    }
//
//    func getBudget(budgetID: String) -> Budget{
//        print("Get Budget")
//        var budgetObject = Budget()
//        ref = Database.database().reference().child("Users").child(User.userID!).child("Budgets").child(budgetID)
//        ref?.observe(DataEventType.value, with: { (snapshot) in
//            if let getData = snapshot.value as? [String:Any] {
//                print(getData)
//                let _name = getData["Name"] as? String
//                let _startDate = getData["StartDate"] as? String
//                let _resetDay = getData["ResetDay"] as? Int
//                let _resetDate = getData["ResetDate"] as? String
//                let _resetInterval = getData["ResetInterval"] as? String
//                let _budgetAmount = getData["BudgetAmount"] as? Double
//                let _budgetUsed = getData["BudgetUsed"] as? Double
//                let _notificationPercent  = getData["NotificationPercent"] as? Double
//                let _notificationFrequency  = getData["NotificationFrequency"] as? String
//                budgetObject = Budget(budgetID: budgetID, name: _name!, startDate: _startDate!, resetDay: _resetDay!, resetDate: _resetDate!, resetInterval: _resetInterval!, budgetAmount: _budgetAmount!, budgetUsed: _budgetUsed!, notificationPercent: _notificationPercent!, notificationFrequency: _notificationFrequency!)
//
//            }
//        })
//        return budgetObject
//    }
//
//
}
