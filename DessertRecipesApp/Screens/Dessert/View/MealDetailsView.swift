//
//  MealDetailsView.swift
//  DessertRecipesApp
//
//  Created by Jaya Siva Bhaskar Karlapalem on 9/21/24.
//

import SwiftUI

// MealDetailsView struct displays detailed information about a specific meal
struct MealDetailsView: View {
    
    // Environment object that provides the DessertViewModel instance
    @EnvironmentObject private var viewModel: DessertViewModel
    
    // State variable to control the visibility of the ingredients section
    @State private var isShowIngredients: Bool = true
    
    // Unique identifier for the meal to fetch details
    var id: String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                if viewModel.isError {
                    Text("Please try again later.")
                } else {
                    if viewModel.meals.count > 0, let meal = viewModel.meals.first {
                        VStack {
                            // Display the meal's image
                            mealImage(meal)
                            
                            // Vertical stack for title and ingredients
                            VStack(alignment: .leading, spacing: 8) {
                                // Display title and instructions for the meal
                                titleAndInstructionView(meal)
                                
                                Divider() //Separator between sections
                                
                                // Display ingredients section
                                ingredientsSection(meal)
                                
                            }
                            .padding()
                        }
                    }
                }
            }            
        }
        // Fetch meal details asynchronously when the view appears
        .task {
            await viewModel.fetchMealDetail(by: id)
        }
        .ignoresSafeArea(.all, edges: .top)
        .navigationBarTitleDisplayMode(.inline)
    }
    // Function to display the meal's image
    func mealImage(_ meal: MealModel) -> some View {
        AsyncImage(url: meal.mealThumbURL) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
    }
    // Function to display the meal's title and instructions
    func titleAndInstructionView(_ meal: MealModel) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(meal.strMeal)
                .font(.largeTitle.bold())
            
            ScrollView {
                Text(meal.strInstructions ?? "")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 16)
            }
            .frame(height: 100)
        }
    }
    // Function to display the ingredients section
    func ingredientsSection(_ meal: MealModel) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Ingredients")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        isShowIngredients.toggle()
                    }
                }, label: {
                    Image(systemName: isShowIngredients ? "chevron.up" : "chevron.down")
                        .foregroundStyle(Color(UIColor.label))
                })
                
            }
            // Show ingredients list if isShowIngredients is true
            if isShowIngredients {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(0..<meal.ingredients.count, id: \.self) { index in
                        HStack {
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 5, height: 5)
                            Text(meal.measurements[index])
                            Text(meal.ingredients[index])
                        }
                        .font(.footnote)
                        .foregroundColor(.gray)
                    }
                }
                .animation(.easeInOut, value: isShowIngredients)                
            }
        }
    }
        
}
// Preview provider for MealDetailsView
#Preview {
    MealDetailsView(id: "53049")
        .environmentObject(DessertViewModel())
}
