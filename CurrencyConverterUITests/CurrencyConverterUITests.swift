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
        let resultUSD = app.tables["tabelView"].cells.containing(.staticText, identifier:"USD >").children(matching: .textField).element.value
        let resultEUR = app.tables["tabelView"].cells.containing(.staticText, identifier:"EUR >").children(matching: .textField).element.value
        app.tables["tabelView"].cells.containing(.staticText, identifier:"UAH >").children(matching: .textField).element.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards.keys[\"delete\"]",".keys[\"delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap(withNumberOfTaps: 5, numberOfTouches: 1)
        app.tables["tabelView"].cells.containing(.staticText, identifier:"UAH >").children(matching: .textField).element.typeText("asq12dsd32")
        app.staticTexts["Currency Converter"].tap()
        let resultTest = "1232.00"
        XCTAssertEqual(resultTest, app.tables["tabelView"].cells.containing(.staticText, identifier:"UAH >").children(matching: .textField).element.value as! String)
        XCTAssertNotEqual(resultUSD as! String, app.tables["tabelView"].cells.containing(.staticText, identifier:"USD >").children(matching: .textField).element.value as! String)
        XCTAssertNotEqual(resultEUR as! String, app.tables["tabelView"].cells.containing(.staticText, identifier:"EUR >").children(matching: .textField).element.value as! String)
    }
    
    func testBuySellButtons() throws {
        let app = XCUIApplication()
        app.launch()
        let resultUSD = app.tables["tabelView"].cells.containing(.staticText, identifier:"USD >").children(matching: .textField).element.value
        let resultEUR = app.tables["tabelView"].cells.containing(.staticText, identifier:"EUR >").children(matching: .textField).element.value
        XCUIApplication().buttons["Buy"].tap()
        XCTAssertNotEqual(resultUSD as! String, app.tables["tabelView"].cells.containing(.staticText, identifier:"USD >").children(matching: .textField).element.value as! String)
        XCTAssertNotEqual(resultEUR as! String, app.tables["tabelView"].cells.containing(.staticText, identifier:"EUR >").children(matching: .textField).element.value as! String)
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
        XCTAssertNotEqual(app.tables.cells.count, 0)
    }
    
    func testButtonsAddCurrency() throws {
        let app = XCUIApplication()
        app.launch()
        let resultTest = 4
        app/*@START_MENU_TOKEN@*/.staticTexts[" Add Currency"]/*[[".buttons[\" Add Currency\"].staticTexts[\" Add Currency\"]",".buttons[\"addCurrencyOutlet\"].staticTexts[\" Add Currency\"]",".staticTexts[\" Add Currency\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables.staticTexts["RUR"].tap()
        XCTAssertEqual(resultTest,  app.tables["tabelView"].cells.count)
    }
    
    func testViewLandscape() throws {
        let app = XCUIApplication()
        app.launch()
        XCUIDevice.shared.orientation = .landscapeRight
        let resultEUR = app.tables["tabelView"].cells.containing(.staticText, identifier:"EUR >").children(matching: .textField).element.value
        app.tables["tabelView"].cells.containing(.staticText, identifier:"UAH >").children(matching: .textField).element.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards.keys[\"delete\"]",".keys[\"delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap(withNumberOfTaps: 5, numberOfTouches: 1)
        app.tables["tabelView"].cells.containing(.staticText, identifier:"UAH >").children(matching: .textField).element.typeText("999")
        app.staticTexts["Currency Converter"].tap()
        XCTAssertNotEqual(resultEUR as! String, app.tables["tabelView"].cells.containing(.staticText, identifier:"EUR >").children(matching: .textField).element.value as! String)
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
