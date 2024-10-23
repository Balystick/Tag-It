//
//  HomeViewModel.swift
//  Tag-It
//
//  Created by Audrey on 18/10/2024.


import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var artworks: [Artwork] = []
    
    private let baseURL = "http://localhost:8080/artworks"
    
    func fetchArtWorks() {
        guard let url = URL(string: baseURL) else {
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
                    print("Error decoding data: \(error)")
                }
            }
            else if let error = error {
                print("Error fetching data: \(error)")
            }
        }.resume()
    }
}


