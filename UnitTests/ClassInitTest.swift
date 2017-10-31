//
//  ClassInitTest.swift
//  UnitTests
//
//  Created by Austin Shi on 10/30/17.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import XCTest
@testable import Sanity

class ClassInitTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit_Purchase() {
        let p1 = Purchase(name: "Starbucks", price: 4.56, date: "20171030", memo: "Zombie Frapp")
        
        XCTAssertEqual(p1.name, "Starbucks")
        XCTAssertEqual(p1.price, 4.56)
        XCTAssertEqual(p1.date, "20171030")
        XCTAssertEqual(p1.memo, "Zombie Frapp")
    }
    
    func testInit_Category() {
        let p1 = Purchase(name: "Starbucks", price: 4.56, date: "20171030", memo: "Zombie Frapp")
        let p2 = Purchase(name: "Five Guys", price: 13.8, date: "20171107", memo: "Double Bun")
        let purchases = [p1, p2]
        let c1 = Category(name: "Movie", amountLimit: 500, amountUsed: 0, notificationPercent: 30, purchaseList: ["First Purchase" : p1, "Second Purchase": p2])
        
        XCTAssertEqual(c1.name, "Movie")
        XCTAssertEqual(c1.amountLimit, 500)
        XCTAssertEqual(c1.amountUsed, 0)
        XCTAssertEqual(c1.notificationPercent, 30)
        XCTAssertEqual(c1.purchaseList["First Purchase"]?.name, "Starbucks")
        XCTAssertEqual(c1.purchaseList["Second Purchase"]?.memo, "Double Bun")
    }
    
    func testInit_Budget() {
        let p1 = Purchase(name: "csci textbook", price: 4.56, date: "30 October 2017", memo: "cs310")
        let p2 = Purchase(name: "itp textbook", price: 13.8, date: "07 November 2017", memo: "itp 342")
        let c1 = Category(name: "Textbook", amountLimit: 500, amountUsed: 0, notificationPercent: 30, purchaseList: ["csci textbook" : p1, "itp textbook": p2])
        let b1 = Budget(name: "Tommy Budget", intervalStartDate: "01 Jan 2007", intervalResetOn: 12, alwaysResetOn: "08 Jul 2015", resetInterval: "1", budgetAmount: 400, budgetUsed:0, notificationPercent: 60, notificationFrequency: "1", recentIntervalReset: "22 Nov 2017", nextIntervalReset: "22 Nov 2017", nextFixedReset: "22 Nov 2017", nextDateReset: "22 Nov 2017", categoryList: ["Text Book" : c1])
        
        XCTAssertEqual(b1.name, "Tommy Budget")
        XCTAssertEqual(b1.intervalStartDate, "01 Jan 2007")
        XCTAssertEqual(b1.intervalResetOn, 12)
        XCTAssertEqual(b1.alwaysResetOn, "08 Jul 2015")
        XCTAssertEqual(b1.resetInterval, "1")
        XCTAssertEqual(b1.categoryList["Text Book"]?.name, "Textbook")
        XCTAssertEqual(b1.categoryList["Text Book"]?.purchaseList["csci textbook"]?.memo, "cs310")
        XCTAssertEqual(b1.categoryList["Text Book"]?.purchaseList["itp textbook"]?.memo, "itp 342")
    }
    
    func testInit_User() {
        let u1 = User(userID: "234", name: "Leftover System", email: "leftoversystems@gmail.com", budgetList: [String: Budget]())
        
        XCTAssertEqual(u1.userID, "234")
        XCTAssertEqual(u1.name, "Leftover System")
        XCTAssertEqual(u1.email, "leftoversystems@gmail.com")
    }
    
    func testInit_Dummy() {
        XCTAssertEqual(Dummy.user.userID, "")
        XCTAssertEqual(Dummy.user2.userID, "")
        XCTAssertEqual(Dummy.user.name, "")
        XCTAssertEqual(Dummy.user2.name, "")
        XCTAssertEqual(Dummy.user.email, "")
        XCTAssertEqual(Dummy.user2.email, "")
    }
    
}
