//
//  MealDetailsView.swift
//  DessertRecipesApp
//
//  Created by Jaya Siva Bhaskar Karlapalem on 9/21/24.
//

import SwiftUI

struct MealDetailsView: View {
    
    @EnvironmentObject private var viewModel: DessertViewModel
    @State private var isShowIngredients: Bool = true
    
    var id: String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                if viewModel.isError {
                    Text("Please try again later.")
                } else {
                    if viewModel.meals.count > 0, let meal = viewModel.meals.first {
                        VStack {
                            mealImage(meal)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                titleAndInstructionView(meal)
                                
                                Divider()
                                
                                ingredientsSection(meal)
                                
                            }
                            .padding()
                        }
                    }
                }
            }            
        }
        .task {
            await viewModel.fetchMealDetail(by: id)
        }
        .ignoresSafeArea(.all, edges: .top)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func mealImage(_ meal: MealModel) -> some View {
        AsyncImage(url: meal.mealThumbURL) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
    }
    
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

#Preview {
    MealDetailsView(id: "53049")
        .environmentObject(DessertViewModel())
}
