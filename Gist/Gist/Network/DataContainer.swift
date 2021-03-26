//
//  DataContainer.swift
//  Gist
//
//  Created by Thiago Lourin on 26/03/21.
//  Copyright © 2021 Lourin. All rights reserved.
//

import Foundation

public struct DataContainer<Results: Decodable> : Decodable {
    public let results: Results
}
