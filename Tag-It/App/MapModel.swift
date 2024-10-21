//
//  MapModel.swift
//  Tag-It
//
//  Created by Audrey on 18/10/2024.
//

import Foundation

class ArtWork: Codable, Identifiable {
    let id: UUID
    let title: String
    let image: String
    let type: String
    let address: String
    let postalCode: Int
    let city: String
    let country: String
    let latitude: Double
    let longitude: Double
    let points: Int
//    let idArtist: REFERENCES artist(id)
}
