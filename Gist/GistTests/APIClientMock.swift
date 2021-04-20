//
//  APIClientMock.swift
//  GistTests
//
//  Created by Thiago Lourin on 19/04/21.
//  Copyright © 2021 Lourin. All rights reserved.
//

import Foundation
@testable import Gist

class APIClientMock: APIClientProtocol {
    var apiWasExecuted = false
    var hasError = false
    
    func request<T>(_ request: T, completion: @escaping (Result<DataContainer<T.Response>>) -> Void) where T : APIRequest {
        apiWasExecuted = true
        
        if (hasError) {
            completion(.failure(ErrorResponse(status: 502, timestamp: Date().string(), error: "Error")))
            return
        }
        
        let list = get(jsonFileName: request.mockPath)
        let decoder = JSONDecoder()
        if let data = list {
            do {
                let response = try decoder.decode(T.Response.self, from: data)
                completion(.success(response))
            }
            catch let error {
                completion(.failure(ErrorResponse(status: 501, timestamp: Date().string(), error: error.localizedDescription)))
            }
        }
    }
    
    private func get(jsonFileName: String) -> Data? {
        guard let url = Bundle(for: type(of: self)).url(forResource: jsonFileName, withExtension: "json") else {
            fatalError("Missing file: \(jsonFileName).json")
        }
        do {
            return try Data(contentsOf: url)
        } catch let error {
            print(error.localizedDescription)
        }
        
        return nil
    }
}
