//
//  MapView.swift
//  Tag-It
//
//  Created by Aurélien on 09/10/2024.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var artworkViewModel: ArtworkViewModel
    @EnvironmentObject var favoriteViewModel: FavoriteViewModel
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522), // Coordonnées de Paris
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1) // Zoom
    )
    @State private var selectedArtwork: Artwork? = nil

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: artworkViewModel.artworks) { artwork in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: artwork.latitude, longitude: artwork.longitude)) {
                Image(systemName: "mappin.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        selectedArtwork = artwork
                    }
            }
        }
        .edgesIgnoringSafeArea([.top, .leading, .trailing])
        .sheet(item: $selectedArtwork) { artwork in
            DetailsArtworkView(artwork: artwork)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(ArtworkViewModel())
            .environmentObject(FavoriteViewModel())
    }
}
