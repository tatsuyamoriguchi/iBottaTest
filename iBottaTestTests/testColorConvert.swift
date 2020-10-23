//
//  testColorConvert.swift
//  iBottaTestTests
//
//  Created by Tatsuya Moriguchi on 10/23/20.
//  Copyright © 2020 Tatsuya Moriguchi. All rights reserved.
//

import XCTest
@testable import iBottaTest

class testColorConvert: XCTestCase {

     var systemUnderTest: ColorConvert!
    
    override func setUp() {
        super.setUp()
        systemUnderTest = ColorConvert()
        
    }
    
    
    override func tearDown() {
        systemUnderTest = nil
        super.tearDown()
    }

    func test_hexStringToUIColor() {
        
        // 1. Given
        let hex = "#000000"
        let alphaValue = 1.0
        // 2. When
        let result = systemUnderTest?.hexStringToUIColor(hex: hex, alphaValue: alphaValue)
        // 3. Then
        
        XCTAssertEqual(result, UIColor(red: 0, green: 0, blue: 0, alpha: 1.0), "hexStringToColor test failed")
    }


}
