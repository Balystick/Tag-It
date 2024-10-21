//
//  HomeView.swift
//  Tag-It
//
//  Created by Audrey on 21/10/2024.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = MapViewModel()
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    let img = Image("")
    
    @State private var isFavorited: Bool = false

    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns , spacing: 20) {
                    List(viewModel.artworks) { artwork in
                        ZStack {
                            AsyncImage(url: URL(string: artwork.image)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView("Loading")
                            }
                            Button(action: {
                                
                            }) {
                                Image(systemName: isFavorited == true ? "heart.arrow" : "heart")
                            }
                            .position(x:10, y:10)
                        }
                    }
                }
                .cornerRadius(20)
            }
        }.onAppear(
            perform: viewModel.fetchArtWorks
        )
        .padding()
    }
}

#Preview {
    HomeView()
}
