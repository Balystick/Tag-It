//
//  HomeView.swift
//  Tag-It
//
//  Created by Audrey on 21/10/2024.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var homeViewModel = HomeViewModel()
    @StateObject private var profileViewModel = ProfileViewModel()
    @StateObject private var favoriteViewModel = FavoriteViewModel()
    
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
                    ForEach(homeViewModel.artworks) { artwork in
                        if let userId = profileViewModel.user?.id {
                            let artistName = homeViewModel.getArtistName(for: artwork)
                            ArtworkItemView(artwork: artwork, imageSize: imageSize, userId: userId, favoriteViewModel: favoriteViewModel, artistName: artistName)
                        } else {
                            Text("User not found")
                        }
                    }
                }
                .padding(.horizontal, padding)
            }
        }
        .onAppear {
            homeViewModel.fetchArtWorks()
            homeViewModel.fetchArtists()
            profileViewModel.fetchUser(by: UUID(uuidString: "3f223c8d-9e67-4fad-8aca-ae563172b205")!)
            favoriteViewModel.fetchFavorites(userId: UUID(uuidString: "3f223c8d-9e67-4fad-8aca-ae563172b205")!)
        }
    }
}

#Preview {
    HomeView()
}
