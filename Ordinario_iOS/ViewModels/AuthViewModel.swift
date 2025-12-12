//
//  AuthViewModel.swift
//  Ordinario_iOS
//
//  ViewModel for authentication management
//

import Foundation
import SwiftUI
import Combine

@MainActor
class AuthViewModel: ObservableObject {
    
    @Published var isAuthenticated: Bool = false
    @Published var currentUser: User?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let authService = AuthService.shared
    
    init() {
        checkAuthStatus()
    }

    func checkAuthStatus() {
        if authService.hasValidToken() {
            isAuthenticated = true
            // Load user asynchronously
            Task { @MainActor in
                do {
                    currentUser = try await authService.getCurrentUser()
                } catch {
                    isAuthenticated = false
                    authService.logout()
                }
            }
        } else {
            isAuthenticated = false
        }
    }
    
    // MARK: - Login
    func login(email: String, password: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await authService.login(email: email, password: password)
            
            // Convertir FirebaseUser + Student a User
            currentUser = response.user.toUser(withStudent: response.student)
            
            // Opcional: Guardar información del estudiante si la necesitas
            // Puedes crear una propiedad @Published var currentStudent: Student?
            
            isAuthenticated = true
        } catch {
            errorMessage = error.localizedDescription
            isAuthenticated = false
        }
        
        isLoading = false
    }

    // MARK: - Register
    func register(email: String, password: String, name: String, institutionId: String?) async {
        isLoading = true
        errorMessage = nil
        
        let resolvedInstitutionId = institutionId ?? "nahualschool"
        
        do {
            let response = try await authService.register(email: email, password:  password, name: name, institutionId: resolvedInstitutionId)
            
            // Convertir FirebaseUser + Student a User
            currentUser = response.user.toUser(withStudent: response.student)
            
            isAuthenticated = true
        } catch {
            errorMessage = error.localizedDescription
            isAuthenticated = false
        }
        
        isLoading = false
    }
    
    // MARK: - Logout
    func logout() {
        authService.logout()
        currentUser = nil
        isAuthenticated = false
    }
}
