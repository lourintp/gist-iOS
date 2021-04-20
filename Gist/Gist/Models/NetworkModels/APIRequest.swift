import Foundation
import Alamofire

public protocol APIRequest: Encodable {
    
    var path: String { get }
    var mockPath: String { get }
    var method: HTTPMethod { get }
    
    associatedtype Response: APIResponse
}
