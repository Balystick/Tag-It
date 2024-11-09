//
//  Token.swift
//  Tag-It
//
//  Created by Tag-It on 31/10/2024.
//

import Foundation

struct JWToken: Codable {
    let value: String
    
    enum CodingKeys: String, CodingKey {
        case value = "token"
    }
}
