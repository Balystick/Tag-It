//
//  HomeViewModel.swift
//  Tag-It
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var artworks: [Artwork] = []
    private let baseArtworksURL = "http://localhost:8080/artworks"

    func fetchArtWorks() {
        guard let url = URL(string: baseArtworksURL) else {
            print("Invalid URL")
            return
        }
        
        guard let token = KeychainManager.getTokenFromKeychain() else {
            print("Erreur : Aucun token trouvé dans le Keychain")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decodedArtWorks = try JSONDecoder().decode([Artwork].self, from: data)
                    DispatchQueue.main.async {
                        self.artworks = decodedArtWorks
                    }
                } catch {
                    print("Error decoding artworks: \(error)")
                }
            } else if let error = error {
                print("Error fetching artworks: \(error)")
            }
        }.resume()
    }
}
