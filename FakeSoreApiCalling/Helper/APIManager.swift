//
//  APIManager.swift
//  FakeSoreApiCalling
//
//  Created by Quick tech  on 12/09/24.
//

import Foundation

enum DataError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case error(Error?)
}

typealias Handler<T> = (Result<T, DataError>) -> Void

class APIManager {
    static let shared = APIManager()
    
    
    func request<T: Codable>(
        modelType: T.Type,
        type: EndPointType,
        completion: @escaping Handler<T>
    ) {
        guard let url = type.url else { return } 
        
        var request = URLRequest(url: url)
        request.httpMethod = type.methods.rawValue
        if let parameters = type.body {
            request.httpBody = try? JSONEncoder().encode(parameters)
        }
        request.allHTTPHeaderFields = type.headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse, 200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let product = try JSONDecoder().decode(modelType, from: data)
                completion(.success(product ))
            } catch {
                completion(.failure(.error(error)))
            }
        } .resume()
    }
    
    static var commonHeaders: [String: String] {
        return ["Content-Type": "application/json"]
    }
}
