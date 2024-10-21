//
//  AnnotationView.swift
//  Tag-It
//
//  Created by Aurélien on 21/10/2024.
//
import SwiftUI

struct AnnotationView: View {
    let artwork: Artwork
    @Binding var selectedArtwork: Artwork?
    
    var body: some View {
        VStack {
            Image(systemName: "mappin.circle.fill")
                .foregroundColor(.red)
                .font(.title)
                .onTapGesture {
                    selectedArtwork = artwork
                }
        }
    }
}
