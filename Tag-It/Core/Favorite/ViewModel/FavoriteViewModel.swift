//
//  FavoriteViewModel.swift
//  Tag-It
//
//  Created by Audrey on 22/10/2024.
//

import Foundation
import SwiftUI

class FavoriteViewModel: ObservableObject {
    @Published var favorites: [Favorite] = []
    
    private let baseURL = "http://localhost:8080/favorites"
    
    /// Cette méthode envoie une requête `GET` à l'API pour récupérer les favoris de l'utilisateur. Si le token JWT est expiré, il réinitialise l'état d'authentification de `ContentViewModel`.
    /// - Parameter contentViewModel: Le ViewModel de contenu, utilisé pour gérer l'authentification de l'utilisateur en cas d'expiration du token.
    func fetchFavorites(contentViewModel: ContentViewModel) {
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
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 401 {
                    DispatchQueue.main.async {
                        KeychainManager.deleteTokenFromKeychain()
                        contentViewModel.isAuthenticated = false
                        contentViewModel.currentUser = nil
                    }
                    return
                }
            }
            
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
    
    /// Cette méthode envoie une requête `POST` pour ajouter un nouvel artwork aux favoris de l'utilisateur. Si le token JWT est expiré, elle réinitialise l'état d'authentification de `ContentViewModel`.
    /// - Parameters:
    ///   - idArtwork: L'identifiant de l'artwork à ajouter aux favoris.
    ///   - contentViewModel: Le ViewModel de contenu, utilisé pour gérer l'authentification de l'utilisateur en cas d'expiration du token.
    func addFavorite(idArtwork: UUID, contentViewModel: ContentViewModel) {
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
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 401 {
                    DispatchQueue.main.async {
                        KeychainManager.deleteTokenFromKeychain()
                        contentViewModel.isAuthenticated = false
                        contentViewModel.currentUser = nil
                    }
                    return
                }
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
    
    /// Cette méthode envoie une requête `DELETE` pour retirer un favori de l'utilisateur. Si le token JWT est expiré, elle réinitialise l'état d'authentification de `ContentViewModel`.
    /// - Parameters:
    ///   - favoriteId: L'identifiant du favori à supprimer.
    ///   - contentViewModel: Le ViewModel de contenu, utilisé pour gérer l'authentification de l'utilisateur en cas d'expiration du token.
    func deleteFavorite(favoriteId: UUID, contentViewModel: ContentViewModel) {
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
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 401 {
                    DispatchQueue.main.async {
                        KeychainManager.deleteTokenFromKeychain()
                        contentViewModel.isAuthenticated = false
                        contentViewModel.currentUser = nil
                    }
                    return
                }
            }
            
            DispatchQueue.main.async {
                self.favorites.removeAll { $0.id == favoriteId }
            }
        }.resume()
    }
    
    /// Vérifie si un artwork est déjà dans les favoris de l'utilisateur.
    /// - Parameter artworkId: L'identifiant de l'artwork à vérifier.
    /// - Returns: Un booléen indiquant si l'artwork est dans les favoris (`true`) ou non (`false`).
    func isFavorited(artworkId: UUID) -> Bool {
        return favorites.contains { $0.id_artwork == artworkId }
    }
}
