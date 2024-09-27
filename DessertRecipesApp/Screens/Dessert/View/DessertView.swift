//
//  DessertView.swift
//  DessertRecipesApp
//
//  Created by Jaya Siva Bhaskar Karlapalem on 9/21/24.
//

import SwiftUI

struct DessertView: View {
    
    @EnvironmentObject private var viewModel: DessertViewModel
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isError {
                    Text("Please try again later.")
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(viewModel.meals, id: \.idMeal) { meal in
                                NavigationLink {
                                    MealDetailsView(id: meal.idMeal)
                                        .environmentObject(viewModel)
                                } label: {
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
