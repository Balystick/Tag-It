//
//  KeychainManager.swift
//  FrontVapor
//
//  Created by Amandine Cousin on 31/10/2024.
//
import Foundation
import Security

struct KeychainManager {
    static func saveTokenToKeychain(token: String) {
        // Convertir le token en data
        guard let tokenData = token.data(using: .utf8) else {
            print("Erreur encodage token")
            return
        }
        
        // Créer un dictionnaire de requete pour le trousseau
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "token",
            kSecValueData as String: tokenData
        ]
        
        // Supprimer la clé existante
        SecItemDelete(query as CFDictionary)
        
        // Ajouter le token dans le trousseau
        SecItemAdd(query as CFDictionary, nil)
    }
    
    static func getTokenFromKeychain() -> String? {
        // Configurer la requête pour trouver l'élément dans le trousseau
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "token",
            kSecReturnData as String: true
        ]
        
        // Rechercher l'élément
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        // Décoder les données en chaîne de caractères
        if status == errSecSuccess, let data = item as? Data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}
