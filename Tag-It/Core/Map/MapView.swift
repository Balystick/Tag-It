//
//  MapView.swift
//  Tag-It
//
//  Created by Aurélien on 09/10/2024.
//

import SwiftUI
import MapKit

class ArtworkFetcher: ObservableObject {
    @Published var artworks: [Artwork] = []

    func fetchElements() {
        guard let url = URL(string: "http://localhost:8080/artworks") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedElements = try JSONDecoder().decode([Artwork].self, from: data)
                    DispatchQueue.main.async {
                        self.artworks = decodedElements
                    }
                } catch {
                    print("Erreur de décodage : \(error)")
                }
            }
        }.resume()
    }
}

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

struct ArtworkDetailView: View {
    let artwork: Artwork
    
    var body: some View {
        VStack {
            Text(artwork.title)
                .font(.title2)
                .padding()
            
            AsyncImage(url: URL(string: "http://localhost:8080/images/\(artwork.image)")) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .cornerRadius(10)
            
            Text(artwork.address)
            Text(artwork.city)
            Text(artwork.country)
        }
        .padding()
    }
}


struct MapView: View {
    @StateObject var fetcher = ArtworkFetcher()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522), // Coordonnées de Paris
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1) // Zoom
    )
    @State private var selectedArtwork: Artwork? = nil

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: fetcher.artworks) { artwork in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: artwork.latitude, longitude: artwork.longitude)) {
                AnnotationView(artwork: artwork, selectedArtwork: $selectedArtwork)
            }
        }
        .onAppear {
            fetcher.fetchElements() // Récupère les éléments au chargement
        }
        .edgesIgnoringSafeArea(.all)
        .sheet(item: $selectedArtwork) { artwork in
            ArtworkDetailView(artwork: artwork)
        }
    }
}

struct Map_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
