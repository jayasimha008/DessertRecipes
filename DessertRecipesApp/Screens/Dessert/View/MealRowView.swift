//
//  MealRowView.swift
//  DessertRecipesApp
//
//  Created by Jaya Siva Bhaskar Karlapalem on 9/21/24.
//

import SwiftUI

struct MealRowView: View {
    let meal: MealModel
    var body: some View {
        VStack {
            AsyncCachedImage(url: meal.mealThumbURL) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                    .cornerRadius(8)
            } placeholder: {
                ProgressView()
            }
            .frame(height: 120)
            
            Text(meal.strMeal)
                .font(.headline.bold())
                .foregroundStyle(Color(UIColor.label))
                .lineLimit(2)
                
            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 150)
    }
}
