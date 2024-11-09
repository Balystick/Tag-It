//
//  Favorite.swift
//  Tag-It
//
//  Created by Aurélien on 22/10/2024.
//

import SwiftUI

struct Favorite: Codable {
    var id: UUID?
    var date_added: String
    var id_artwork: UUID
}
