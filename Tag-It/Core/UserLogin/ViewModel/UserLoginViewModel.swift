//
//  UserLoginViewModel.swift
//  Tag-It
//
//  Created by Aurélien on 07/11/2024.
//

import Foundation

class UserLoginViewModel: ObservableObject {
        
    func login(email: String, password: String) {
        // Configurer l'url
        let url: URL = URL(string: "http://127.0.0.1:8080/users/login")!
        var request = URLRequest(url: url)
        
        // Configurer la requete
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Encode les identifiants
        let authData = (email + ":" + password).data(using: .utf8)!.base64EncodedString()
        request.addValue("Basic \(authData)", forHTTPHeaderField: "Authorization")
        
        // Executer la requete
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil, let responseHttp = response as? HTTPURLResponse, responseHttp.statusCode == 200, let data = data else {
                print("Error : \(String(describing: error?.localizedDescription))")
                return
            }
            
            print("Authentification réussie")
            
            do {
                // Decode le token
                let token = try JSONDecoder().decode(JWToken.self, from: data)
                print("token : ", token.value)
                
                // Sauvegarder le token dans le keychain
                KeychainManager.saveTokenToKeychain(token: token.value)
            } catch {
                print("Il y a une erreur de decodage du token")
            }
        }.resume()
    }
    
}
