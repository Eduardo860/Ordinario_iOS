//
//  ProfileView.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 06/12/25.
//
import SwiftUI

struct ProfileView: View {
    
    private let primaryColor = Color(red: 0.63, green: 0.00, blue: 0.24)
    private let lightBackground = Color(red: 0.95, green: 0.95, blue: 0.97)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    
                    // Encabezado del perfil
                    ProfileHeaderView(primaryColor: primaryColor)
                        .padding(.top, 16)
                    
                    // Opciones del perfil
                    VStack(spacing: 16) {
                        
                        ProfileOptionRowView(
                            icon: "person.fill",
                            title: "Datos personales",
                            color: primaryColor
                        )
                        
                        ProfileOptionRowView(
                            icon: "key.fill",
                            title: "Cambiar contraseña",
                            color: primaryColor
                        )
                        
                        ProfileOptionRowView(
                            icon: "doc.text.fill",
                            title: "Historial académico",
                            color: primaryColor
                        )
                        
                        ProfileOptionRowView(
                            icon: "gearshape.fill",
                            title: "Configuración",
                            color: primaryColor
                        )
                        
                        ProfileOptionRowView(
                            icon: "arrowshape.turn.up.left.fill",
                            title: "Cerrar sesión",
                            color: .red
                        )
                        
                    }
                    .padding(.horizontal)
                }
            }
            .background(lightBackground.ignoresSafeArea())
            .navigationTitle("Perfil")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    ProfileView()
}

