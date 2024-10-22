//
//  ArtworkViewModel.swift
//  Tag-It
//
//  Created by Aurélien on 21/10/2024.
//
import Foundation

class ArtworkFetcher: ObservableObject {
    @Published var artworks: [Artwork] = []

    func fetchElements() {
        guard let url = URL(string: "http://10.80.56.128:8080/artworks") else { return }

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
