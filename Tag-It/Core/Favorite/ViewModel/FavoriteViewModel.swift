//
//  FavoriteViewModel.swift
//  Tag-It
//
//  Created by Audrey on 22/10/2024.
//

import Foundation

class FavoriteViewModel: ObservableObject {
    @Published var favorites: [Favorite] = []
    
    private let baseURL = "http://localhost:8080/favorites"
    
    func fetchFavorites(userId: UUID) {
        guard let url = URL(string: "\(baseURL)?id_user=\(userId)") else {
            print("URL invalide")
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
                    print("Erreur lors du décodage des favoris: \(error)")
                }
            } else if let error = error {
                print("Erreur lors de la requête: \(error)")
            }
        }.resume()
    }
    
    func addFavorite(idArtwork: UUID, idUser: UUID) {
        let favorite =
        Favorite(id: UUID(),
                 date_added: String(ISO8601DateFormatter().string(from: Date()).prefix(10)),
                 id_artwork: idArtwork,
                 id_user: idUser)
        
        guard let url = URL(string: baseURL) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
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
        }.resume()
    }
    
    func deleteFavorite(favoriteId: UUID) {
        guard let url = URL(string: "\(baseURL)/\(favoriteId)") else {
            print("URL invalide")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Erreur lors de la suppression du favori: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.favorites.removeAll { $0.id == favoriteId }
            }
        }.resume()
    }
    
    func isFavorited(artworkId: UUID) -> Bool {
        return favorites.contains { $0.id_artwork == artworkId }
    }
}
