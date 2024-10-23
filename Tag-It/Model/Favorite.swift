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
    var id_artwork: UUID
    var id_user: UUID
}
