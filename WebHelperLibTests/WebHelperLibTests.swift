//
//  WebHelperLibTests.swift
//  WebHelperLibTests
//
//  Created by Hushan on 11/4/19.
//  Copyright © 2019 Hushan M Khan. All rights reserved.
//

import XCTest
@testable import WebHelperLib

class WebHelperLibTests: XCTestCase {

    var mWebHelperLib : WebHelperLib!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mWebHelperLib = WebHelperLib()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    
    func testAdd() {
        XCTAssertEqual(mWebHelperLib.add(a: 1, b: 1), 2)
    }
    
    func testMultiply() {
        XCTAssertEqual(mWebHelperLib.multiply(a: 2, b: 2), 4)
    }
    
    
}
