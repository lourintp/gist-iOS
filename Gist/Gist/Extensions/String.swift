import Foundation

extension String {
    var dateFromISO8601: String? {
        return Date.Formatter.iso8601.date(from: self)!.string(withFormat: "dd/MM/yyyy HH:mm:ss")
    }    
}
