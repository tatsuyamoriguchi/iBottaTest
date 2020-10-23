//
//  iBottaTestTests.swift
//  iBottaTestTests
//
//  Created by Tatsuya Moriguchi on 10/19/20.
//  Copyright © 2020 Tatsuya Moriguchi. All rights reserved.
//

import XCTest
@testable import iBottaTest

class iBottaTestTests: XCTestCase {
    
    var systemUnderTest: ViewController!
    
    override func setUp() {
        super.setUp()
        systemUnderTest = ViewController()
        
    }
    
    
    override func tearDown() {
        systemUnderTest = nil
        super.tearDown()
    }
    
    func testReadJSONFile() {
        XCTAssertNotNil(ViewController.readJSONFromFile)
        
        
    }
    
    
    
    
    
  }
