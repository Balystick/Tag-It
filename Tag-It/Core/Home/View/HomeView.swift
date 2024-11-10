//
//  HomeView.swift
//  Tag-It
//
//  Created by Audrey on 21/10/2024.
//
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var contentViewModel: ContentViewModel
    @EnvironmentObject var artworkViewModel: ArtworkViewModel
    @ObservedObject var favoriteViewModel: FavoriteViewModel

    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]

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
                    ForEach(artworkViewModel.artworks) { artwork in
                        ArtworkItemView(artwork: artwork, imageSize: imageSize, favoriteViewModel: favoriteViewModel)
                    }
                }
                .padding(.horizontal, padding)
            }
        }
    }
}
