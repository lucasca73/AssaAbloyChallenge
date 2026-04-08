//
//  KeychainManager.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 08/04/26.
//

import Foundation

enum KeychainKey {
    static let accessToken  = "com.devcostaluc.AssaAbloyChallenge.access_token"
}

// MARK: - Errors

enum KeychainError: Error {
    case saveFailed(OSStatus)
    case readFailed(OSStatus)
    case deleteFailed(OSStatus)
    case dataConversionFailed
    case itemNotFound
}

// MARK: - Keychain Manager

protocol KeychainManagerProtocol {
    func save(_ value: String, for key: String) throws
    func read(for key: String) throws -> String
    func delete(for key: String) throws
}

final class KeychainManager: KeychainManagerProtocol {

    // MARK: - Save

    func save(_ value: String, for key: String) throws {
        guard let data = value.data(using: .utf8) else {
            throw KeychainError.dataConversionFailed
        }

        // Delete existing before saving to avoid duplicates
        try? delete(for: key)

        let query: [CFString: Any] = [
            kSecClass:           kSecClassGenericPassword,
            kSecAttrAccount:     key,
            kSecValueData:       data,
            kSecAttrAccessible:  kSecAttrAccessibleWhenUnlockedThisDeviceOnly
        ]

        let status = SecItemAdd(query as CFDictionary, nil)

        guard status == errSecSuccess else {
            throw KeychainError.saveFailed(status)
        }
    }

    // MARK: - Read

    func read(for key: String) throws -> String {
        let query: [CFString: Any] = [
            kSecClass:            kSecClassGenericPassword,
            kSecAttrAccount:      key,
            kSecReturnData:       true,
            kSecMatchLimit:       kSecMatchLimitOne
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        guard status != errSecItemNotFound else {
            throw KeychainError.itemNotFound
        }

        guard status == errSecSuccess else {
            throw KeychainError.readFailed(status)
        }

        guard
            let data = result as? Data,
            let value = String(data: data, encoding: .utf8)
        else {
            throw KeychainError.dataConversionFailed
        }

        return value
    }

    // MARK: - Delete

    func delete(for key: String) throws {
        let query: [CFString: Any] = [
            kSecClass:       kSecClassGenericPassword,
            kSecAttrAccount: key
        ]

        let status = SecItemDelete(query as CFDictionary)

        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError.deleteFailed(status)
        }
    }
}
