//
//  SanityUITest.swift
//  SanityUnitTests
//
//  Created by Austin Shi on 10/30/17.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import XCTest

class SanityUITest: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample2() {
        
        let app = XCUIApplication()
        app.buttons["New Budget"].tap()
        
        let textField = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element
        textField.tap()
        textField.typeText("Budget1")
        app.buttons["Continue"].tap()
        app.buttons["Cancel"].tap()
        
        //XCTAssert(app.tables.cells.containing(.staticText, identifier:"Budget1").staticTexts["01 Jan 9999"].exists)
        
        
        
    }
    
    
    func testExample3() {//Test for Succesful Created Budget
        
        let app = XCUIApplication()
        app.buttons["New Budget"].tap()
        
        let textField = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element
        textField.tap()
        textField.typeText("Budget1")
        XCTAssert(app.textFields["Budget1"].exists)
        
    }
    func testExample4() {//Test for Succesful Created Category
        
        let app = XCUIApplication()
        app.tables.cells.containing(.staticText, identifier:"Budget1").staticTexts["Total Spent:"].tap()
        app.buttons["Add Category"].tap()
        
        let element2 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1)
        let element = element2.children(matching: .other).element
        let textField = element.children(matching: .textField).element(boundBy: 0)
        textField.tap()
        textField.typeText("Food")
        
        let textField2 = element.children(matching: .textField).element(boundBy: 1)
        textField2.tap()
        textField2.tap()
        textField2.typeText("100")
        element2.tap()
        app.buttons["Confirm"].tap()
        XCTAssert(app.tables.staticTexts["Food"].exists)
        
    }
    func testExample5() {//Test for proper budget limit
        
        let app = XCUIApplication()
        app.tables.cells.containing(.staticText, identifier:"Budget1").staticTexts["Total Spent:"].tap()
        app.buttons["Add Category"].tap()
        
        let element2 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1)
        let element = element2.children(matching: .other).element
        let textField = element.children(matching: .textField).element(boundBy: 0)
        textField.tap()
        textField.typeText("Food")
        
        let textField2 = element.children(matching: .textField).element(boundBy: 1)
        textField2.tap()
        textField2.tap()
        textField2.typeText("100")
        element2.tap()
        app.buttons["Confirm"].tap()
        XCTAssert(app.tables.staticTexts["100.00"].exists)
        
    }
}
