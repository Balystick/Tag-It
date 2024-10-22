//
//  FavoriteViewModel.swift
//  Tag-It
//
//  Created by Audrey on 22/10/2024.
//
import SwiftUI

struct FavoriteView: View {
    
    @StateObject private var viewModel = FavoriteViewModel()
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
//    let img = Image("")
    
    @State private var isFavorited: Bool = false

    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns , spacing: 20) {
                    ForEach(viewModel.favorites) { favorite in
                        ZStack {
                            AsyncImage(url: URL(string: "http://localhost:8080/favorites/\(favorites.image)")) { favorite in
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
            viewModel.fetchFavorites()
        }
        .padding()
    }
}

#Preview {
    FavoriteView()
}
