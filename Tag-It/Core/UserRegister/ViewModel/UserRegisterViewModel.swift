//
//  UserRegisterViewModel.swift
//  Tag-It
//
//  Created by Apprenant 124 on 07/11/2024.
//

import Foundation
import SwiftUI

class UserRegisterViewModel: ObservableObject {
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage: ErrorMessage?
    
    private let baseURL = "http://127.0.0.1:8080/users/create"

    func registration(contentViewModel: ContentViewModel) async {
        guard let url = URL(string: baseURL) else {
            DispatchQueue.main.async {
                self.errorMessage = ErrorMessage(message: "URL invalide")
            }
            return
        }
        
        let registrationData = UserRegistrationData(
            username: self.username,
            email: self.email,
            password: self.password
        )
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(registrationData)
            request.httpBody = jsonData
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = ErrorMessage(message: "Erreur d'encodage des données d'inscription")
            }
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                DispatchQueue.main.async {
                    self.errorMessage = ErrorMessage(message: "Inscription échouée. Veuillez vérifier vos informations.")
                }
                return
            }
            
            do {
                let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
                
                KeychainManager.saveTokenToKeychain(token: authResponse.token)
                
                DispatchQueue.main.async {
                    contentViewModel.isAuthenticated = true
                    contentViewModel.currentUser = authResponse.user  // Assigner l'utilisateur au ContentViewModel
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = ErrorMessage(message: "Erreur de décodage de la réponse du serveur")
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = ErrorMessage(message: "Erreur réseau : \(error.localizedDescription)")
            }
        }
    }
}
