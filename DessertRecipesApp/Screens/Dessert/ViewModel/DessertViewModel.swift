//
//  DessertViewModel.swift
//  DessertRecipesApp
//
//  Created by Jaya Siva Bhaskar Karlapalem on 9/21/24.
//

import Foundation

final class DessertViewModel: ObservableObject {
    
    @Published var meals: [MealModel] = []
    private let service: APIManagerService
    @Published var isError: Bool = false
    
    init(service: APIManagerService = APIManager()) {
        self.service = service
    }
    
    @MainActor
        func fetchMeals() async {
            await performRequest(endpoint: .fetchDesserts)
        }

    @MainActor
        func fetchMealDetail(by id: String) async {
            await performRequest(endpoint: .fetchDessertDetails(id: id))
        }

    @MainActor
        private func performRequest(endpoint: DessertEndPoint) async {
            do {
                let response: DessertResponse = try await service.request(type: endpoint)
                meals = response.meals
                debugPrint(meals.count)
            } catch {
                isError = true
                debugPrint(error)
            }
        }
}
