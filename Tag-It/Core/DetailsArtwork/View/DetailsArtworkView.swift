//
//  DetailsArtworkView.swift
//  Tag-It
//
//  Created by Apprenant 124 on 21/10/2024.
//

import SwiftUI
import MapKit

struct DetailsArtworkView: View {
    @StateObject var viewModel = DetailsArtworkViewModel()
    let artworkID: String

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "")) { image in
                    image
                        .frame(maxWidth: .infinity, minHeight: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(16)
                } placeholder: {
                    Image(systemName: "photo.artframe")
                        .font(.system(size: 64))
                        .frame(maxWidth: .infinity, minHeight: 250)
                        .background(Color(.systemGray4))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(16)
                }
                
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
                    RowDetailsArtworkView(title: "Title", value: "")
                    Divider()
                    RowDetailsArtworkView(title: "Type", value: "Type")
                    Divider()
                    RowDetailsArtworkView(title: "Address", value: "Address")
                    Divider()
                    RowDetailsArtworkView(title: "Postal Code", value: "Postal Code")
                    Divider()
                    RowDetailsArtworkView(title: "City", value: "City")
                    Divider()
                    RowDetailsArtworkView(title: "Country", value: "Country")
                    Divider()
                    RowDetailsArtworkView(title: "Latitude", value: "Latitude")
                    Divider()
                    RowDetailsArtworkView(title: "Longitude", value: "Longitude")
                }
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.horizontal, 16)
                
                Map()
                    .frame(maxWidth: .infinity, minHeight: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding()
                
                Button {
                    
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
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.fetchArtworkByID(artworkID: artworkID)
            }
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
    DetailsArtworkView(artworkID: "18A469E1-1606-43B5-B983-395242023738")
}
