//
//  DessertView.swift
//  DessertRecipesApp
//
//  Created by Jaya Siva Bhaskar Karlapalem on 9/21/24.
//

import SwiftUI

// Grid of dessert meals
struct DessertView: View {
    
    // Injected environment object, which is the ViewModel that handles data
    @EnvironmentObject private var viewModel: DessertViewModel
    
    // Define the layout for the grid items, 3 flexible columns
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        // NavigationStack allows navigation between views
        NavigationStack {
            VStack {
                if viewModel.isError {
                    Text("Please try again later.")
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            // Iterate through the meals and create a row for each
                            ForEach(viewModel.meals, id: \.idMeal) { meal in
                                NavigationLink {
                                    // Pass the meal ID to the details view and inject the environment object
                                    MealDetailsView(id: meal.idMeal)
                                        .environmentObject(viewModel)
                                } label: {
                                    // Row view for each meal
                                    MealRowView(meal: meal)
                                }
                            }
                        }
                    }
                }
            }
            .padding(.all, 8)
            .navigationTitle("Desserts")
            .ignoresSafeArea(.all, edges: .bottom)
            .task {
                await viewModel.fetchMeals()
            }
        }
    }
    
}

#Preview {
    DessertView()
        .environmentObject(DessertViewModel())
}
