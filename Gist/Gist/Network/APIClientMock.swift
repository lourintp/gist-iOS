//
//  APIClientMock.swift
//  GistTests
//
//  Created by Thiago Lourin on 26/03/21.
//  Copyright © 2021 Lourin. All rights reserved.
//

import Foundation

class APIClientMock: APIClientProtocol {
    func request<T>(_ request: T, completion: @escaping ResultCallback<DataContainer<T.Response>>) where T : APIRequest {
        
    }
}
