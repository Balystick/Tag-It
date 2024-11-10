
//
//  FavoriteView.swift
//  Tag-It
//
//  Created by Audrey on 21/10/2024.
//
import SwiftUI

struct FavoriteView: View {
    @EnvironmentObject var artworkViewModel: ArtworkViewModel
    @EnvironmentObject var favoriteViewModel: FavoriteViewModel

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
                if favoriteViewModel.favorites.isEmpty {
                    VStack {
                        Spacer()
                        Image("cat.cry")
                            .resizable()
                                .aspectRatio(contentMode: .fit) // Maintient le rapport d'aspect
                                .frame(width: 150, height: 150)
                        Text("Vous n'avez pas encore de favoris...")
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: spacing), count: numberOfColumns), spacing: spacing) {
                        ForEach(artworkViewModel.artworks.filter { artwork in
                            favoriteViewModel.favorites.contains { $0.id_artwork == artwork.id }
                        }) { artwork in
                            ArtworkItemView(artwork: artwork, imageSize: imageSize)
                        }
                    }
                    .padding(.horizontal, padding)
                }
            }
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
            .environmentObject(ArtworkViewModel())
            .environmentObject(FavoriteViewModel())
    }
}
