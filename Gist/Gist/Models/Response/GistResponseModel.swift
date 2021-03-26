//
//  GistResponseModel.swift
//  Gist
//
//  Created by Thiago Lourin on 26/03/21.
//  Copyright © 2021 Lourin. All rights reserved.
//

import Foundation

struct GistResponseModel: APIResponse {
    let html_url: String
    let id: String
    let created_at: String
    let owner: GistOwner
}

struct GistOwner: APIResponse {
    let login: String
    let avatar_url: String
}
