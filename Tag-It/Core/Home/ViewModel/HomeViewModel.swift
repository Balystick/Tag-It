//
//  HomeViewModel.swift
//  Tag-It
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var artworks: [Artwork] = []
    @Published var artists: [Artist] = []
    @Published var artistsDico: [UUID: Artist] = [:]
    @Published var isDataLoaded: Bool = false
    
    private let baseArtworksURL = "http://localhost:8080/artworks"
    private let baseArtistsURL = "http://localhost:8080/artists"

    // Fetch des œuvres d'art
    func fetchArtWorks() {
        guard let url = URL(string: baseArtworksURL) else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedArtWorks = try JSONDecoder().decode([Artwork].self, from: data)
                    DispatchQueue.main.async {
                        self.artworks = decodedArtWorks
                        self.checkIfDataIsLoaded()
                    }
                } catch {
                    print("Error decoding artworks: \(error)")
                }
            } else if let error = error {
                print("Error fetching artworks: \(error)")
            }
        }.resume()
    }

    // Fetch des artistes
    func fetchArtists() {
        guard let url = URL(string: baseArtistsURL) else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedArtists = try JSONDecoder().decode([Artist].self, from: data)
                    DispatchQueue.main.async {
                        self.artists = decodedArtists
                        self.convertArtistsArrayToDictionary()
                        self.checkIfDataIsLoaded()
                    }
                } catch {
                    print("Error decoding artists: \(error)")
                }
            } else if let error = error {
                print("Error fetching artists: \(error)")
            }
        }.resume()
    }

    // Conversion du tableau d'artistes en dictionnaire
    func convertArtistsArrayToDictionary() {
        self.artistsDico = Dictionary(uniqueKeysWithValues: artists.map { ($0.id, $0) })
    }

    // Vérification si les deux fetchs sont terminés
    private func checkIfDataIsLoaded() {
        if !artworks.isEmpty && !artists.isEmpty {
            self.isDataLoaded = true
        }
    }

    // Récupère le nom de l'artiste pour une œuvre donnée
    func getArtistName(for artwork: Artwork) -> String {
        return artistsDico[artwork.id_artist]?.name ?? "Artiste inconnu"
    }
}
