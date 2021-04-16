//
//  GistGetService.swift
//  Gist
//
//  Created by Thiago Lourin on 16/04/21.
//  Copyright © 2021 Lourin. All rights reserved.
//

import Foundation

public final class GistGetService: BaseServiceProtocol {
    
    private let request: GistGetRequest
    
    init(request: GistGetRequest) {
        self.request = request
    }
    
    func performRequest() {
        APIInstance.get().request(request) { (response) in
            print(response)
        }
    }
}
