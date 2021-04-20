import Alamofire

struct GistCommentRequestModel: APIRequest {
    
    private let gistID: String
    private let comment: String
    
    init(gistID: String, comment: String) {
        self.gistID = gistID
        self.comment = comment
    }
    
    var path: String {
        return "gists/\(gistID)/comments"
    }
    
    var mockPath: String {
        return "GistCommentResponse"
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    typealias Response = GistCommentResponseModel
    
    private enum CodingKeys: String, CodingKey {
        case comment = "body"
    }
        
}
