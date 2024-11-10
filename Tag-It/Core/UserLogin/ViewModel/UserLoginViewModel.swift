//
//  UserLoginViewModel.swift
//  Tag-It
//
//  Created by Apprenant 124 on 07/11/2024.
//

import Foundation
import SwiftUI

import SwiftUI

class UserLoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage: ErrorMessage?

    private let baseURL = "http://127.0.0.1:8080/users/login"

    func login(contentViewModel: ContentViewModel) async {
        var errors = [String]()

        if email.isEmpty {
            errors.append("L'adresse email est obligatoire.")
        } else if !isValidEmail(email) {
            errors.append("L'adresse email n'est pas valide.")
        }
        
        if password.isEmpty {
            errors.append("Le mot de passe est obligatoire.")
        }

        if !errors.isEmpty {
            let combinedErrorMessage = errors.joined(separator: "\n")
            setError(combinedErrorMessage)
            return
        }

        guard let url = URL(string: baseURL) else {
            setError("URL invalide")
            return
        }

        let loginData = UserLoginData(
            email: self.email,
            password: self.password
        )

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let jsonData = try JSONEncoder().encode(loginData)
            request.httpBody = jsonData
        } catch {
            setError("Erreur d'encodage des données de connexion")
            return
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                setError("Authentification échouée. Veuillez vérifier vos identifiants.")
                return
            }
            
            do {
                let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
                
                KeychainManager.saveTokenToKeychain(token: authResponse.token)
                
                DispatchQueue.main.async {
                    contentViewModel.isAuthenticated = true
                    contentViewModel.currentUser = authResponse.user
                }
            } catch {
                setError("Erreur de décodage de la réponse du serveur")
            }
        } catch {
            setError("Erreur réseau : \(error.localizedDescription)")
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func setError(_ message: String) {
        DispatchQueue.main.async {
            self.errorMessage = ErrorMessage(message: message)
        }
    }
}
