//
//  AboutCanadaControllerTest.swift
//  BonjourCanadaTests
//
//  Created by Jyoti Saini on 25/09/20.
//  Copyright © 2020 Jyoti Saini. All rights reserved.
//

import XCTest
@testable import BonjourCanada

class AboutCanadaControllerTest: XCTestCase {
    var sut : AboutCanadaViewController!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = AboutCanadaViewController.init()
        sut.loadViewIfNeeded()
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut =  nil
    }
  
    func testAboutCanada_hasNavigationBarButtonItem() {

        XCTAssertNotNil(sut.navigationItem.rightBarButtonItem)
    }

    func testAboutCanada_HasRightBarButtonItem_WithTarget_CorrectlyAssigned() {

        if let rightBarButtonItem = self.sut.navigationItem.rightBarButtonItem {

            XCTAssertNotNil(rightBarButtonItem.target)
            XCTAssert(rightBarButtonItem.target === self.sut)
        }
        else {

            XCTAssertTrue(false)
        }
    }
    
    func testAboutCanada_HasRightBarButtonItem_WithActionMethod_CorrectlyAssigned() {

        if let rightBarButtonItem = self.sut.navigationItem.rightBarButtonItem {

            XCTAssertTrue(rightBarButtonItem.action?.description == "onRefresh")
        }
        else {

            XCTAssertTrue(false)
        }
    }

}
