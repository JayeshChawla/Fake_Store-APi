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

class APIManager {
    static let shared = APIManager()
    
    
    func request<T: Codable>(
        modelType: T.Type,
        type: EndPointType
    ) async throws -> T {
        guard let url = type.url else { throw DataError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = type.methods.rawValue
        if let parameters = type.body {
            request.httpBody = try? JSONEncoder().encode(parameters)
        }
        request.allHTTPHeaderFields = type.headers
        
        do {
            let (data , response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                throw DataError.invalidResponse
            }
            
            let decodeData = try JSONDecoder().decode(modelType, from: data)
            return decodeData
        } catch {
            throw DataError.error(error)
        }
    }
    
    static var commonHeaders: [String: String] {
        return ["Content-Type": "application/json"]
    }
}
