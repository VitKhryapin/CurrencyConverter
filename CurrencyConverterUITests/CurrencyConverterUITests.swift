//
//  CurrencyConverterUITests.swift
//  CurrencyConverterUITests
//
//  Created by Vitaly Khryapin on 27.01.2022.
//

import XCTest
@testable import CurrencyConverter



class CurrencyConverterUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func testTextFields() throws {
        let app = XCUIApplication()
        app.launch()
        let resultEUR = app.textFields["tfEUROutlet"].value
        let resultRUB = app.textFields["tfRUBOutlet"].value
        app.textFields["tfUSDOutlet"].tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards.keys[\"delete\"]",".keys[\"delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.textFields["tfUSDOutlet"].typeText("asq12ds. d32")
        let resultTest = "12.32"
        XCTAssertEqual(resultTest, app.textFields["tfUSDOutlet"].value as! String)
        XCTAssertNotEqual(resultEUR as! String, app.textFields["tfEUROutlet"].value as! String)
        XCTAssertNotEqual(resultRUB as! String, app.textFields["tfRUBOutlet"].value as! String)
    }
    
    func testBuySellButtons() throws {
        let app = XCUIApplication()
        app.launch()
        let resultEUR = app.textFields["tfEUROutlet"].value
        let resultRUB = app.textFields["tfRUBOutlet"].value
        app.textFields["tfUSDOutlet"].tap()
        app.textFields["tfUSDOutlet"].typeText("000")
        XCUIApplication().buttons["Buy"].tap()
        XCTAssertNotEqual(resultEUR as! String, app.textFields["tfEUROutlet"].value as! String)
        XCTAssertNotEqual(resultRUB as! String, app.textFields["tfRUBOutlet"].value as! String)
    }
    
    func testButtonsShare() throws {
        let app = XCUIApplication()
        app.launch()
        app.buttons["Share"].tap()
        app/*@START_MENU_TOKEN@*/.collectionViews/*[[".otherElements[\"ActivityListView\"].collectionViews",".collectionViews"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Copy"].otherElements.containing(.image, identifier:"copy").children(matching: .other).element.children(matching: .other).element.tap()
    }
    
    func testButtonsArchiev() throws {
        let app = XCUIApplication()
        app.launch()
        app/*@START_MENU_TOKEN@*/.staticTexts["National Bank Exchange Rate"]/*[[".buttons[\"National Bank Exchange Rate\"].staticTexts[\"National Bank Exchange Rate\"]",".buttons[\"buttonResetOutlet\"].staticTexts[\"National Bank Exchange Rate\"]",".staticTexts[\"National Bank Exchange Rate\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Currency"].buttons["Item"].tap()
        let alert = app.alerts["\n\n\n\n\n\n\n\n"]
        alert.datePickers/*@START_MENU_TOKEN@*/.pickerWheels["2017"]/*[[".pickers.pickerWheels[\"2017\"]",".pickerWheels[\"2017\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeDown()
        alert.scrollViews.otherElements.buttons["Ok"].tap()
        XCTAssertNotEqual(app.tables.cells.count, 0)
    }
    
    func testViewLandscape() throws {
        let app = XCUIApplication()
        app.launch()
        XCUIDevice.shared.orientation = .landscapeRight
        let resultEUR = app.textFields["tfEUROutlet"].value
        app.textFields["tfUSDOutlet"].tap()
        app.textFields["tfUSDOutlet"].typeText("000")
        app.staticTexts["Currency Converter"].tap()
        XCTAssertNotEqual(resultEUR as! String, app.textFields["tfEUROutlet"].value as! String)
        XCUIApplication().buttons["Buy"].tap()
        app.buttons["Share"].tap()
        app/*@START_MENU_TOKEN@*/.collectionViews/*[[".otherElements[\"ActivityListView\"].collectionViews",".collectionViews"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Copy"].otherElements.containing(.image, identifier:"copy").children(matching: .other).element.children(matching: .other).element.tap()
        app/*@START_MENU_TOKEN@*/.navigationBars["Plain Text"]/*[[".otherElements[\"ActivityListView\"].navigationBars[\"Plain Text\"]",".navigationBars[\"Plain Text\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Close"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["National Bank Exchange Rate"]/*[[".buttons[\"National Bank Exchange Rate\"].staticTexts[\"National Bank Exchange Rate\"]",".buttons[\"buttonResetOutlet\"].staticTexts[\"National Bank Exchange Rate\"]",".staticTexts[\"National Bank Exchange Rate\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Currency"].buttons["Item"].tap()
        let alert = app.alerts["\n\n\n\n\n\n\n\n"]
        alert.datePickers/*@START_MENU_TOKEN@*/.pickerWheels["2017"]/*[[".pickers.pickerWheels[\"2017\"]",".pickerWheels[\"2017\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeDown()
        alert.scrollViews.otherElements.buttons["Ok"].tap()
        XCTAssertNotEqual(app.tables.cells.count, 0)
        XCUIDevice.shared.orientation = .portrait
        
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
