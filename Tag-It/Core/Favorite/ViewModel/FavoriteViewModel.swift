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
    
    init() {
        fetchFavorites()
    }
    
    func fetchFavorites() {
        guard let url = URL(string: baseURL) else {
            print("URL invalide")
            return
        }
        
        // Récupérer le token depuis le Keychain
        guard let token = KeychainManager.getTokenFromKeychain() else {
            print("Erreur : Aucun token trouvé dans le Keychain")
            return
        }

        // Configurer la requête avec le token JWT
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
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
    
    func addFavorite(idArtwork: UUID) {
        let favorite = Favorite(
            id: nil, // ID généré par le serveur
            date_added: String(ISO8601DateFormatter().string(from: Date()).prefix(10)),
            id_artwork: idArtwork
        )
        
        guard let url = URL(string: baseURL) else {
            print("URL invalide")
            return
        }
        
        guard let token = KeychainManager.getTokenFromKeychain() else {
            print("Erreur : Aucun token trouvé dans le Keychain")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            let data = try JSONEncoder().encode(favorite)
            request.httpBody = data
        } catch {
            print("Erreur lors de l'encodage du favori: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Erreur lors de l'ajout du favori: \(error)")
                return
            }
            
            if let data = data {
                do {
                    let createdFavorite = try JSONDecoder().decode(Favorite.self, from: data)
                    DispatchQueue.main.async {
                        self.favorites.append(createdFavorite)
                    }
                } catch {
                    print("Erreur lors du décodage du favori créé: \(error)")
                }
            }
        }.resume()
    }
    
    func deleteFavorite(favoriteId: UUID) {
        guard let url = URL(string: "\(baseURL)/\(favoriteId)") else {
            print("URL invalide")
            return
        }
        
        guard let token = KeychainManager.getTokenFromKeychain() else {
            print("Erreur : Aucun token trouvé dans le Keychain")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
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
