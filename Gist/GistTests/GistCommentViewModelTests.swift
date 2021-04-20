//
//  GistCommentViewModelTests.swift
//  GistTests
//
//  Created by Thiago Lourin on 20/04/21.
//  Copyright © 2021 Lourin. All rights reserved.
//

import XCTest
@testable import Gist

class GistCommentViewModelTests: XCTestCase, GistCommentViewModelDelegate {
    
    private var expectation: XCTestExpectation!
    private let fetchExpectation = "fetchExpectation"
    private let commentExpectation = "commentExpectation"
    private var sut: APIClientMock!
    private var errorMessage = ""
    
    func test_fetchGistById_ReturnsGist() {
        expectation = expectation(description: fetchExpectation)
        sut = APIClientMock()
        sut.hasError = false
        
        let viewModel = GistCommentViewModel(apiClient: sut)
        viewModel.gistLoadDelegate = self
        viewModel.fetchGistFrom(id: "anyID")
        waitForExpectations(timeout: 3)
        
        XCTAssertNotNil(viewModel.gist)
        XCTAssertEqual(viewModel.gist?.id, "2710948")
        XCTAssertNil(viewModel.error)
    }
    
    func test_fetchGistByIdMockingError_ReturnsError() {
        expectation = expectation(description: fetchExpectation)
        sut = APIClientMock()
        sut.hasError = true
        
        let viewModel = GistCommentViewModel(apiClient: sut)
        viewModel.gistLoadDelegate = self
        viewModel.fetchGistFrom(id: "anyID")
        waitForExpectations(timeout: 3)
        
        XCTAssertNil(viewModel.gist)
        XCTAssertNotNil(viewModel.error)
        XCTAssertFalse(viewModel.error?.error?.isEmpty ?? "".isEmpty)
    }
    
    func test_sendComment_ReturnsSuccess() {
        expectation = expectation(description: commentExpectation)
        
        sut = APIClientMock()
        sut.hasError = false
        
        let viewModel = GistCommentViewModel(apiClient: sut)
        viewModel.gistLoadDelegate = self
        viewModel.sendComment("anyID", "anyComment")
        waitForExpectations(timeout: 3)
        
        XCTAssertNil(viewModel.error)
        XCTAssertNotNil(viewModel.gistCommentResponse)
    }
    
    func test_sendEmptyComment_ReturnsError() {
        expectation = expectation(description: commentExpectation)
        
        sut = APIClientMock()
        sut.hasError = false
        
        let viewModel = GistCommentViewModel(apiClient: sut)
        viewModel.gistLoadDelegate = self
        viewModel.sendComment("anyId", "")
        waitForExpectations(timeout: 3)
        
        XCTAssertEqual(self.errorMessage, "Comment must be filled!")
        XCTAssertNil(viewModel.error)
        
        self.errorMessage = ""
        XCTAssertTrue(self.errorMessage.isEmpty)
    }

    func didLoadGist() {
        expectation.fulfill()
    }
    
    func errorLoadingGist() {
        expectation.fulfill()
    }
    
    func didSendComment() {
        expectation.fulfill()
    }
    
    func errorSendingComment(_ error: String) {
        errorMessage = error
        expectation.fulfill()
    }
    
}
