//
//  CurrencyConverterTests.swift
//  CurrencyConverterTests
//
//  Created by Vitaly Khryapin on 27.01.2022.
//

import XCTest
@testable import CurrencyConverter

class CurrencyConverterTests: XCTestCase {
    var vc: ViewController!
    var nm = NetworkManager()
    var ac = ArchievCurrencyController()
    var oc = OtherCurrencController()
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        vc.loadViewIfNeeded()
        ac = (storyboard.instantiateViewController(withIdentifier: "ArchievCurrencyController") as? ArchievCurrencyController)!
        ac.loadViewIfNeeded()
        oc = (storyboard.instantiateViewController(withIdentifier: "OtherCurrencController") as? OtherCurrencController)!
        oc.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        vc = nil
    }
    
    func testSetDefaults() throws {
        let expectation = expectation(description: "Expectation in " + #function)
        vc.updateCurrency()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 3, handler: nil)
        if let result = self.vc.defaults.value(forKey: "currencyArray") {
            XCTAssertNotNil(result)
        }
    }
    
    
    func testArchievCurrency() throws {
        let expectation = expectation(description: "Expectation in " + #function)
        ac.updateArchiev(date: "01.12.2014")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertNotNil(ac.dataSource)
    }
    
    func testOtherCurrency() throws {
        let cell = oc.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(vc.currencyArray.count, cell)
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
