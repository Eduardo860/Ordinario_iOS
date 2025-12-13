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
    
    @Published var isAuthenticated:  Bool = false
    @Published var currentUser: User?
    @Published var currentStudent: Student?  // ← AGREGAR ESTO
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
            Task { @MainActor in
                do {
                    let response = try await authService.getCurrentUser()
                    currentUser = response.user.toUser(withStudent: response.student)
                    currentStudent = response.student  // ← GUARDAR STUDENT
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
            currentUser = response.user.toUser(withStudent: response.student)
            currentStudent = response.student  // ← GUARDAR STUDENT
            isAuthenticated = true
        } catch {
            errorMessage = error.localizedDescription
            isAuthenticated = false
        }
        
        isLoading = false
    }
    
    // MARK: - Register
    func register(email: String, password:  String, name: String, institutionId: String, career: String, group: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await authService.register(
                email: email,
                password: password,
                name:  name,
                institutionId:  institutionId,
                career:  career,
                group: group
            )
            currentUser = response.user.toUser(withStudent: response.student)
            currentStudent = response.student
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
        currentStudent = nil  // ← LIMPIAR STUDENT
        isAuthenticated = false
    }
}
