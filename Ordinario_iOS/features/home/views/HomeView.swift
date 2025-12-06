//
//  HomeView.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 03/12/25.
//
import SwiftUI

struct HomeView: View {
    private let institutionName = "Universidad Modelo"
    private let welcomeMessage = "Bienvenido"
    private let studentName = "Alex Johnson"
    
    // Colores institucionales
    private let primaryColor = Color(red: 0.63, green: 0.00, blue: 0.24)     // rojo vino
    private let lightBackground = Color(red: 0.95, green: 0.95, blue: 0.97)  // gris claro
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    
                    // Header institucional
                    HomeHeaderView(
                        institutionName: institutionName,
                        welcomeMessage: welcomeMessage,
                        studentName: studentName,
                        primaryColor: primaryColor
                    )
                    .padding(.horizontal)
                    .padding(.top, 16)
                    
                    // Tarjetas de estadísticas
                    HStack(spacing: 12) {
                        HomeStatCardView(
                            title: "Materias",
                            value: "6",
                            subtitle: "Inscritas",
                            primaryColor: primaryColor
                        )
                        
                        HomeStatCardView(
                            title: "Promedio",
                            value: "9.2",
                            subtitle: "Actual",
                            primaryColor: primaryColor
                        )
                    }
                    .padding(.horizontal)
                    
                    // Grid de módulos
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Módulos")
                            .font(.headline)
                            .foregroundColor(primaryColor)
                            .padding(.horizontal)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 14) {
                            
                            HomeMenuCardView(icon: "book.closed", title: "Materias", color: primaryColor)
                            HomeMenuCardView(icon: "chart.bar.fill", title: "Calificaciones", color: primaryColor)
                            HomeMenuCardView(icon: "checklist", title: "Tareas", color: primaryColor)
                            HomeMenuCardView(icon: "megaphone.fill", title: "Anuncios", color: primaryColor)
                            HomeMenuCardView(icon: "person.crop.circle", title: "Perfil", color: primaryColor)
                            HomeMenuCardView(icon: "gearshape.fill", title: "Institución", color: primaryColor)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 24)
                    }
                }
            }
            .background(lightBackground)
            .navigationTitle("Dashboard")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    HomeView()
}

