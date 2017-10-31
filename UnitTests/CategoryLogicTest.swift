//
//  CategoryLogicTest.swift
//  SanityUnitTest
//
//  Created by MaximilianZeng on 10/30/17.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import XCTest
@testable import Sanity

class CategoryLogicTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        let p1 = Purchase(name: "csci textbook", price: 4.56, date: "30 Oct 2017", memo: "ee101")
        let p2 = Purchase(name: "itp textbook", price: 13.8, date: "07 Nov 2017", memo: "itp 342")
        let p3 = Purchase(name: "ee textbook", price: 24.8, date: "07 Jul 2017", memo: "itp 342")
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_CalcUsed() {
        let p1 = Purchase(name: "csci textbook", price: 4.56, date: "30 Oct 2017", memo: "ee101")
        let p2 = Purchase(name: "itp textbook", price: 13.8, date: "07 Nov 2017", memo: "itp 342")
        let p3 = Purchase(name: "ee textbook", price: 24.8, date: "07 Jul 2017", memo: "itp 342")
        var c1 = Category(name: "Textbook", amountLimit: 500, amountUsed: 0, notificationPercent: 30, purchaseList: ["csci textbook" : p1, "itp textbook": p2, "ee textbook" : p3])
        XCTAssertEqual(c1.calcUsed(), 43.16)
    }
    
    func test_clearpurchases() {
        let p1 = Purchase(name: "csci textbook", price: 4.56, date: "30 Oct 2017", memo: "ee101")
        let p2 = Purchase(name: "itp textbook", price: 13.8, date: "07 Nov 2017", memo: "itp 342")
        let p3 = Purchase(name: "ee textbook", price: 24.8, date: "07 Jul 2017", memo: "itp 342")
        var c1 = Category(name: "Textbook", amountLimit: 500, amountUsed: 0, notificationPercent: 30, purchaseList: ["csci textbook" : p1, "itp textbook": p2, "ee textbook" : p3])
        XCTAssertEqual(c1.calcUsed(), 43.16)
        c1.clearPurchases()
        XCTAssertEqual(c1.purchaseList, [:])
    }
    
}

