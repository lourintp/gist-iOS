//
//  Application.swift
//  Gist
//
//  Created by Thiago Lourin on 26/03/21.
//  Copyright © 2021 Lourin. All rights reserved.
//

import UIKit

extension UIApplication {
    static var urlRoot: String {
        return Bundle.main.object(forInfoDictionaryKey: "urlRoot") as? String ?? ""
    }
    
    static var secretClientId: String {
        return Bundle.main.object(forInfoDictionaryKey: "apiKey") as? String ?? ""
    }
}
