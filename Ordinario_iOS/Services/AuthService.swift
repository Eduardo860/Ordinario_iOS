//
//  AuthService.swift
//  Ordinario_iOS
//
//  Authentication service for backend API communication
//

import Foundation

enum AuthError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case invalidCredentials
    case serverError(String)
    case noToken
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL inválida"
        case .invalidResponse:
            return "Respuesta inválida del servidor"
        case .invalidCredentials:
            return "Credenciales inválidas"
        case .serverError(let message):
            return message
        case .noToken:
            return "No hay token de autenticación"
        case .decodingError:
            return "Error al procesar la respuesta"
        }
    }
}

class AuthService {
    
    static let shared = AuthService()
    
    // Backend URL - can be configured for dev/production
    private var baseURL = "http://localhost:3000/api/auth"
    
    private let keychainManager = KeychainManager.shared
    
    private init() {}
    
    // Configure base URL (for switching between dev/prod)
    func configure(baseURL: String) {
        self.baseURL = baseURL
    }
    
    // MARK: - Login
    func login(email: String, password: String) async throws -> AuthResponse {
        guard let url = URL(string: "\(baseURL)/login") else {
            throw AuthError.invalidURL
        }
        
        let loginRequest = LoginRequest(email: email, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(loginRequest)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw AuthError.invalidResponse
        }
        
        if httpResponse.statusCode == 401 {
            throw AuthError.invalidCredentials
        }
        
        guard httpResponse.statusCode == 200 else {
            if let errorMessage = try? JSONDecoder().decode([String: String].self, from: data),
               let message = errorMessage["message"] {
                throw AuthError.serverError(message)
            }
            throw AuthError.serverError("Error del servidor: \(httpResponse.statusCode)")
        }
        
        do {
            let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
            // Save token to keychain
            _ = keychainManager.saveToken(authResponse.token)
            return authResponse
        } catch {
            throw AuthError.decodingError
        }
    }
    
    // MARK: - Register
    func register(email: String, password: String, name: String) async throws -> AuthResponse {
        guard let url = URL(string: "\(baseURL)/register") else {
            throw AuthError.invalidURL
        }
        
        let registerRequest = RegisterRequest(email: email, password: password, name: name)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(registerRequest)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw AuthError.invalidResponse
        }
        
        guard httpResponse.statusCode == 200 || httpResponse.statusCode == 201 else {
            if let errorMessage = try? JSONDecoder().decode([String: String].self, from: data),
               let message = errorMessage["message"] {
                throw AuthError.serverError(message)
            }
            throw AuthError.serverError("Error del servidor: \(httpResponse.statusCode)")
        }
        
        do {
            let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
            // Save token to keychain
            _ = keychainManager.saveToken(authResponse.token)
            return authResponse
        } catch {
            throw AuthError.decodingError
        }
    }
    
    // MARK: - Get Current User
    func getCurrentUser() async throws -> User {
        guard let token = keychainManager.getToken() else {
            throw AuthError.noToken
        }
        
        guard let url = URL(string: "\(baseURL)/me") else {
            throw AuthError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw AuthError.invalidResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            throw AuthError.serverError("Error del servidor: \(httpResponse.statusCode)")
        }
        
        do {
            let user = try JSONDecoder().decode(User.self, from: data)
            return user
        } catch {
            throw AuthError.decodingError
        }
    }
    
    // MARK: - Logout
    func logout() {
        keychainManager.deleteToken()
    }
    
    // MARK: - Check if has valid token
    func hasValidToken() -> Bool {
        return keychainManager.getToken() != nil
    }
}
