//
//  APIClient.swift
//  Gist
//
//  Created by Thiago Lourin on 25/03/21.
//  Copyright © 2021 Lourin. All rights reserved.
//

import Alamofire

class Conectivity {
    class var isConnectectToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

protocol APIClientProtocol {
    func request<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<DataContainer<T.Response>>)
}

class APIClient: APIClientProtocol {
    
    static let shared = APIClient()
    
    private init() {}
    
    func request<T>(_ request: T, completion: @escaping ResultCallback<DataContainer<T.Response>>) where T : APIRequest {
        let endpoint: URLRequest
                
        do {
            endpoint = try getRequest(for: request, url: UIApplication.urlRoot)
        } catch let error {
            completion(.failure(ErrorResponse(status: 502, timestamp: Date().string(), error: error.localizedDescription, noInternetConnection: Conectivity.isConnectectToInternet)))
            return
        }
        
        Alamofire.request(endpoint).validate().responseData { (responseData) in
            guard let data = responseData.data else {
                completion(.failure(ErrorResponse(status: 502, timestamp: Date().string(), error: responseData.error?.localizedDescription ?? "Impossível obter resultado do servidor.")))
                return
            }
            
            let stringData = String(data: data, encoding: .utf8)
            print("Response body: \(stringData ?? "")")
            
            do {
                let response = try JSONDecoder().decode(T.Response.self, from: data)
                completion(.success(response))
                return
            } catch let error {
                completion(.failure(ErrorResponse(status: responseData.response?.statusCode ?? 502, timestamp: Date().string(), error: error.localizedDescription, noInternetConnection: Conectivity.isConnectectToInternet)))
            }
        }
    }
        
    internal func getRequest<T: APIRequest>(for request: T, url: String) throws -> URLRequest {
        guard let baseURL = URLComponents(string: try url.asURL().appendingPathComponent(request.path).absoluteString) else {
            fatalError("Bad resource name: \(request.path)")
        }
        
        print("Method \(request.method.rawValue): \(baseURL)")
        
        guard let url = baseURL.url else { fatalError() }
        var requestData = URLRequest(url: url)
        
        requestData.httpMethod = request.method.rawValue
        requestData.addValue("application/json", forHTTPHeaderField: "Content-Type")
        requestData.addValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        requestData.addValue("Bearer \(UIApplication.secretClientId)", forHTTPHeaderField: "Authorization")
        
        if (request.method != .get) {
            requestData.httpBody = try toData(request)
        }
        
        return requestData
    }
    
    private func toData<T: APIRequest>(_ data: T) throws -> Data {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        jsonEncoder.dateEncodingStrategy = .iso8601
            
        return try jsonEncoder.encode(data)
    }
}
