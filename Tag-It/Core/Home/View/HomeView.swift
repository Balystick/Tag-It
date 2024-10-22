//
//  HomeView.swift
//  Tag-It
//
//  Created by Audrey on 21/10/2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var selectedArtwork: Artwork? = nil
    @State private var isFavorited: Bool = false
    
    private let gridItems: [GridItem] = [
            .init(.flexible(), spacing: 1),
            .init(.flexible(), spacing: 1),
            .init(.flexible(), spacing: 1)
    ]
    private let baseURL = "http://localhost:8080/thumbs/thumb_"

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView {
                    LazyVGrid(columns: gridItems , spacing: 2) {
                        ForEach(viewModel.artworks) { artwork in
                            ZStack {
                                AsyncImage(url: URL(string: "\(baseURL)\(artwork.image)")) { image in
                                    NavigationLink {
                                        DetailsArtworkView(artwork: artwork)
                                    } label: {
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: geometry.size.width / 3 - 1,
                                                   height: geometry.size.width / 3 - 1
                                            )
                                            .clipped()
                                    }
                                } placeholder: {
                                    ProgressView()
                                }
                                
                                Button {
                                    //
                                } label: {
                                    Image(systemName: isFavorited == true ? "heart.arrow" : "heart")
                                }
                                .position(x:-16, y:-16)
                            }
                        }
                    }
                }
                .onAppear { viewModel.fetchArtWorks() }
            }
        }
    }
}

#Preview {
    HomeView()
}
