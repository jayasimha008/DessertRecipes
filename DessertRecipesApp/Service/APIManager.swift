//
//  APIManager.swift
//  DessertRecipesApp
//
//  Created by Jaya Siva Bhaskar Karlapalem on 9/21/24.
//

import Foundation

// Enumeration representing various network-related errors
enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case network(_ error: Error?)
    case invalidError
}

// Protocol defining the contract for the API service
protocol APIManagerService {
    func request<T: Decodable>(type: EndPointType) async throws -> T
}


final class APIManager: APIManagerService {
    
    // Performs an API request, throws errors, and returns decoded data of the specified type
    func request<T: Decodable>(type: EndPointType) async throws -> T {
        
        guard let url = type.url else { throw NetworkError.invalidURL }
        
        var request = URLRequest(url: url)
        
        if let body = type.body {
            request.httpBody = try? JSONEncoder().encode(body)
        }
        request.allHTTPHeaderFields = type.headers
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Performs the network request and captures the response and data
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw NetworkError.invalidResponse }
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    // Common headers for all API requests, including content type as JSON
    static var commonHeaders: [String: String]? {
        ["Content-Type" : "application/json"]
    }
}

