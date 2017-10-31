//
//  SanityUITest.swift
//  SanityUITest
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
    
    func testExample1() {//Test for proper budget reset date
        let app = XCUIApplication()
        app.buttons["New Budget"].tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element
        let textField = element.children(matching: .textField).element
        textField.tap()
        textField.typeText("Budget2")
        element.children(matching: .table).element(boundBy: 1).tap()
        app.buttons["Continue"].tap()
        app.buttons["Cancel"].tap()
        XCTAssert(app.tables.staticTexts["Never"].exists)
    }
    
    func testExample2() {//Test for Succesful Created Budget
        
        let app = XCUIApplication()
        app.buttons["New Budget"].tap()
        
        let textField = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element
        textField.tap()
        textField.typeText("Budget1")
        XCTAssert(app.textFields["Budget1"].exists)
    }
    
    func testExample3() {//Test for Succesful Created Category
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
    
    func testExample4() {//Test for proper budget limit
        
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
    
    func testExample5() {//Test to see if purchase name is stored
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Budget1"]/*[[".cells.staticTexts[\"Budget1\"]",".staticTexts[\"Budget1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Food"]/*[[".cells.staticTexts[\"Food\"]",".staticTexts[\"Food\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["New Purchase"].tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 2)
        let element2 = element.children(matching: .other).element
        let textField = element2.children(matching: .textField).element(boundBy: 0)
        textField.tap()
        textField.typeText("Pizza")
        
        let textField2 = element2.children(matching: .textField).element(boundBy: 1)
        textField2.tap()
        textField2.tap()
        textField2.typeText("12")
        element.tap()
        app.buttons["Confirm"].tap()
        
        XCTAssert(app.tables.staticTexts["Pizza"].exists)
    }
    
    func testExample6() {//Test to see if proper purchase amount is stored
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Budget1"]/*[[".cells.staticTexts[\"Budget1\"]",".staticTexts[\"Budget1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Food"]/*[[".cells.staticTexts[\"Food\"]",".staticTexts[\"Food\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["New Purchase"].tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 2)
        let element2 = element.children(matching: .other).element
        let textField = element2.children(matching: .textField).element(boundBy: 0)
        textField.tap()
        textField.typeText("Pizza")
        
        let textField2 = element2.children(matching: .textField).element(boundBy: 1)
        textField2.tap()
        textField2.tap()
        textField2.typeText("12")
        element.tap()
        app.buttons["Confirm"].tap()
        XCTAssert(app.tables.staticTexts["12.00"].exists)
    }
    
    func testExample7() {//Test to see if x date is stored as x date
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Budget1"]/*[[".cells.staticTexts[\"Budget1\"]",".staticTexts[\"Budget1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Food"]/*[[".cells.staticTexts[\"Food\"]",".staticTexts[\"Food\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["New Purchase"].tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 2)
        let element2 = element.children(matching: .other).element
        let textField = element2.children(matching: .textField).element(boundBy: 0)
        textField.tap()
        textField.typeText("Pizza")
        
        let textField2 = element2.children(matching: .textField).element(boundBy: 1)
        textField2.tap()
        textField2.tap()
        textField2.typeText("12")
        element.tap()
        app.buttons["Confirm"].tap()
        XCTAssert(app.tables.staticTexts["30 Oct 2017"].exists)
    }
    
    func testExample8() {//Test for an existing description field
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Budget1"]/*[[".cells.staticTexts[\"Budget1\"]",".staticTexts[\"Budget1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Food"]/*[[".cells.staticTexts[\"Food\"]",".staticTexts[\"Food\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["New Purchase"].tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 2)
        let element2 = element.children(matching: .other).element
        let textField = element2.children(matching: .textField).element(boundBy: 0)
        textField.tap()
        textField.typeText("Pizza")
        
        let textField2 = element2.children(matching: .textField).element(boundBy: 1)
        textField2.tap()
        textField2.tap()
        textField2.typeText("12")
        element.tap()
        
        let optionalDescriptionTextField = app.textFields["Optional Description"]
        optionalDescriptionTextField.tap()
        optionalDescriptionTextField.typeText("CPMJ")
        element.tap()
        app.buttons["Confirm"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.staticTexts["Pizza"]/*[[".cells.staticTexts[\"Pizza\"]",".staticTexts[\"Pizza\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()
        XCTAssert(app.textFields["Optional Description"].exists)
    }
    
    func testExample9(){//Test for empty description upon creation
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Budget1"]/*[[".cells.staticTexts[\"Budget1\"]",".staticTexts[\"Budget1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Food"]/*[[".cells.staticTexts[\"Food\"]",".staticTexts[\"Food\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["New Purchase"].tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 2)
        let element2 = element.children(matching: .other).element
        let textField = element2.children(matching: .textField).element(boundBy: 0)
        textField.tap()
        textField.typeText("Pizza")
        
        let textField2 = element2.children(matching: .textField).element(boundBy: 1)
        textField2.tap()
        textField2.tap()
        textField2.typeText("12")
        element.tap()
        app.buttons["Confirm"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.staticTexts["Pizza"]/*[[".cells.staticTexts[\"Pizza\"]",".staticTexts[\"Pizza\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()
        XCTAssert(app.textFields["Optional Description"].exists)
    }
    
    func testExample10() {//Test for success in editing budget name
        let app = XCUIApplication()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Budget1"]/*[[".cells.staticTexts[\"Budget1\"]",".staticTexts[\"Budget1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Edit Budget"].tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1)
        let textField = element.children(matching: .other).element.children(matching: .textField).element
        textField.tap()
        textField.typeText("2")
        sleep(1)
        element.tap()
        sleep(1)
        app.buttons["Confirm"].tap()
        sleep(1)
        app.buttons["Back"].tap()
        sleep(1)
        XCTAssert(app.tables.staticTexts["Budget12"].exists)
    }
    
    func testExample11() {//Test for success in editing reset criteria
        let app = XCUIApplication()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Budget1"]/*[[".cells.staticTexts[\"Budget1\"]",".staticTexts[\"Budget1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Edit Budget"].tap()
        app.buttons["Edit Fixed Date Settings?"].tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .picker).element(boundBy: 1).pickerWheels["Don't"].adjust(toPickerWheelValue: "22nd")
        app.buttons["Confirm"].tap()
        app.buttons["Back"].tap()
        XCTAssert(app.tables.staticTexts["22 Nov 2017"].exists)
    }
    
    func testExample12() {//Test for success in editing category name
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Budget1"]/*[[".cells.staticTexts[\"Budget1\"]",".staticTexts[\"Budget1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Food"]/*[[".cells.staticTexts[\"Food\"]",".staticTexts[\"Food\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Edit Category"].tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 2)
        let textField = element.children(matching: .other).element.children(matching: .textField).element(boundBy: 0)
        textField.tap()
        textField.typeText(" hahaha")
        element.tap()
        app.buttons["Confirm"].tap()
        app.buttons["Back"].tap()
        XCTAssert(app.tables.staticTexts["Food hahaha"].exists)
    }
    
    func testExample13() {//Test for success in editing category limit
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Budget1"]/*[[".cells.staticTexts[\"Budget1\"]",".staticTexts[\"Budget1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Food"]/*[[".cells.staticTexts[\"Food\"]",".staticTexts[\"Food\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Edit Category"].tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 2)
        let textField = element.children(matching: .other).element.children(matching: .textField).element(boundBy: 1)
        textField.tap()
        textField.typeText("200")
        element.tap()
        app.buttons["Confirm"].tap()
        app.buttons["Back"].tap()
        XCTAssert(app.tables.staticTexts["200.00"].exists)
    }
    
    func testExample14() {//Test for success in editing transaction name
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Budget1"]/*[[".cells.staticTexts[\"Budget1\"]",".staticTexts[\"Budget1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Food"]/*[[".cells.staticTexts[\"Food\"]",".staticTexts[\"Food\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Pizza"]/*[[".cells.staticTexts[\"Pizza\"]",".staticTexts[\"Pizza\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 2)
        let textField = element.children(matching: .other).element.children(matching: .textField).element(boundBy: 0)
        textField.tap()
        textField.typeText(" Soup")
        element.tap()
        app.buttons["Confirm"].tap()
        XCTAssert(app.tables.staticTexts["Pizza Soup"].exists)
    }
    
    func testExample15() {//Test for success in editing transaction amount
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Budget1"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Food"]/*[[".cells.staticTexts[\"Food\"]",".staticTexts[\"Food\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Pizza"]/*[[".cells.staticTexts[\"Pizza\"]",".staticTexts[\"Pizza\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let textField = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 2).children(matching: .other).element.children(matching: .textField).element(boundBy: 1)
        textField.tap()
        textField.typeText("20")
        
        let optionalDescriptionTextField = app.textFields["Optional Description"]
        optionalDescriptionTextField.tap()
        optionalDescriptionTextField.tap()
        app.buttons["Confirm"].tap()
        XCTAssert(app.tables.staticTexts["20.00"].exists)
    }
    
    func testExample16() {//Test for success in editing transaction date
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Budget1"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Food"]/*[[".cells.staticTexts[\"Food\"]",".staticTexts[\"Food\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Pizza"]/*[[".cells.staticTexts[\"Pizza\"]",".staticTexts[\"Pizza\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.datePickers.pickerWheels["October"].adjust(toPickerWheelValue: "November")
        app.buttons["Confirm"].tap()
        XCTAssert(app.tables.staticTexts["30 Nov 2017"].exists)
    }
    
    func testExample17() {//Test for Succesful Created Budget without categories
        let app = XCUIApplication()
        app.buttons["New Budget"].tap()
        
        let textField = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element
        textField.tap()
        textField.typeText("Budget1")
        XCTAssert(app.textFields["Budget1"].exists)
    }
    
    func testExample18() {//Test for success in editing comments in transactions
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Budget1"]/*[[".cells.staticTexts[\"Budget1\"]",".staticTexts[\"Budget1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Food"]/*[[".cells.staticTexts[\"Food\"]",".staticTexts[\"Food\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Pizza"]/*[[".cells.staticTexts[\"Pizza\"]",".staticTexts[\"Pizza\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.textFields["Optional Description"].tap()
        app.buttons["Confirm"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Pizza"]/*[[".cells.staticTexts[\"Pizza\"]",".staticTexts[\"Pizza\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssert(app.textFields["Optional Description"].exists)
    }
    
    func testExample19() {//Test for having more than one budget
        let app = XCUIApplication()
        app.buttons["New Budget"].tap()
        
        let textField = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element
        textField.tap()
        textField.typeText("Budget4")
        XCTAssert(app.textFields["Budget4"].exists)
    }
    
    func testExample20() {//Test for having more than one category
        let app = XCUIApplication()
        app.tables.cells.containing(.staticText, identifier:"Budget1").staticTexts["Total Spent:"].tap()
        app.buttons["Add Category"].tap()
        
        let element2 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1)
        let element = element2.children(matching: .other).element
        let textField = element.children(matching: .textField).element(boundBy: 0)
        textField.tap()
        textField.typeText("Entertainment")
        
        let textField2 = element.children(matching: .textField).element(boundBy: 1)
        textField2.tap()
        textField2.tap()
        textField2.typeText("50")
        element2.tap()
        app.buttons["Confirm"].tap()
        XCTAssert(app.tables.staticTexts["Entertainment"].exists)
    }
    
    func testExample21() {//Test for having more than one transaction
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Budget1"]/*[[".cells.staticTexts[\"Budget1\"]",".staticTexts[\"Budget1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Food"]/*[[".cells.staticTexts[\"Food\"]",".staticTexts[\"Food\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["New Purchase"].tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 2)
        let element2 = element.children(matching: .other).element
        let textField = element2.children(matching: .textField).element(boundBy: 0)
        textField.tap()
        textField.typeText("Tacos")
        
        let textField2 = element2.children(matching: .textField).element(boundBy: 1)
        textField2.tap()
        textField2.tap()
        textField2.typeText("5")
        element.tap()
        app.buttons["Confirm"].tap()
        
        XCTAssert(app.tables.staticTexts["Tacos"].exists)
    }
    
    func testExample22() {//Test for correct total budget limit
         let app = XCUIApplication()
         sleep(2)
         XCTAssert(app.tables.staticTexts["150.00"].exists)
    }
    
    func testExample23() {//Test for correct total spending in a budget
        let app = XCUIApplication()
        sleep(2)
        XCTAssert(app.tables.staticTexts["25.00"].exists)
    }
    
    func testExample24() {//Test for correct total spent value from a category
        let app=XCUIApplication()
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.staticTexts["Budget1"]/*[[".cells.staticTexts[\"Budget1\"]",".staticTexts[\"Budget1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssert(app.tables.staticTexts["25.00"].exists)
    }
    
    func testExample25() {//Test for selecting an existing budget
        let app = XCUIApplication()
        app.tabBars.buttons["Analytics"].tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .textField).element(boundBy: 0).tap()
        app/*@START_MENU_TOKEN@*/.pickerWheels["Budget2"]/*[[".pickers.pickerWheels[\"Budget2\"]",".pickerWheels[\"Budget2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.adjust(toPickerWheelValue: "Budget1")
        XCTAssert(app.textFields["Budget1"].exists)
    }
    
    func testExample26() {//Test for selecting a proper category given a selected budget
        let app = XCUIApplication()
        app.tabBars.buttons["Analytics"].tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .textField).element(boundBy: 0).tap()
        
        let app2 = app
        app2/*@START_MENU_TOKEN@*/.pickerWheels["Budget2"]/*[[".pickers.pickerWheels[\"Budget2\"]",".pickerWheels[\"Budget2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.adjust(toPickerWheelValue: "Budget1")
        
        let doneButton = app.toolbars.buttons["Done"]
        doneButton.tap()
        element.children(matching: .textField).element(boundBy: 1).tap()
        app2.pickerWheels["Entertainment"].adjust(toPickerWheelValue: "Food")
        doneButton.tap()
         XCTAssert(app.textFields["Food"].exists)
    }
    
    func testExample27() {//Test for entering invalid value while creating a category
        let app = XCUIApplication()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Budget1"]/*[[".cells.staticTexts[\"Budget1\"]",".staticTexts[\"Budget1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Add Category"].tap()
        
        let element2 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1)
        let element = element2.children(matching: .other).element
        let textField = element.children(matching: .textField).element(boundBy: 0)
        textField.tap()
        textField.typeText("Test")
        
        let textField2 = element.children(matching: .textField).element(boundBy: 1)
        textField2.tap()
        textField2.typeText("1.1.1")
        element2.tap()
        XCTAssert(app.textFields["Invalid Number"].exists)
    }
    
    func testExample28() {//Test for entering invalid value while creating a transaction
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Budget1"]/*[[".cells.staticTexts[\"Budget1\"]",".staticTexts[\"Budget1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Food"]/*[[".cells.staticTexts[\"Food\"]",".staticTexts[\"Food\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["New Purchase"].tap()
        
        let element2 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 2)
        let element = element2.children(matching: .other).element
        let textField = element.children(matching: .textField).element(boundBy: 0)
        textField.tap()
        textField.typeText("Test")
        
        let textField2 = element.children(matching: .textField).element(boundBy: 1)
        textField2.tap()
        textField2.tap()
        textField2.typeText("1.1.1")
        element2.tap()
        XCTAssert(app.textFields["Invalid Number"].exists)
    }
    
    func testExample29() {//Test for entering invalid value while editing category
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Budget1"]/*[[".cells.staticTexts[\"Budget1\"]",".staticTexts[\"Budget1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Food"]/*[[".cells.staticTexts[\"Food\"]",".staticTexts[\"Food\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Edit Category"].tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 2)
        let textField = element.children(matching: .other).element.children(matching: .textField).element(boundBy: 1)
        textField.tap()
        textField.typeText("1.1.1")
        element.tap()
        XCTAssert(app.textFields["Invalid Number"].exists)
    }
    
    func testExample30() {//Test for entering invalid value while editing transaction
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Budget1"]/*[[".cells.staticTexts[\"Budget1\"]",".staticTexts[\"Budget1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Food"]/*[[".cells.staticTexts[\"Food\"]",".staticTexts[\"Food\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["20.00"]/*[[".cells.staticTexts[\"20.00\"]",".staticTexts[\"20.00\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let textField = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 2).children(matching: .other).element.children(matching: .textField).element(boundBy: 1)
        textField.tap()
        textField.typeText("1.1.1")
        
        let optionalDescriptionTextField = app.textFields["Optional Description"]
        optionalDescriptionTextField.tap()
        optionalDescriptionTextField.tap()
        XCTAssert(app.textFields["Invalid Number"].exists)
    }
    
}
