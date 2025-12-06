//
//  LoginView.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 03/12/25.
//
import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    
    // Colores institucionales
    private let primaryColor = Color(red: 0.63, green: 0.00, blue: 0.24) // rojo vino
    private let lightBackground = Color(red: 0.95, green: 0.95, blue: 0.97) // gris clarito
    
    var body: some View {
        NavigationStack {
            ZStack {
                lightBackground.ignoresSafeArea()
                
                VStack(spacing: 32) {
                    
                    // LOGO + Título
                    VStack(spacing: 16) {
                        Image("AppLogoHorizontal")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 220)
                        
                        Text("Login")
                            .font(.largeTitle.bold())
                            .foregroundColor(primaryColor)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 40)
                    
                    // Tarjeta del formulario
                    VStack(spacing: 20) {
                        
                        // Email
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Email")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            TextField("correo@ejemplo.com", text: $email)
                                .keyboardType(.emailAddress)
                                .padding(.horizontal, 12)
                                .frame(height: 44)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .strokeBorder(primaryColor.opacity(0.4))
                                )
                        }
                        
                        // Password
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Password")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            HStack {
                                if isPasswordVisible {
                                    TextField("••••••••", text: $password)
                                } else {
                                    SecureField("••••••••", text: $password)
                                }
                                
                                Button {
                                    isPasswordVisible.toggle()
                                } label: {
                                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                        .foregroundColor(primaryColor)
                                }
                            }
                            .padding(.horizontal, 12)
                            .frame(height: 44)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .strokeBorder(primaryColor.opacity(0.4))
                            )
                        }
                        
                        // Botón
                        Button {
                            // Acción futura
                        } label: {
                            Text("Sign In")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(primaryColor)
                                .foregroundColor(.white)
                                .cornerRadius(14)
                        }
                        .padding(.top, 4)
                        
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
    }
}

#Preview { LoginView() }
