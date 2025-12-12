//
//  User.swift
//  Ordinario_iOS
//
//  Created for authentication system
//

import Foundation

// MARK: - User Model
struct User: Codable, Identifiable {
    let id: String
    let email: String
    let name: String
    let role: String?
    
    // CodingKeys to map MongoDB's _id to id
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case email
        case name
        case role
    }
}

// MARK: - Auth Response
struct AuthResponse: Codable {
    let token: String
    let user: User
}

// MARK: - Login Request
struct LoginRequest: Codable {
    let email: String
    let password: String
}

// MARK: - Register Request
struct RegisterRequest: Codable {
    let email: String
    let password: String
    let name: String
}
