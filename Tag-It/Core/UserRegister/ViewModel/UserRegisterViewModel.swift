//
//  UserRegisterViewModel.swift
//  Tag-It
//
//  Created by Apprenant 124 on 07/11/2024.
//

import Foundation

class UserRegisterViewModel: ObservableObject {
    @Published var username = ""
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    
    private let baseURL = "http://127.0.0.1:8080/users"

    func registration() async throws {
        guard let url = URL(string: "\(baseURL)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: [
                "username": self.username,
                "name": self.name,
                "image": "",
                "email": self.email,
                "password": self.password,
                "points": 0
            ])
        } catch {
            fatalError("Error: \(error.localizedDescription)")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error, let responseHttp = response as? HTTPURLResponse, responseHttp.statusCode != 200 {
                print("Error: \(error.localizedDescription)")
            }
        }.resume()
    }
}
