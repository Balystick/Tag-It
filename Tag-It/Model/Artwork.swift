//
//  Artwork.swift
//  Tag-It
//
//  Created by Apprenant 124 on 21/10/2024.
//

import Foundation

struct Artwork: Codable, Identifiable {
    var id: UUID?
    var title: String
    var image: String
    var type: String
    var address: String
    var city: String
    var country: String
    var date: String
    var latitude: Double
    var longitude: Double
    var points: String
    var id_artist: UUID?
}
