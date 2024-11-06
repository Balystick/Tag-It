//
//  HomeViewModel.swift
//  Tag-It
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var artworks: [Artwork] = []
    private let baseArtworksURL = "http://localhost:8080/artworks"

    // Fetch des artworks
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
