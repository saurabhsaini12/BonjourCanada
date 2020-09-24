//
//  WebserviceTests.swift
//  BonjourCanadaTests
//
//  Created by Jyoti Saini on 24/09/20.
//  Copyright © 2020 Jyoti Saini. All rights reserved.
//

import XCTest
@testable import BonjourCanada

class WebserviceTests: XCTestCase {
    
    var sut: WebService!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockUrlProtocol.self]
        let urlSession = URLSession(configuration:  config)
        sut = WebService(urlString:"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json", urlSession: urlSession)
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        MockUrlProtocol.stubResponseData = nil
        MockUrlProtocol.error = nil
    }
    func testWebService_WhenRequestData_ReturnsSuccess() {
        //Arrange
         
        let expectation = self.expectation(description: "Initial Fetch Request Response expectation")
        
        let jsonString = "{\"title\":\"About Canada\",\"rows\":[{\"title\":\"Beavers\",\"description\":\"Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony\",\"imageHref\":\"http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg\"}]}"
        
        MockUrlProtocol.stubResponseData = jsonString.data(using:.utf8)
        //Act
        sut.fetchInitialDetails() { (aboutMeResponseModel, error) in
           //Assert
            XCTAssertNotNil(aboutMeResponseModel?.rows, "The rows returned by the response model should have been not nil")
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testWebService_WhenRecievedDifferentJsonResponse_ErrorTookPlace() {
        
        let expectation = self.expectation(description: "fetchInitialDetailExpectation expectation for a reponse that contains a different json structure")
        
        let jsonString = "{\"titla\":\"About Canada\",\"rowa\":[{\"title\":\"Beavers\",\"description\":\"Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony\",\"imageHref\":\"http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg\"}]}"
        
        MockUrlProtocol.stubResponseData = jsonString.data(using:.utf8)
        //Act
        sut.fetchInitialDetails() { (aboutMeResponseModel, error) in
           //Assert
            XCTAssertNil(aboutMeResponseModel, "the reponse model for the request containing  unknown json response should have been nil")
            XCTAssertEqual(error, AboutMeError.invalidResponseModel,"the fetchinital method did not return expected error")
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testWebService_WhenEmptyUrlStringProvided_ErrorTookPlace() {
        
        let expectation = self.expectation(description: "an empty url string expectation")
        
        sut = WebService(urlString: "")

        //Act
        sut.fetchInitialDetails() { (aboutMeResponseModel, error) in
           //Assert
            XCTAssertNil(aboutMeResponseModel, "When invalidReuestUrlStringTakePlace the reponse model must be nil")
            XCTAssertEqual(error, AboutMeError.invalidRequestUrlString,"the fetchinital did not return an invalidRequestString error")
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 5)
    }
    func testWebService_WhenRequestFails_ReturnErrorMessageDescription() {
            
            let expectation = self.expectation(description: "a failed reuest expectation")
            let errorDescription = "A localized description of an error"
        MockUrlProtocol.error = AboutMeError.failedRequest(description: errorDescription)  
              
            //Act
            sut.fetchInitialDetails() { (aboutMeResponseModel, error) in
               //Assert
                
                XCTAssertEqual(error, AboutMeError.failedRequest(description: errorDescription),"the fetchinital method did not return an expected error for a failed request")
                expectation.fulfill()
            }
            self.wait(for: [expectation], timeout: 5)
        }
}
