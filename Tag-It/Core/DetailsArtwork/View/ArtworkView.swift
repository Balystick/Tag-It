//
//  ArtworkView.swift
//  Tag-It
//
//  Created by Apprenant 124 on 22/10/2024.
//

import SwiftUI

struct ArtworkView: View {
    @State private var scale: CGFloat = 1.0
    @Environment(\.dismiss) var dismiss
    let artwork: Artwork
    private let baseURL = "http://localhost:8080/images"
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.down")
                            .font(.system(size: 24))
                            .foregroundStyle(.black)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                
                AsyncImage(url: URL(string: "\(baseURL)/\(artwork.image)")) { image in
                    image
                        .resizable()
                        .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .clipped()
                        .padding(.horizontal, 8)
                        .scaleEffect(scale)
                        .gesture(
                            MagnificationGesture()
                                .onChanged { value in
                                    scale = value
                                }
                        )
                } placeholder: {
                    Image(systemName: "photo.artframe")
                        .font(.system(size: 64))
                        .frame(maxWidth: .infinity, minHeight: 250)
                        .background(Color(.systemGray4))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
        }
        .navigationTitle(artwork.title)
    }
}
