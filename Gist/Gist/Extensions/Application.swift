import UIKit

extension UIApplication {
    static var urlRoot: String {
        return Bundle.main.object(forInfoDictionaryKey: "urlRoot") as? String ?? ""
    }
    
    static var secretClientId: String {
        return Bundle.main.object(forInfoDictionaryKey: "apiKey") as? String ?? ""
    }
}
