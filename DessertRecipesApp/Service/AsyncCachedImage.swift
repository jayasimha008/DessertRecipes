//
//  AsyncCachedImage.swift
//  DessertRecipesApp
//
//  Created by Jaya Siva Bhaskar Karlapalem on 9/21/24.
//

import SwiftUI

// Main actor to ensure UI updates are made on the main thread
@MainActor
struct AsyncCachedImage<ImageView: View, PlaceholderView: View>: View {
    // Input dependencies
    var url: URL?
    @ViewBuilder var content: (Image) -> ImageView
    @ViewBuilder var placeholder: () -> PlaceholderView
    
    // Downloaded image
    @State var image: UIImage? = nil
    
    // Initializer for the AsyncCachedImage structure
    init(
        url: URL?,
        @ViewBuilder content: @escaping (Image) -> ImageView,
        @ViewBuilder placeholder: @escaping () -> PlaceholderView
    ) {
        self.url = url
        self.content = content
        self.placeholder = placeholder
    }
    
    // Body of the view
    var body: some View {
        VStack {
            if let uiImage = image {
                content(Image(uiImage: uiImage))
            } else {
                placeholder()
            }
        }
        .onAppear {
            Task {
                image = await downloadPhoto()
            }
        }
    }
    
    // Downloads if the image is not cached already, otherwise returns from the cache
    private func downloadPhoto() async -> UIImage? {
        do {
            guard let url else { return nil }
            
            // Check if the image is cached
            if let cachedResponse = URLCache.shared.cachedResponse(for: .init(url: url)) {
                // Create and return the image from cached data
                let cachedImage = UIImage(data: cachedResponse.data)
                return cachedImage
            } else {
                // Fetch the image data from the network
                let (data, response) = try await URLSession.shared.data(from: url)
                
                // Cache the fetched image data for future use
                URLCache.shared.storeCachedResponse(.init(response: response, data: data), for: .init(url: url))
                
                // Attempt to create an image from the fetched data
                guard let image = UIImage(data: data) else {
                    return nil
                }
                
                return image
            }
        } catch {
            //Log any errors
            print("Error downloading: \(error)")
            return nil
        }
    }
}
