//
//  Mockable.swift
//  DessertRecipesApp
//
//  Created by Jaya Siva Bhaskar Karlapalem on 9/21/24.
//

import Foundation

// Protocol to define mockable behavior for any class
protocol Mockable: AnyObject {
    
    var bundle: Bundle { get }
    
    // Method to load and decode a JSON file into a specified type
    func loadJson<T: Decodable>(fileName: String, decodeType: T.Type) -> T
}

extension Mockable {
    var bundle: Bundle {
        return Bundle.main
    }

    // Function to load JSON data from a specified file and decode it into the specified type
    func loadJson<T: Decodable>(fileName: String, decodeType: T.Type) -> T {
        // Get the URL for the JSON file within the bundle
        guard let path = bundle.url(forResource: fileName, withExtension: "json") else {
            fatalError("Failed to load JSON file.")
        }
        do {
            // Read the data from the file at the specified path
            let data = try Data(contentsOf: path)
            let decodeObject = try JSONDecoder().decode(decodeType, from: data)
            return decodeObject
        }catch {
            // Log the error if decoding fails
            print("❌ \(error)")
            fatalError("Failed to decode the JSON.")
        }
    }
}
