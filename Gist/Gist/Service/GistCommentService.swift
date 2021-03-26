//
//  GistCommentService.swift
//  Gist
//
//  Created by Thiago Lourin on 26/03/21.
//  Copyright © 2021 Lourin. All rights reserved.
//

import Foundation

public class GistCommentService {
    
    private let request: GistCommentRequestModel
    
    init(request: GistCommentRequestModel) {
        self.request = request
    }
    
    public func performRequest() {
        APIInstance.get().request(request) { (response) in
            print(response)
        }
    }
}
