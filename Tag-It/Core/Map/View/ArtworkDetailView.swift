//
//  ArtworkDetailView.swift
//  Tag-It
//
//  Created by Aurélien on 21/10/2024.
//
import SwiftUI

struct ArtworkDetailView: View {
    let artwork: Artwork
    
    var body: some View {
        VStack {
            Text(artwork.title)
                .font(.title2)
                .padding()
            
            AsyncImage(url: URL(string: "http://localhost:8080/images/\(artwork.image)")) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .cornerRadius(10)
            
            Text(artwork.address)
            Text(artwork.city)
            Text(artwork.country)
        }
        .padding()
    }
}
