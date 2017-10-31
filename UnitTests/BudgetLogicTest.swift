//
//  BudgetLogicTest.swift
//  SanityUnitTest
//
//  Created by MaximilianZeng on 10/30/17.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import XCTest
@testable import Sanity

class BudgetLogicTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_CalcAmountTotal() {
        let p1 = Purchase(name: "csci textbook", price: 4.56, date: "30 Oct 2017", memo: "ee101")
        let p2 = Purchase(name: "itp textbook", price: 13.8, date: "07 Nov 2017", memo: "itp 342")
        let p3 = Purchase(name: "ee textbook", price: 24.8, date: "07 Jul 2017", memo: "itp 342")
        let p4 = Purchase(name: "laptop", price: 2100, date: "23 Oct 2017", memo: "macbook pro")
        let c1 = Category(name: "Textbook", amountLimit: 500, amountUsed: 0, notificationPercent: 30, purchaseList: ["csci textbook" : p1, "itp textbook": p2, "ee textbook" : p3])
        let c2 = Category(name: "Digital Devices", amountLimit: 5000, amountUsed: 0, notificationPercent: 30, purchaseList: ["laptop" : p4])
        var b1 = Budget(name: "Test Budget", intervalStartDate: "01 Jan 2007", intervalResetOn: 12, alwaysResetOn: "08 Jul 2015", resetInterval: "1", budgetAmount: 400, budgetUsed:0, notificationPercent: 60, notificationFrequency: "1", recentIntervalReset: "22 Nov 2017", nextIntervalReset: "22 Nov 2017", nextFixedReset: "22 Nov 2017", nextDateReset: "22 Nov 2017", categoryList: ["Digital Devices" : c2, "Textbook" : c1])
        
        let budgetAmountTotal = b1.calcTotal()
        
        XCTAssertEqual(budgetAmountTotal, 5500)
    }
    
    func test_CalcAmountUsed() {
        let p1 = Purchase(name: "csci textbook", price: 4.56, date: "30 Oct 2017", memo: "ee101")
        let p2 = Purchase(name: "itp textbook", price: 13.8, date: "07 Nov 2017", memo: "itp 342")
        let p3 = Purchase(name: "ee textbook", price: 24.8, date: "07 Jul 2017", memo: "itp 342")
        let p4 = Purchase(name: "laptop", price: 2100, date: "23 Oct 2017", memo: "macbook pro")
        var c1 = Category(name: "Textbook", amountLimit: 500, amountUsed: 0, notificationPercent: 30, purchaseList: ["csci textbook" : p1, "itp textbook": p2, "ee textbook" : p3])
        var c2 = Category(name: "Digital Devices", amountLimit: 5000, amountUsed: 0, notificationPercent: 30, purchaseList: ["laptop" : p4])
        c1.amountUsed = c1.calcUsed()
        c2.amountUsed = c2.calcUsed()
        var b1 = Budget(name: "Test Budget", intervalStartDate: "01 Jan 2007", intervalResetOn: 12, alwaysResetOn: "08 Jul 2015", resetInterval: "1", budgetAmount: 5500, budgetUsed:0, notificationPercent: 60, notificationFrequency: "1", recentIntervalReset: "22 Nov 2017", nextIntervalReset: "22 Nov 2017", nextFixedReset: "22 Nov 2017", nextDateReset: "22 Nov 2017", categoryList: ["Digital Devices" : c2, "Textbook" : c1])
        b1.budgetUsed = b1.calcUsed()
        
        XCTAssertEqual(b1.budgetUsed, 2143.16)
    }
    
    func test_CalculateNearestDate() {
        let c2 = Category(name: "Digital Devices", amountLimit: 5000, amountUsed: 0, notificationPercent: 30, purchaseList: [String : Purchase]())
        var b1 = Budget(name: "Test Budget", intervalStartDate: "30 Oct 2017", intervalResetOn: 12, alwaysResetOn: "2", resetInterval: "1", budgetAmount: 400, budgetUsed:0, notificationPercent: 60, notificationFrequency: "1", recentIntervalReset: "22 Nov 2017", nextIntervalReset: "22 Nov 2017", nextFixedReset: "22 Nov 2017", nextDateReset: "22 Nov 2017", categoryList: ["Digital Devices" : c2])
        
        b1.calculateReset()
        
        XCTAssertEqual(b1.recentIntervalResetString, "22 Nov 2017")
    }
    
    func test_GetNextWeekday() {
        
        let c2 = Category(name: "Digital Devices", amountLimit: 5000, amountUsed: 0, notificationPercent: 30, purchaseList: [String : Purchase]())
        var b1 = Budget(name: "Test Budget", intervalStartDate: "30 Oct 2017", intervalResetOn: 12, alwaysResetOn: "2", resetInterval: "1", budgetAmount: 400, budgetUsed:0, notificationPercent: 60, notificationFrequency: "1", recentIntervalReset: "22 Nov 2017", nextIntervalReset: "22 Nov 2017", nextFixedReset: "22 Nov 2017", nextDateReset: "22 Nov 2017", categoryList: ["Digital Devices" : c2])
        
        let date = b1.get(direction: .Next, "Tuesday")
        
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: Date())
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "dd-MMM-yyyy"
        // again convert your date to string
        let str = formatter.string(from: date as Date)
        
        XCTAssertEqual(str, "31-Oct-2017")
    }
    
}

