//
//  GistCommentService.swift
//  Gist
//
//  Created by Thiago Lourin on 26/03/21.
//  Copyright © 2021 Lourin. All rights reserved.
//

import Foundation

protocol GistCommentServiceDelegate: class {
    func didLoadGistComment(_ response: GistResponseModel?)
    func errorLoadingGistComment(error: ErrorResponse?)
}

public final class GistCommentService {
    
    private let request: GistCommentRequestModel
    weak var delegate: GistCommentServiceDelegate?
    
    init(request: GistCommentRequestModel) {
        self.request = request
    }
    
    public func performRequest() {
        APIInstance.get().request(request) { (result) in
            switch result {
            case .success(let response):
                self.delegate?.didLoadGistComment(response as? GistResponseModel)
            case .failure(let error):
                self.delegate?.errorLoadingGistComment(error: error)
            }            
        }
    }
}
