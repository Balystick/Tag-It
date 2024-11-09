//
//  AuthResponse.swift
//  Tag-It
//
//  Created by Aurélien on 09/11/2024.
//

struct AuthResponse: Codable {
    let token: String
    let user: User
}
