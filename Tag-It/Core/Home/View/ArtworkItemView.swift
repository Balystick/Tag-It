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
    @State private var isFavorited: Bool = false
    @State private var showDetail: Bool = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Button(action: {
                showDetail = true
            }) {
                AsyncImage(url: URL(string: "http://Localhost:8080/thumbs/thumb_\(artwork.image)")) { image in
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
            
            Button(action: {
                isFavorited.toggle()
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
            ArtworkDetailView(artwork: artwork)
        }
    }
}