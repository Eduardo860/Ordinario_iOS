//
//  AuthViewModel.swift
//  Ordinario_iOS
//
//  ViewModel for authentication management
//

import Foundation
import SwiftUI

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
    
    // MARK: - Check Auth Status
    func checkAuthStatus() {
        if authService.hasValidToken() {
            isAuthenticated = true
            // Optionally fetch current user
            Task {
                do {
                    currentUser = try await authService.getCurrentUser()
                } catch {
                    // If fetching user fails, token might be invalid
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
            currentUser = response.user
            isAuthenticated = true
        } catch {
            errorMessage = error.localizedDescription
            isAuthenticated = false
        }
        
        isLoading = false
    }
    
    // MARK: - Register
    func register(email: String, password: String, name: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await authService.register(email: email, password: password, name: name)
            currentUser = response.user
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
