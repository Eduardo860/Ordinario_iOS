//
//  User.swift
//  Ordinario_iOS
//
//  Created for authentication system
//

import Foundation

// MARK: - Backend Response Wrapper
struct BackendResponse<T: Codable>:  Codable {
    let status:  Int
    let data: T
}

// MARK: - Auth Response (lo que viene en "data")
struct AuthResponse: Codable {
    let token: String
    let user: FirebaseUser
    let student: Student  // ← Usa el Student de Student.swift
}

// MARK: - Firebase User (lo que viene en "user")
struct FirebaseUser: Codable {
    let uid: String
    let email: String
    
    // Convertir a User para usar en la app
    func toUser(withStudent student: Student) -> User {
        return User(
            id: uid,
            email: email,
            name: student.name,
            role: "student"
        )
    }
}

// MARK: - User Model (modelo unificado para la app)
struct User: Codable, Identifiable {
    let id: String
    let email:  String
    let name: String
    let role: String?
}

// MARK: - Login Request
struct LoginRequest: Codable {
    let email: String
    let password: String
}

// MARK: - Register Request
struct RegisterRequest:  Codable {
    let email: String
    let password: String
    let institutionId: String
    let studentData: StudentData
    
    struct StudentData: Codable {
        let name: String
        let career: String
        let group:  String
        let email: String
    }
}
