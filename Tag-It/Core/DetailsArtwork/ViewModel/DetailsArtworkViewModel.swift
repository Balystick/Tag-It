//
//  DetailsArtworkViewModel.swift
//  Tag-It
//
//  Created by Apprenant 124 on 22/10/2024.
//

import Foundation

class DetailsArtworkViewModel: ObservableObject {
    @Published var artwork: Artwork?
    
    private let baseURL: String = "http://localhost:8080/artworks"
    
    func fetchArtworkByID(artworkID: UUID) {
        guard let url = URL(string: "\(baseURL)/\(artworkID)") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedArtwork = try JSONDecoder().decode(Artwork.self, from: data)
                    DispatchQueue.main.async {
                        self.artwork = decodedArtwork
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            } else if let error = error {
                print("Error fetching data: \(error)")
            }
        }.resume()
    }
}
