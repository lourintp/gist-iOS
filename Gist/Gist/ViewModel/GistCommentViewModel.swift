//
//  GistCommentViewModel.swift
//  Gist
//
//  Created by Thiago Lourin on 16/04/21.
//  Copyright © 2021 Lourin. All rights reserved.
//

import Foundation

public protocol GistCommentViewModelDelegate: class {
    func didLoadGist()
    func errorLoadingGist()
    func didSendComment()
    func errorSendingComment(_ error: String)
}

internal final class GistCommentViewModel {
    
    private var apiClient: APIClientProtocol
    weak var gistLoadDelegate: GistCommentViewModelDelegate?
    internal var gist: GistResponseModel?
    internal var error: ErrorResponse?
    
    init() {
        self.apiClient = APIInstance.get()
    }
    
    func fetchGistFrom(id: String) {
        let request = GistGetRequest(gistId: id)
        apiClient.request(request) { (result) in
            switch result {
            case .success(let response):
                self.gist = response as? GistResponseModel
                self.gistLoadDelegate?.didLoadGist()
                break
            case .failure(let errorResponse):
                self.error = errorResponse
                self.gistLoadDelegate?.errorLoadingGist()
                break
            }
        }
    }
    
    func sendComment(_ id: String, _ comment: String) {
        if (comment.isEmpty) {
            self.gistLoadDelegate?.errorSendingComment("Comment must be filled!")
            return
        }
        
        let request = GistCommentRequestModel(gistID: id, comment: comment)
        apiClient.request(request) { (result) in
            switch result {
            case .success(let response):
                if let gistResponseModel = response as? GistCommentResponseModel {
                    print(gistResponseModel)
                    self.gistLoadDelegate?.didSendComment()
                    return
                }
                self.gistLoadDelegate?.errorSendingComment("Unknown error sending comment.")
            case .failure(let error):
                self.gistLoadDelegate?.errorSendingComment(error?.error ?? "Unknown error sending comment.")
            }
        }
    }
}
