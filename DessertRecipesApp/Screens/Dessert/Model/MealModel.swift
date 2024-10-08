//
//  MealModel.swift
//  DessertRecipesApp
//
//  Created by Jaya Siva Bhaskar Karlapalem on 9/21/24.
//

import Foundation

// Struct representing meals data, conforms to Decodable
struct DessertResponse: Decodable {
    let meals: [MealModel]
}

// Struct representing a single meal, conforms to Decodable for JSON decoding
struct MealModel: Decodable {
    let idMeal: String
    let strMeal: String
    let strDrinkAlternate: String?
    let strCategory: String?
    let strArea: String?
    let strInstructions: String?
    let strMealThumb: String
    let strTags: String?
    let strYoutube: String?
    
    // Optional ingredients
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    
    // Optional measurements
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
    
    let strSource: String?
    let strImageSource: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified: String?
    
    // Computed property that aggregates non-empty ingredient strings into an array
    var ingredients: [String] {
        let ingredientsArray = [strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20].compactMap { ingredient in
            if let ingredient = ingredient, !ingredient.trimmingCharacters(in: .whitespaces).isEmpty {
                return ingredient
            }
            return nil
        }
        return ingredientsArray
    }
    
    // Computed property for a comma-separated measurements string
    var measurements: [String] {
        let measurementsArray = [strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10, strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20].compactMap { measurement in
            
            // Filter out nil or empty ingredients
            if let measurement = measurement, !measurement.trimmingCharacters(in: .whitespaces).isEmpty {
                return measurement
            }
            return nil
        }
        return measurementsArray
    }
    // Generate a URL from the meal thumbnail string
    var mealThumbURL: URL? {
        return URL(string: strMealThumb)
    }
}

