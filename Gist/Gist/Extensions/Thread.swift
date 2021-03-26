//
//  Thread.swift
//  Gist
//
//  Created by Thiago Lourin on 26/03/21.
//  Copyright © 2021 Lourin. All rights reserved.
//

import Foundation

extension Thread {
    var isRunningXCTest: Bool {
        for key in self.threadDictionary.allKeys {
            guard let keyAsString = key as? String else {
                continue
            }
    
            if keyAsString.split(separator: ".").contains("xctest") {
                return true
            }
        }
        return false
    }
}
