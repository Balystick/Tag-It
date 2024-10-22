//
//  HomeView.swift
//  Tag-It
//
//  Created by Audrey on 21/10/2024.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    let img = Image("")
    
    @State private var isFavorited: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            let spacing: CGFloat = 10
            let numberOfColumns = 3
            let totalSpacing = spacing * (CGFloat(numberOfColumns) - 1)
            let padding: CGFloat = 20
            let availableWidth = geometry.size.width - totalSpacing - padding * 2
            let imageSize = availableWidth / CGFloat(numberOfColumns)
            
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: spacing), count: numberOfColumns), spacing: spacing) {
                    ForEach(viewModel.artworks) { artwork in
                        ArtworkItemView(artwork: artwork, imageSize: imageSize)
                    }
                }
                .padding(.horizontal, padding)
            }
        }
        .onAppear {
            viewModel.fetchArtWorks()
        }
    }
}

#Preview {
    HomeView()
}
