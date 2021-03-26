//
//  APIRequest.swift
//  Gist
//
//  Created by Thiago Lourin on 26/03/21.
//  Copyright © 2021 Lourin. All rights reserved.
//

import Foundation
import Alamofire

public protocol APIRequest: Encodable {
    
    var path: String { get }
    var mockPath: String { get }
    var method: HTTPMethod { get }
    
    associatedtype Response: APIResponse
}
