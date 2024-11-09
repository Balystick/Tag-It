//
//  ArtworkItemView.swift
//  Tag-It
//
//  Created by Aurélien on 22/10/2024.
//
import SwiftUI

struct ArtworkItemView: View {
    let artwork: Artwork
    let imageSize: CGFloat
    @ObservedObject var favoriteViewModel: FavoriteViewModel
    @State private var showDetail: Bool = false

    var isFavorited: Bool {
        favoriteViewModel.isFavorited(artworkId: artwork.id)
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            // Bouton les détails de l'œuvre
            Button(action: {
                showDetail = true
            }) {
                AsyncImage(url: URL(string: "http://localhost:8080/thumbs/thumb_\(artwork.image)")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: imageSize, height: imageSize)
                        .clipped()
                } placeholder: {
                    ProgressView()
                        .frame(width: imageSize, height: imageSize)
                }
            }

            // Bouton pour ajouter ou retirer des favoris
            Button(action: {
                if isFavorited {
                    if let favorite = favoriteViewModel.favorites.first(where: { $0.id_artwork == artwork.id }) {
                        favoriteViewModel.deleteFavorite(favoriteId: favorite.id!)
                    }
                } else {
                    favoriteViewModel.addFavorite(idArtwork: artwork.id)
                }
            }) {
                Image(systemName: isFavorited ? "heart.fill" : "heart")
                    .foregroundColor(.red)
                    .padding(6)
            }
            .background(Color.white.opacity(0.7))
            .clipShape(Circle())
            .padding(8)
        }
        .frame(width: imageSize, height: imageSize)
        .sheet(isPresented: $showDetail) {
            DetailsArtworkView(artwork: artwork)
        }
    }
}
