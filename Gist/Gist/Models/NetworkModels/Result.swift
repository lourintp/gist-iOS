//
//  Result.swift
//  Gist
//
//  Created by Thiago Lourin on 26/03/21.
//  Copyright © 2021 Lourin. All rights reserved.
//

import Foundation

public enum Result<Value> {
    case success(APIResponse?)
    case failure(ErrorResponse?)
}

typealias ResultCallback<Value> = (Result<Value>) -> Void
