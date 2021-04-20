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
