//
//  Artwork.swift
//  Tag-It
//
//  Created by Apprenant 124 on 21/10/2024.
//

import Foundation

struct Artwork: Codable, Identifiable {
    let id: UUID
    let title: String
    let image: String
    let type: String
    let address: String
    let city: String
    let country: String
    let date: String
    let latitude: Double
    let longitude: Double
}

