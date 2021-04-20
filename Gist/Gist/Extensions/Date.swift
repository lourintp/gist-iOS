//
//  Date.swift
//  Gist
//
//  Created by Thiago Lourin on 25/03/21.
//  Copyright © 2021 Lourin. All rights reserved.
//

import Foundation

public extension Date {
    func string(withFormat format: String = "dd/MM/yyyy HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    struct Formatter {
        static let iso8601: DateFormatter = {
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            return formatter
        }()
    }

    var iso8601: String { return Formatter.iso8601.string(from: self) }
}
