//
//  MockUrlProtocol.swift
//  BonjourCanadaTests
//
//  Created by Jyoti Saini on 24/09/20.
//  Copyright © 2020 Jyoti Saini. All rights reserved.
//

import Foundation

class MockUrlProtocol: URLProtocol {
    static var stubResponseData: Data?
    static var error: Error?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    override func startLoading() {
        if let signUpError = MockUrlProtocol.error {
            self.client?.urlProtocol(self, didFailWithError: signUpError)
        }else {
            self.client?.urlProtocol(self, didLoad: MockUrlProtocol.stubResponseData ?? Data())
        }
        self.client?.urlProtocolDidFinishLoading(self)
    }
    override func stopLoading() {
    }
}

