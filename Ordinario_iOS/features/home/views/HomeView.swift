//
//  HomeView.swift
//  Ordinario_iOS
//
//  Eduardo Pérez Córdova

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var vm: SchoolViewModel
    
    var body: some View {
        
        let config = vm.config ?? SchoolConfig.preview
        let student = vm.student
        
        let primaryColor = Color(hex: config.primaryColor)
        let backgroundColor = Color(hex: config.secondaryColor).opacity(0.1)
        
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    
                    // HEADER
                    HomeHeaderView(
                        config: config,
                        student: student
                    )
                    .padding(.horizontal)
                    .padding(.top, 16)
                    
                    // ESTADÍSTICAS DINÁMICAS
                    HStack(spacing: 12) {
                        HomeStatCardView(
                            title: "Materias",
                            value: "\(vm.subjects.count)",
                            subtitle: "Inscritas",
                            primaryColor: primaryColor
                        )
                        
                        HomeStatCardView(
                            title: "Promedio",
                            value: vm.grades.isEmpty
                                ? "--"
                                : String(format: "%.1f", vm.grades.map{$0.value}.average),
                            subtitle: "Actual",
                            primaryColor: primaryColor
                        )
                    }
                    .padding(.horizontal)
                    
                    // GRID DE MÓDULOS
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Módulos")
                            .font(.headline)
                            .foregroundColor(primaryColor)
                            .padding(.horizontal)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 14) {
                            
                            NavigationLink {
                                SubjectsListView()  // Navegar a la vista de materias
                            } label: {
                                HomeMenuCardView(icon: "book.closed", title: "Materias", primaryColor: primaryColor)
                            }
                            
                            NavigationLink {
                                GradesView()  // Navegar a la vista de calificaciones
                            } label: {
                                HomeMenuCardView(icon: "chart.bar.fill", title: "Calificaciones", primaryColor: primaryColor)
                            }
                            
                            NavigationLink {
                                TasksView()  // Navegar a la vista de tareas
                            } label: {
                                HomeMenuCardView(icon: "checklist", title: "Tareas", primaryColor: primaryColor)
                            }
                            
                            NavigationLink {
                                AnnouncementsView()  // Navegar a la vista de anuncios
                            } label: {
                                HomeMenuCardView(icon: "megaphone.fill", title: "Anuncios", primaryColor: primaryColor)
                            }
                            
                            NavigationLink {
                                ProfileView()  // Navegar a la vista de perfil
                            } label: {
                                HomeMenuCardView(icon: "person.crop.circle", title: "Perfil", primaryColor: primaryColor)
                            }
                            
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 24)
                        
                    }
                }
            }
            .background(backgroundColor)
            .navigationTitle("Dashboard")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(SchoolViewModel())
}
