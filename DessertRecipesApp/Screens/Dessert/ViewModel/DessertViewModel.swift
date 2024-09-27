//
//  DessertViewModel.swift
//  DessertRecipesApp
//
//  Created by Jaya Siva Bhaskar Karlapalem on 9/21/24.
//

import Foundation

// DessertViewModel class manages the state for dessert meals
final class DessertViewModel: ObservableObject {
    
    // Published property to hold a list of meals
    @Published var meals: [MealModel] = []
    
    // Service responsible for making API requests
    private let service: APIManagerService
    
    // Published property to indicate if there was an error during data fetching
    @Published var isError: Bool = false
    
    init(service: APIManagerService = APIManager()) {
        self.service = service
    }
    
    // Fetch meals asynchronously from the API
    @MainActor
        func fetchMeals() async {
            await performRequest(endpoint: .fetchDesserts)
        }
    
    // Fetch details for a specific meal by its ID asynchronously
    @MainActor
        func fetchMealDetail(by id: String) async {
            await performRequest(endpoint: .fetchDessertDetails(id: id))
        }

    // Private function to handle the API request and response
    @MainActor
        private func performRequest(endpoint: DessertEndPoint) async {
            do {
                let response: DessertResponse = try await service.request(type: endpoint)
                // Update the meals property with the received data
                meals = response.meals
                debugPrint(meals.count)
            } catch {
                isError = true
                debugPrint(error)
            }
        }
}
