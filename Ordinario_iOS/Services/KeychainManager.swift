//
//  KeychainManager.swift
//  Ordinario_iOS
//
//  Secure token storage using Keychain
//

import Foundation
import Security

class KeychainManager {
    
    static let shared = KeychainManager()
    private let serviceIdentifier = "com.ordinario.ios.auth"
    private let tokenKey = "authToken"
    
    private init() {}
    
    // MARK: - Save Token
    func saveToken(_ token: String) -> Bool {
        guard let tokenData = token.data(using: .utf8) else {
            return false
        }
        
        // Delete any existing token first
        deleteToken()
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceIdentifier,
            kSecAttrAccount as String: tokenKey,
            kSecValueData as String: tokenData
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    // MARK: - Get Token
    func getToken() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceIdentifier,
            kSecAttrAccount as String: tokenKey,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess,
              let data = result as? Data,
              let token = String(data: data, encoding: .utf8) else {
            return nil
        }
        
        return token
    }
    
    // MARK: - Delete Token
    func deleteToken() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceIdentifier,
            kSecAttrAccount as String: tokenKey
        ]
        
        SecItemDelete(query as CFDictionary)
    }
}
