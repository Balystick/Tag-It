//
//  KeychainManager.swift
//  Tag-It
//

import Foundation
import Security

struct KeychainManager {
    
    /// Cette méthode encode le token en données, supprime toute clé existante portant le même nom, puis enregistre le token dans le Keychain sous la clé `"token"`.
    /// - Parameter token: Le token d'authentification à sauvegarder.
    static func saveTokenToKeychain(token: String) {
        guard let tokenData = token.data(using: .utf8) else {
            print("Erreur encodage token")
            return
        }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "token",
            kSecValueData as String: tokenData
        ]
        
        SecItemDelete(query as CFDictionary)
        
        SecItemAdd(query as CFDictionary, nil)
    }
    
    /// Cette méthode cherche l'élément correspondant à la clé `"token"` dans le Keychain, et retourne le token sous forme de chaîne de caractères s'il est trouvé.
    /// - Returns: Le token d'authentification sous forme de `String` s'il est trouvé, `nil` sinon.
    static func getTokenFromKeychain() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "token",
            kSecReturnData as String: true
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        if status == errSecSuccess, let data = item as? Data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    /// Cette méthode supprime l'élément identifié par la clé `"token"` du Keychain, supprimant ainsi le token d'authentification de l'utilisateur.
    static func deleteTokenFromKeychain() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "token"
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        if status == errSecSuccess {
            print("Token supprimé avec succès.")
        } else {
            print("Erreur lors de la suppression du token : \(status)")
        }
    }
}
