import Foundation

public enum Result<Value> {
    case success(APIResponse?)
    case failure(ErrorResponse?)
}

typealias ResultCallback<Value> = (Result<Value>) -> Void
