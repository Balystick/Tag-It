//
//  ArtworkViewModel.swift
//  Tag-It
//
//  Created by Aurélien on 21/10/2024.
//
import Foundation

class ArtworkViewModel: ObservableObject {
    @Published var artworks: [Artwork] = []
    
    /// Cette méthode envoie une requête `GET` à l'API pour récupérer les artworks. Si le token JWT est expiré, elle réinitialise l'état d'authentification dans `ContentViewModel`.
    /// - Parameter contentViewModel: Le ViewModel de contenu, utilisé pour gérer l'authentification de l'utilisateur en cas d'expiration du token.
    func fetchArtworks(contentViewModel: ContentViewModel) {
        guard let url = URL(string: "http://localhost:8080/artworks") else { return }

        guard let token = KeychainManager.getTokenFromKeychain() else {
            print("Erreur : Aucun token trouvé dans le Keychain")
            return
        }

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
                    let decodedElements = try JSONDecoder().decode([Artwork].self, from: data)
                    DispatchQueue.main.async {
                        self.artworks = decodedElements
                    }
                } catch {
                    print("Erreur de décodage : \(error)")
                }
            } else if let error = error {
                print("Erreur de requête : \(error.localizedDescription)")
            }
        }.resume()
    }
}
