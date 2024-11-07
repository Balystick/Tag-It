//
//  Token.swift
//  FrontVapor
//
//  Created by Amandine Cousin on 31/10/2024.
//

import Foundation

struct JWToken: Codable {
    let value: String
    
    enum CodingKeys: String, CodingKey {
        case value = "token"
    }
}
