//
//  HomeView.swift
//  Tag-It
//
//  Created by Audrey on 21/10/2024.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    let img = Image("")
    
    @State private var isFavorited: Bool = false

    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns , spacing: 20) {
                    ForEach(viewModel.artworks) { artwork in
                        ZStack {
                            AsyncImage(url: URL(string: "http://localhost:8080/images/\(artwork.image)")) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
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
        }
        .onAppear {
            viewModel.fetchArtWorks()
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
