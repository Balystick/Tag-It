//
//  Favorite.swift
//  Tag-It
//
//  Created by Aurélien on 22/10/2024.
//

import SwiftUI

struct Favorite: Codable, Identifiable {
    var id: UUID
    var dateAdded : String
    var idArtwork: UUID
    var idUser: UUID
}
