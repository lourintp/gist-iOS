//
//  GistCommentViewModel.swift
//  Gist
//
//  Created by Thiago Lourin on 16/04/21.
//  Copyright © 2021 Lourin. All rights reserved.
//

import Foundation

protocol GistCommentViewModelDelegate: class {
    func didLoadGist(response: GistResponseModel?)
    func errorLoadingGist(error: ErrorResponse?)
}

struct GistCommentViewModel {
    
    private var apiClient: APIClientProtocol
    weak var gistLoadDelegate: GistCommentViewModelDelegate?
    
    init() {
        self.apiClient = APIInstance.get()
    }
    
    func fetchGistFrom(id: String) {
        let request = GistGetRequest(gistId: id)
        apiClient.request(request) { (result) in
            switch result {
            case .success(let response):
                self.gistLoadDelegate?.didLoadGist(response: response as? GistResponseModel)
                break
            case .failure(let errorResponse):
                self.gistLoadDelegate?.errorLoadingGist(error: errorResponse)
                break
            }
        }
    }
}
