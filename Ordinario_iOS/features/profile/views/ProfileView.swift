//
//  ProfileView.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 06/12/25.
//
import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var vm: SchoolViewModel
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        
        
        let config = vm.config ?? SchoolConfig.preview
        let student = vm.student
        
        let primaryColor = Color(hex: config.primaryColor)
        let lightBackground = Color(hex: config.secondaryColor).opacity(0.1)
        
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    
                    // Encabezado del perfil
                    ProfileHeaderView(config: config, student: student)
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
                        
                        Button {
                            authVM.logout()
                        } label: {
                            ProfileOptionRowView(
                                icon: "arrowshape.turn.up.left.fill",
                                title: "Cerrar sesión",
                                color: .red
                            )
                        }
                        
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
        .environmentObject(SchoolViewModel())
        .environmentObject(AuthViewModel())
}
