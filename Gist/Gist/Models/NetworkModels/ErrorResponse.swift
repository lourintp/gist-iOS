import Foundation

public struct ErrorResponse: Codable {
    var path: String?
    let status: Int?
    let timestamp: String?
    let error: String?
    let noInternetConnection: Bool?
    
    init(status: Int, timestamp: String, error: String, noInternetConnection: Bool = false) {
        self.status = status
        self.timestamp = timestamp
        self.error = error
        self.noInternetConnection = noInternetConnection
    }
    
    static func noInternetConnection() -> ErrorResponse {
        let errorCode = 1009
        return ErrorResponse(status: errorCode, timestamp: Date().string(), error: "No internet connection")
    }
    
    static func somethingWentWrong(status: Int, message: String) -> ErrorResponse {
        return ErrorResponse(status: status, timestamp: Date().string(), error: message)
    }
}
