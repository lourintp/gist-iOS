//
//  GistParsingTests.swift
//  GistTests
//
//  Created by Thiago Lourin on 19/04/21.
//  Copyright © 2021 Lourin. All rights reserved.
//

import XCTest
@testable import Gist

class GistParsingTests: XCTestCase {
    
    private let validGistID = "2710948"
    
    func test_parsingGist_ReturnsGist() throws {
        
        let request = GistGetRequest(gistId: validGistID)
        let sut = APIClientMock()
        
        sut.request(request) { (result) in
            switch (result) {
            case .success(let response):
                let gistResponse = response as! GistResponseModel
                XCTAssertTrue(sut.apiWasExecuted)
                XCTAssertEqual(gistResponse.id, self.validGistID, "ID Should be \(self.validGistID).")
                XCTAssertEqual(gistResponse.created_at, "2012-05-16T14:53:21Z", "Gist creation date should be 2012-05-16T14:53:21Z.")
                XCTAssertEqual(gistResponse.owner.login, "marktabler", "Gist owner should be marktabler.")
            case .failure(_ ):
                XCTFail("Error should not be raised.")
            }
        }
    }
    
    func test_mockingError_ReturnsError() {
        let request = GistGetRequest(gistId: "whateverID")
        let sut = APIClientMock()
        sut.hasError = true
        
        sut.request(request) { (result) in
            switch (result) {
            case .failure(let error):
                XCTAssertTrue(sut.apiWasExecuted)
                XCTAssertNotNil(error)
            case .success(_ ):
                XCTFail("Request shouldn't return success.")
            }
        }
    }
}
