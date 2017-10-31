//
//  SanityUITests.swift
//  SanityUITests
//
//  Created by MaximilianZeng on 10/30/17.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import XCTest

class SanityUITests: XCTestCase {
        
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

    
    
    func testBudgetCreation(){
        
        let app = XCUIApplication()
        app.buttons["New Budget"].tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element
        let textField = element.children(matching: .textField).element
        textField.tap()
        textField.typeText("Trojan Budget")
        //element.children(matching: .picker).element.pickerWheels["Don't"].tap()
        //app.tables.cells.containing(.staticText, identifier:"Reset Every:")/*@START_MENU_TOKEN@*/.pickerWheels["Don't"]/*[[".pickers.pickerWheels[\"Don't\"]",".pickerWheels[\"Don't\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        print("Break1")
        if app.buttons["Continue"].isHittable {
            app.buttons["Continue"].tap()
            if app.buttons["Cancel"].isHittable {
                app.buttons["Cancel"].tap()
            }
            else {
                let coordinate: XCUICoordinate = app.buttons["Cancel"].coordinate(withNormalizedOffset: CGVector(dx:0.0, dy:0.0))
                coordinate.tap()
            }
        }
        else {
            let coordinate: XCUICoordinate = app.buttons["Continue"].coordinate(withNormalizedOffset: CGVector(dx:0.0, dy:0.0))
            coordinate.tap()
            if app.buttons["Cancel"].isHittable {
                app.buttons["Cancel"].tap()
            }
            else {
                let coordinate: XCUICoordinate = app.buttons["Cancel"].coordinate(withNormalizedOffset: CGVector(dx:0.0, dy:0.0))
                coordinate.tap()
            }
        }
        print("Break2")
//        if app.buttons["Cancel"].isHittable {
//               app.buttons["Cancel"].tap()
//        }
//        else {
//            let coordinate: XCUICoordinate = app.buttons["Cancel"].coordinate(withNormalizedOffset: CGVector(dx:0.0, dy:0.0))
//            coordinate.tap()
//        }
        print("Break3")
        //XCTAssertEqual(app.tableRows.count, 1)
        XCTAssert(app.staticTexts["Trojan Budget"].exists)
        //XCTAssert(app.tables.staticTexts["Trojan Budget"].exists)
    }
    
    func testBudgetCreationCancel() {
        
        let app = XCUIApplication()
        app.buttons["New Budget"].tap()
        
        let textField = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element
        textField.tap()
        textField.typeText("Trojan Budget")
        if app.buttons["Cancel"].isHittable {
            app.buttons["Cancel"].tap()
        }
        else {
            let coordinate: XCUICoordinate = app.buttons["Cancel"].coordinate(withNormalizedOffset: CGVector(dx:0.0, dy:0.0))
            coordinate.tap()
        }
        
        XCTAssertEqual(app.tableRows.count, 0 )
        //XCTAssertEqual(app.tables.otherElements["MESSAGES"].exists)
    }
}
