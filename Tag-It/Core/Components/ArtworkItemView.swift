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
    @State private var loadedImage: UIImage?

    var body: some View {
        ZStack(alignment: .topTrailing) {
            // Affichage de l'image de l'œuvre
            if let loadedImage = loadedImage {
                Image(uiImage: loadedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: imageSize, height: imageSize)
                    .clipped()
            } else {
                ProgressView()
                    .frame(width: imageSize, height: imageSize)
                    .onAppear {
                        loadImage()
                    }
            }

            // Bouton pour afficher les détails de l'œuvre
            Button(action: {
                showDetail = true
            }) {
                Rectangle()
                    .foregroundColor(.clear) // bouton invisible pour déclencher l'affichage des détails
                    .frame(width: imageSize, height: imageSize)
            }
            .sheet(isPresented: $showDetail) {
                DetailsArtworkView(artwork: artwork, favoriteViewModel: favoriteViewModel)
            }

            // Bouton pour ajouter ou retirer des favoris
            Button(action: {
                if favoriteViewModel.isFavorited(artworkId: artwork.id) {
                    if let favorite = favoriteViewModel.favorites.first(where: { $0.id_artwork == artwork.id }) {
                        favoriteViewModel.deleteFavorite(favoriteId: favorite.id!)
                    }
                } else {
                    favoriteViewModel.addFavorite(idArtwork: artwork.id)
                }
            }) {
                Image(systemName: favoriteViewModel.isFavorited(artworkId: artwork.id) ? "heart.fill" : "heart")
                    .foregroundColor(.red)
                    .padding(6)
            }
            .background(Color.white.opacity(0.7))
            .clipShape(Circle())
            .padding(8)
        }
        .frame(width: imageSize, height: imageSize)
    }

    private func loadImage() {
        guard let url = URL(string: "http://localhost:8080/thumbs/thumb_\(artwork.image)") else {
            print("URL invalide pour l'image")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.loadedImage = uiImage
                }
            } else {
                print("Erreur de chargement de l'image : \(error?.localizedDescription ?? "Inconnue")")
            }
        }.resume()
    }
}
