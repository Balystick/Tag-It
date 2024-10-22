//
//  ArtworkView.swift
//  Tag-It
//
//  Created by Apprenant 124 on 22/10/2024.
//

import SwiftUI

struct ArtworkView: View {
    @State private var scale: CGFloat = 1.0

    let artwork: Artwork
    private let baseURL = "http://localhost:8080/images"
    
    var body: some View {
        GeometryReader { geometry in
            // --- AB Testing ---
            // ScrollView([.vertical, .horizontal], showsIndicators: false) {
            ScrollView {
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

#Preview {
    ArtworkView(artwork: Artwork.init(title: "Window to the Soul", image: "5ba7cf2b2914c129241345.jpg", type: "", address: "", city: "", country: "", date: "", latitude: 0.0, longitude: 0.0, points: ""))
}
