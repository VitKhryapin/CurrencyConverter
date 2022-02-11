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
    var oc = OtherCurrency()
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        vc.loadViewIfNeeded()
        oc = (storyboard.instantiateViewController(withIdentifier: "OtherCurrency") as? OtherCurrency)!
        oc.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        vc = nil
    }
    
    func testSetDefaults() throws {
        let expectation = expectation(description: "Expectation in " + #function)
        vc.currency()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 3, handler: nil)
        if let result = self.vc.defaults.value(forKey: "saleEuro") {
            XCTAssertNotNil(result)
        }
        if let result = self.vc.defaults.value(forKey: "saleRub") {
            XCTAssertNotNil(result)
        }
    }
    
    func testTextFieldAreConnected() throws {
        _ = try XCTUnwrap(vc.tfUSDOutlet , "The Text to reverse UITextField is not connected")
        _ = try XCTUnwrap(vc.tfEUROutlet , "The Text to reverse UITextField is not connected")
        _ = try XCTUnwrap(vc.tfRUBOutlet , "The Text to reverse UITextField is not connected")
        
    }
    
    func testExcludeNumberTF() throws {
        vc.tfUSDOutlet.text = "asd12.sd3"
        let resultTest = "12.3"
        vc.changedExcludeLetterTF(vc.tfUSDOutlet)
        XCTAssertEqual(resultTest, vc.tfUSDOutlet.text)
    }
    
    func testOtherCurrency() throws {
        
        let expectation = expectation(description: "Expectation in " + #function)
        oc.updateArchiev(date: "01.12.2014")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertNotNil(oc.dataSource)
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
