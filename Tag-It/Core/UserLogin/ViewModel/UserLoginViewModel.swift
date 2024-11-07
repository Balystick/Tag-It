//
//  UserLoginViewModel.swift
//  Tag-It
//
//  Created by Aurélien on 07/11/2024.
//

import Foundation

class UserLoginViewModel: ObservableObject {
    @Published var errorMessage: ErrorMessage?
        
    func login(email: String, password: String) {
        // Configurer l'url
        guard let url = URL(string: "http://127.0.0.1:8080/users/login") else {
            self.errorMessage = ErrorMessage(message: "URL invalide")
            return
        }
        
        var request = URLRequest(url: url)
        
        // Configurer la requete
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Encode les identifiants
        let authData = (email + ":" + password).data(using: .utf8)!.base64EncodedString()
        request.addValue("Basic \(authData)", forHTTPHeaderField: "Authorization")
        
        // Executer la requete
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                   if let error = error {
                       self.errorMessage = ErrorMessage(message: "Erreur : \(error.localizedDescription)")
                       return
                   }
                   
                   guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else {
                       self.errorMessage = ErrorMessage(message: "Authentification échouée")
                       return
                   }
                   
                   do {
                       let token = try JSONDecoder().decode(JWToken.self, from: data)
                       KeychainManager.saveTokenToKeychain(token: token.value)
                   } catch {
                       self.errorMessage = ErrorMessage(message: "Erreur de décodage du token")
                   }
               }
        }.resume()
    }
}
