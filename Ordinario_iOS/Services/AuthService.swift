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
    
    // Backend URL - defaults to localhost for development
    // Use configure(baseURL:) to set production URL before using the service
    private var baseURL = "http://localhost:3000/auth"
    
    private let keychainManager = KeychainManager.shared
    
    private init() {}
    
    // MARK: - Configuration
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
            if let errorMessage = try? JSONDecoder().decode([String:  String].self, from: data),
               let message = errorMessage["message"] {
                throw AuthError.serverError(message)
            }
            throw AuthError.serverError("Error del servidor:  \(httpResponse.statusCode)")
        }
        
        do {
            // 🔥 CAMBIO AQUÍ: Decodificar la respuesta envuelta
            let backendResponse = try JSONDecoder().decode(BackendResponse<AuthResponse>.self, from: data)
            let authResponse = backendResponse.data
            
            // Guardar token en keychain
            _ = keychainManager.saveToken(authResponse.token)
            
            return authResponse
        } catch {
            print("❌ Decoding error: \(error)")
            if let jsonString = String(data: data, encoding: .utf8) {
                print("📄 Response JSON: \(jsonString)")
            }
            throw AuthError.decodingError
        }
    }
    
    // MARK: - Register
    func register(email: String, password: String, name: String, institutionId: String, career: String, group: String) async throws -> AuthResponse {
        guard let url = URL(string: "\(baseURL)/register") else {
            throw AuthError.invalidURL
        }
        
        // Crear el studentData
        let studentData = RegisterRequest.StudentData(
            name: name,
            career: career,
            group: group,
            email: email
        )
        
        // Crear el request completo
        let registerRequest = RegisterRequest(
            email: email,
            password: password,
            institutionId: institutionId,
            studentData:  studentData
        )
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(registerRequest)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw AuthError.invalidResponse
        }
        
        if httpResponse.statusCode == 401 {
            throw AuthError.invalidCredentials
        }
        
        guard httpResponse.statusCode == 201 || httpResponse.statusCode == 200 else {
            if let errorMessage = try? JSONDecoder().decode([String:  String].self, from: data),
               let message = errorMessage["message"] {
                throw AuthError.serverError(message)
            }
            
            // Imprimir el error para debug
            if let jsonString = String(data: data, encoding: .utf8) {
                print("❌ Server error response: \(jsonString)")
            }
            
            throw AuthError.serverError("Error del servidor:  \(httpResponse.statusCode)")
        }
        
        do {
            let backendResponse = try JSONDecoder().decode(BackendResponse<AuthResponse>.self, from: data)
            let authResponse = backendResponse.data
            
            _ = keychainManager.saveToken(authResponse.token)
            
            return authResponse
        } catch {
            print("❌ Decoding error: \(error)")
            if let jsonString = String(data:  data, encoding: .utf8) {
                print("📄 Response JSON: \(jsonString)")
            }
            throw AuthError.decodingError
        }
    }
    
    // MARK: - Get Current User
    func getCurrentUser() async throws -> AuthResponse {
        guard let token = keychainManager.getToken() else {
            throw AuthError.noToken
        }
        
        guard let url = URL(string: "\(baseURL)/me") else {
            throw AuthError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw AuthError.invalidResponse
        }
        
        if httpResponse.statusCode == 401 {
            keychainManager.deleteToken()
            throw AuthError.invalidCredentials
        }
        
        guard httpResponse.statusCode == 200 else {
            throw AuthError.serverError("Error del servidor: \(httpResponse.statusCode)")
        }
        
        do {
            // Decodificar como BackendResponse<AuthResponse>
            let backendResponse = try JSONDecoder().decode(BackendResponse<AuthResponse>.self, from: data)
            return backendResponse.data
        } catch {
            print("❌ Decoding error: \(error)")
            throw AuthError.decodingError
        }
    }
    
    // MARK:  - Logout
    func logout() {
        keychainManager.deleteToken()
    }
    
    // MARK: - Has Valid Token
    func hasValidToken() -> Bool {
        return keychainManager.getToken() != nil
    }
}

