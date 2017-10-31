//
//  DatabaseTests.swift
//  SanityUnitTest
//
//  Created by MaximilianZeng on 10/30/17.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import XCTest
@testable import Sanity
class DatabaseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_GetBudget(){
        let db = DatabaseController()
        DispatchQueue.global().async {
            db.getBudgetObject(userID: "5bfhZ6gicKhmPKCUVxU9fK7b5Xq2")
            let budget = Dummy.user.budgetList["Trojan Budget"]
            XCTAssertEqual(budget?.name, "Trojan Budget")
            XCTAssertEqual(budget?.budgetAmount, 100)
            XCTAssertEqual(budget?.budgetUsed, 5)
            XCTAssertEqual(budget?.notificationPercent, 1)
            XCTAssertEqual(budget?.notificationFrequency, "biweekly")
            XCTAssertEqual(budget?.intervalStartDate, "11 June 2014")
        }
    }
    
    func test_GetCategory(){
        let db = DatabaseController()
        DispatchQueue.global().async {
            db.getCategoryObject(userID: "5bfhZ6gicKhmPKCUVxU9fK7b5Xq2")
            //db.getBudgetObject(userID: "5bfhZ6gicKhmPKCUVxU9fK7b5Xq2")
            XCTAssertEqual(Dummy.user.budgetList["Trojan Budget"]?.categoryList["Food"]?.name, "Food")
            XCTAssertEqual(Dummy.user.budgetList["Trojan Budget"]?.categoryList["Food"]?.amountLimit, 100)
            XCTAssertEqual(Dummy.user.budgetList["Trojan Budget"]?.categoryList["Food"]?.amountUsed, 5)
            XCTAssertEqual(Dummy.user.budgetList["Trojan Budget"]?.categoryList["Food"]?.notificationPercent, 0)
        }
    }
    
    func test_GetPurchase(){
        let db = DatabaseController()
        DispatchQueue.global().async {
            db.getBudgetObject(userID: "5bfhZ6gicKhmPKCUVxU9fK7b5Xq2")
            db.getCategoryObject(userID: "5bfhZ6gicKhmPKCUVxU9fK7b5Xq2")
            db.getPurchaseObject(userID: "5bfhZ6gicKhmPKCUVxU9fK7b5Xq2")
            XCTAssertEqual(Dummy.user.budgetList["Trojan Budget"]?.categoryList["Food"]?.purchaseList["Starbucks"]?.name, "Starbucks")
            XCTAssertEqual(Dummy.user.budgetList["Trojan Budget"]?.categoryList["Food"]?.purchaseList["Starbucks"]?.price, 5)
            XCTAssertEqual(Dummy.user.budgetList["Trojan Budget"]?.categoryList["Food"]?.purchaseList["Starbucks"]?.memo, "Coffee")
            XCTAssertEqual(Dummy.user.budgetList["Trojan Budget"]?.categoryList["Food"]?.purchaseList["Starbucks"]?.date, "30 Oct 2017")
        }
    }
    
    func test_GetUser() {
        let db = DatabaseController()
        DispatchQueue.global().async {
            db.getUserObject(userID: "5bfhZ6gicKhmPKCUVxU9fK7b5Xq2")
            XCTAssertEqual(Dummy.user.name, "Taixiang Zeng")
            XCTAssertEqual(Dummy.user.email, "maxzeng1996@gmail.com")
            XCTAssertEqual(Dummy.user.budgetList["Trojan Budget"]?.name, "Trojan Budget")
            XCTAssertEqual(Dummy.user.budgetList["Trojan Budget"]?.categoryList["Food"]?.name, "Food")
            XCTAssertEqual(Dummy.user.budgetList["Trojan Budget"]?.categoryList["Food"]?.purchaseList["Starbucks"]?.name, "Starbucks")
        }
    }
    
    func test_PushUser() {
        let p1 = Purchase(name: "csci textbook", price: 4.56, date: "30 October 2017", memo: "cs310")
        let p2 = Purchase(name: "itp textbook", price: 13.8, date: "07 November 2017", memo: "itp 342")
        let c1 = Category(name: "Textbook", amountLimit: 500, amountUsed: 0, notificationPercent: 30, purchaseList: ["csci textbook" : p1, "itp textbook": p2])
        let b1 = Budget(name: "Tommy Budget", intervalStartDate: "01 Jan 2007", intervalResetOn: 12, alwaysResetOn: "08 Jul 2015", resetInterval: "1", budgetAmount: 400, budgetUsed:0, notificationPercent: 60, notificationFrequency: "1", recentIntervalReset: "22 Nov 2017", nextIntervalReset: "22 Nov 2017", nextFixedReset: "22 Nov 2017", nextDateReset: "22 Nov 2017", categoryList: ["Text Book" : c1])
        let u1 = User(userID: "5bfhZ6gicKhmPKCUVxU9fK7b5Xq2", name: "Taixiang Zeng", email: "maxzeng1996@gmail.com", budgetList: ["Tommy Budget": b1])
        
        let db = DatabaseController()
        DispatchQueue.global().async {
            db.pushUserToFirebase(user: u1)
            db.getUserObject(userID: "5bfhZ6gicKhmPKCUVxU9fK7b5Xq2")
            XCTAssertEqual(Dummy.user.name, "Taixiang Zeng")
            XCTAssertEqual(Dummy.user.email, "maxzeng1996@gmail.com")
            XCTAssertEqual(Dummy.user.budgetList["Tommy Budget"]?.name, "Tommy Budget")
            XCTAssertEqual(Dummy.user.budgetList["Tommy Budget"]?.categoryList["Textbook"]?.name, "Textbook")
            XCTAssertEqual(Dummy.user.budgetList["Tommy Budget"]?.categoryList["Textbook"]?.purchaseList["csci textbook"]?.name, "csci textbook")
        }
    }
    
}

