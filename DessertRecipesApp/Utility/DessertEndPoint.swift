//
//  DessertEndPoint.swift
//  DessertRecipesApp
//
//  Created by Jaya Siva Bhaskar Karlapalem on 9/21/24.
//

import Foundation

// Defines various HTTP methods used in network requests
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}

// Protocol defining the requirements for an API endpoint
protocol EndPointType {
    var url: URL? { get }
    var path: String { get }
    var baseURL: String { get }
    var body: Encodable? { get }
    var headers: [String: String]? { get }
    var method: HTTPMethod { get }
    var mockFileName: String { get }
}

// Enum representing the various API endpoints for dessert-related data
enum DessertEndPoint {
    case fetchDesserts
    case fetchDessertDetails(id: String)
}

// Extension of DessertEndPoint conforming to the EndPointType protocol
extension DessertEndPoint: EndPointType {
    
    // Construct the full URL for the API request
    var url: URL? {
        return URL(string: baseURL + path)
    }

    var path: String {
        switch self {
        case .fetchDesserts:
            return "filter.php?c=Dessert"   // API path for fetching dessert list
        case .fetchDessertDetails(let id):
            return "lookup.php?i=\(id)"     // API path for fetching specific dessert details
        }
    }
    
    // Base URL of the theMealDB API
    var baseURL: String { "https://themealdb.com/api/json/v1/1/" }

    var body: Encodable? { nil }
    
    // HTTP headers commonly used in API requests
    var headers: [String : String]? {
        APIManager.commonHeaders
    }
    
    //GET method
    var method: HTTPMethod {
        return .get
    }
    
    //Mockdata file name for testing
    var mockFileName: String {
        switch self {
        case .fetchDesserts:
            return "meals"
        case .fetchDessertDetails(_):
            return "meal-details"
        }
    }

}


