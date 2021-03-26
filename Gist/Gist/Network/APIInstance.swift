//
//  APIInstance.swift
//  Gist
//
//  Created by Thiago Lourin on 26/03/21.
//  Copyright © 2021 Lourin. All rights reserved.
//

import Foundation

class APIInstance {
    
    static func get() -> APIClientProtocol {
        if Thread().isRunningXCTest {
            return APIClientMock()
        }
        return APIClient.shared
    }
}
