//
//  GistGetRequest.swift
//  Gist
//
//  Created by Thiago Lourin on 26/03/21.
//  Copyright © 2021 Lourin. All rights reserved.
//

import Alamofire

struct GistGetRequest: APIRequest {
    
    let gistId: String
    
    public init(gistId: String) {
        self.gistId = gistId
    }
    
    var path: String {
        return "gists/\(gistId)"
    }
    
    var mockPath: String {
        return ""
    }
    
    var method: HTTPMethod {
        return .get
    }
        
    typealias Response = GistResponseModel
        
}
