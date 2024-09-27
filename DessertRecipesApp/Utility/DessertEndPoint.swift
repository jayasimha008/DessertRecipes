//
//  DessertEndPoint.swift
//  DessertRecipesApp
//
//  Created by Jaya Siva Bhaskar Karlapalem on 9/21/24.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol EndPointType {
    var url: URL? { get }
    var path: String { get }
    var baseURL: String { get }
    var body: Encodable? { get }
    var headers: [String: String]? { get }
    var method: HTTPMethod { get }
    var mockFileName: String { get }
}

enum DessertEndPoint {
    case fetchDesserts
    case fetchDessertDetails(id: String)
}

extension DessertEndPoint: EndPointType {
    
    var url: URL? {
        return URL(string: baseURL + path)
    }

    var path: String {
        switch self {
        case .fetchDesserts:
            return "filter.php?c=Dessert"
        case .fetchDessertDetails(let id):
            return "lookup.php?i=\(id)"
        }
    }
    
    var baseURL: String { "https://themealdb.com/api/json/v1/1/" }

    var body: Encodable? { nil }

    var headers: [String : String]? {
        APIManager.commonHeaders
    }

    var method: HTTPMethod {
        return .get
    }
    
    var mockFileName: String {
        switch self {
        case .fetchDesserts:
            return "meals"
        case .fetchDessertDetails(_):
            return "meal-details"
        }
    }

}


