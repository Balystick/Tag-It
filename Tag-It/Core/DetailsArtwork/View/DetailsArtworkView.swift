//
//  DetailsArtworkView.swift
//  Tag-It
//
//  Created by Apprenant 124 on 21/10/2024.
//

import SwiftUI
import MapKit

struct DetailsArtworkView: View {
    let artwork: Artwork
    private let baseURL = "http://localhost:8080/thumbs/thumb_"

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "\(baseURL)\(artwork.image)")) { image in
                    NavigationLink {
                        ArtworkView(artwork: artwork)
                    } label: {
                        image
                            .frame(maxWidth: .infinity, maxHeight: 250)
                            .scaledToFill()
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .clipped()
                    }
                } placeholder: {
                    Image(systemName: "photo.artframe")
                        .font(.system(size: 64))
                        .frame(maxWidth: .infinity, minHeight: 250)
                        .background(Color(.systemGray4))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding(16)
                
                HStack {
                    Text("Unknown Author")
                        .font(.headline)
                        .foregroundStyle(.primary)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
                
                VStack(spacing: 0) {
                    RowDetailsArtworkView(title: "Title", value: artwork.title)
                    Divider()
                    RowDetailsArtworkView(title: "Type", value: artwork.type)
                    Divider()
                    RowDetailsArtworkView(title: "Address", value: artwork.address)
                    Divider()
                    RowDetailsArtworkView(title: "City", value: artwork.city)
                    Divider()
                    RowDetailsArtworkView(title: "Country", value: artwork.country)
                    Divider()
                    RowDetailsArtworkView(title: "Latitude", value: String(artwork.latitude))
                    Divider()
                    RowDetailsArtworkView(title: "Longitude", value: String(artwork.longitude))
                }
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.horizontal, 16)
                
                Map()
                    .frame(maxWidth: .infinity, minHeight: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding()
                
                Button {
                    //
                } label: {
                    Text("Add Favorite")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.black)
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.horizontal, 16)
                }
            }
            .background(.ultraThinMaterial)
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct RowDetailsArtworkView: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 10) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.primary)
            
            Spacer()
            
            Text(value)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

#Preview {
    DetailsArtworkView(artwork: Artwork(title: "Back to the Future", image: "5ba7cf2b2914c129241345.jpg", type: "Grafiti", address: "14 Road", city: "London", country: "England", date: "2022-05-12", latitude: 0.0, longitude: 0.0, points: ""))
}
