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
}
