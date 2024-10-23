//
//  ProfileViewModel.swift
//  Tag-It
//
//  Created by Aurélien on 23/10/2024.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var user: User?

    func fetchUser(by uuid: UUID) {
        guard let url = URL(string: "http://localhost:8080/users/\(uuid.uuidString)") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedUser = try JSONDecoder().decode(User.self, from: data)
                    DispatchQueue.main.async {
                        self.user = decodedUser
                    }
                } catch {
                    print("Erreur de décodage : \(error)")
                }
            } else if let error = error {
                print("Erreur de requête : \(error)")
            }
        }.resume()
    }
}