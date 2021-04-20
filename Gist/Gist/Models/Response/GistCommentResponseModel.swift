import Foundation

struct GistCommentResponseModel: APIResponse {
    let url: String
    let id: Int
    let nodeID: String
    let user: User
    let authorAssociation: String
    let createdAt, updatedAt: String
    let body: String

    enum CodingKeys: String, CodingKey {
        case url, id
        case nodeID = "node_id"
        case user
        case authorAssociation = "author_association"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case body
    }
}

struct User: APIResponse {
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL: String
    let gravatarID: String
    let url, htmlURL, followersURL: String
    let followingURL, gistsURL, starredURL: String
    let subscriptionsURL, organizationsURL, reposURL: String
    let eventsURL: String
    let receivedEventsURL: String
    let type: String
    let siteAdmin: Bool

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
    }
}

