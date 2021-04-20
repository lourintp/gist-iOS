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
        return "GistResponse"
    }
    
    var method: HTTPMethod {
        return .get
    }
        
    typealias Response = GistResponseModel
        
}
