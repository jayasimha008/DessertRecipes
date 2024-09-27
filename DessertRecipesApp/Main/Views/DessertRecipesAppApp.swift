//
//  DessertRecipesAppApp.swift
//  DessertRecipesApp
//
//  Created by Jaya Siva Bhaskar Karlapalem on 9/21/24.
//

import SwiftUI

@main
struct DessertRecipesAppApp: App {
    @StateObject private var viewModel = DessertViewModel()
    
    var body: some Scene {
        WindowGroup {
            DessertView()
                .environmentObject(viewModel)
        }
    }
}
