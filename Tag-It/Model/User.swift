//
//  User.swift
//  Tag-It
//
//  Created by Aurélien on 23/10/2024.
//

import Foundation

class User: Codable, Identifiable {
    let id: UUID
    let username: String
    let name: String
    let image: String
    let email: String
    let password: String?
    let points: Int
}
