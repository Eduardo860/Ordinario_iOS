//
//  RegisterView.swift
//  Ordinario_iOS
//
//  User registration view
//

import SwiftUI

struct RegisterView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isPasswordVisible = false
    @State private var isConfirmPasswordVisible = false
    
    @EnvironmentObject var vm: SchoolViewModel
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        let config = vm.config ?? SchoolConfig.preview
        
        NavigationStack {
            ZStack {
                Color(hex: config.primaryColor)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 32) {
                        
                        VStack(spacing: 16) {
                            // Logo
                            AsyncImage(url: URL(string: config.logo)) { image in
                                image.resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 120)
                                    .clipShape(Circle())
                            } placeholder: {
                                ProgressView()
                                    .tint(.gray)
                            }
                            
                            Text("Crear Cuenta")
                                .font(.largeTitle.bold())
                                .foregroundColor(.white)
                        }
                        .padding(.top, 40)
                        
                        VStack(spacing: 20) {
                            
                            // Name Field
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Nombre completo")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                
                                TextField("Juan Pérez", text: $name)
                                    .padding(.horizontal, 12)
                                    .frame(height: 44)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.white)
                                            .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 4)
                                    )
                                    .padding(.horizontal)
                            }
                            
                            // Email Field
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Email")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                
                                TextField("correo@ejemplo.com", text: $email)
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(.none)
                                    .padding(.horizontal, 12)
                                    .frame(height: 44)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.white)
                                            .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 4)
                                    )
                                    .padding(.horizontal)
                            }
                            
                            // Password Field
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Contraseña")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                
                                HStack {
                                    if isPasswordVisible {
                                        TextField("••••••••", text: $password)
                                            .autocapitalization(.none)
                                    } else {
                                        SecureField("••••••••", text: $password)
                                            .autocapitalization(.none)
                                    }
                                    
                                    Button {
                                        isPasswordVisible.toggle()
                                    } label: {
                                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                            .foregroundColor(Color(hex: config.primaryColor))
                                    }
                                }
                                .padding(.horizontal, 12)
                                .frame(height: 44)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.white)
                                        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 4)
                                )
                                .padding(.horizontal)
                            }
                            
                            // Confirm Password Field
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Confirmar contraseña")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                
                                HStack {
                                    if isConfirmPasswordVisible {
                                        TextField("••••••••", text: $confirmPassword)
                                            .autocapitalization(.none)
                                    } else {
                                        SecureField("••••••••", text: $confirmPassword)
                                            .autocapitalization(.none)
                                    }
                                    
                                    Button {
                                        isConfirmPasswordVisible.toggle()
                                    } label: {
                                        Image(systemName: isConfirmPasswordVisible ? "eye.slash" : "eye")
                                            .foregroundColor(Color(hex: config.primaryColor))
                                    }
                                }
                                .padding(.horizontal, 12)
                                .frame(height: 44)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.white)
                                        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 4)
                                )
                                .padding(.horizontal)
                                
                                // Password match validation
                                if !confirmPassword.isEmpty && password != confirmPassword {
                                    Text("Las contraseñas no coinciden")
                                        .font(.caption)
                                        .foregroundColor(.red)
                                        .padding(.horizontal)
                                }
                            }
                            
                            // Register Button
                            Button {
                                Task {
                                    await authVM.register(email: email, password: password, name: name)
                                    if authVM.isAuthenticated {
                                        dismiss()
                                    }
                                }
                            } label: {
                                if authVM.isLoading {
                                    ProgressView()
                                        .tint(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 50)
                                } else {
                                    Text("Registrarse")
                                        .font(.headline)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 50)
                                }
                            }
                            .background(Color(hex: config.primaryColor))
                            .foregroundColor(.white)
                            .cornerRadius(14)
                            .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 6)
                            .disabled(!isFormValid || authVM.isLoading)
                            .opacity((!isFormValid || authVM.isLoading) ? 0.6 : 1.0)
                            .padding(.top, 4)
                            
                            // Error Message
                            if let errorMessage = authVM.errorMessage {
                                Text(errorMessage)
                                    .font(.caption)
                                    .foregroundColor(.red)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                            }
                        }
                        .padding(24)
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .fill(Color.white)
                                .shadow(color: .black.opacity(0.08), radius: 12)
                        )
                        .padding(.horizontal, 24)
                        
                        Spacer()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                    .foregroundColor(.white)
                }
            }
        }
    }
    
    // Form validation
    private var isFormValid: Bool {
        !name.isEmpty &&
        !email.isEmpty &&
        !password.isEmpty &&
        !confirmPassword.isEmpty &&
        password == confirmPassword &&
        password.count >= 6
    }
}

#Preview {
    RegisterView()
        .environmentObject(SchoolViewModel())
        .environmentObject(AuthViewModel())
}
