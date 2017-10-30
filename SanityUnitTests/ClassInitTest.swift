//
//  ClassInitTest.swift
//  SanityUnitTests
//
//  Created by MaximilianZeng on 10/29/17.
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
