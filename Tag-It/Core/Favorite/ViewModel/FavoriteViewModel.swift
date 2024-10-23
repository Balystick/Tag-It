//
//  FavoriteViewModel.swift
//  Tag-It
//
//  Created by Audrey on 22/10/2024.
//

import Foundation


class FavoriteViewModel: ObservableObject {
    @Published var favorites: [Favorite] = []
    @Published var artworks: [Artwork] = []
    
    private let baseURL = "http://localhost:8080/favorites"
    
    func fetchFavorites() {
        guard let url = URL(string: baseURL) else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedFavorites = try JSONDecoder().decode([Favorite].self, from: data)
                    DispatchQueue.main.async {
                        self.favorites = decodedFavorites
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

    func addFavorite(idArtwork: UUID, idUser: UUID) {
        
        let favorite = Favorite(id: UUID(), dateAdded: String(ISO8601DateFormatter().string(from: Date()).prefix(10)), idArtwork: idArtwork, idUser: idUser)
            guard let url = URL(string: baseURL) else {
                print("Invalid URL")
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            do {
                let data = try JSONEncoder().encode(favorite)
                request.httpBody = data
            } catch {
                print("Error encoding contact: \(error)")
                return
            }

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error adding contact: \(error)")
                    return
                }
                self.fetchFavorites()
            }.resume()
        print("favori added")
        }

    
    func updateFavorite(_ favorite: Favorite) {
            guard let url = URL(string: "\(baseURL)/\(favorite.id)") else {
                print("Invalid URL")
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            do {
                let data = try JSONEncoder().encode(favorite)
                request.httpBody = data
            } catch {
                print("Error encoding contact: \(error)")
                return
            }

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error updating contact: \(error)")
                    return
                }
                self.fetchFavorites()
            }.resume()
        }

        func deleteFavorite(_ favorite: Favorite) {
            guard let url = URL(string: "\(baseURL)/\(favorite.id)") else {
                print("Invalid URL")
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error deleting contact: \(error)")
                    return
                }

                self.fetchFavorites()
            }.resume()
            print("favori deleted")
        }



    
}
