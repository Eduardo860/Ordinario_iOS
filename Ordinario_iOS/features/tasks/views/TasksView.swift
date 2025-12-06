//
//  TasksView.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 06/12/25.
//
import SwiftUI

struct TasksView: View {
    
    // Colores institucionales
    private let primaryColor = Color(red: 0.63, green: 0.00, blue: 0.24)
    private let lightBackground = Color(red: 0.95, green: 0.95, blue: 0.97)
    
    // Datos dummy por ahora
    private let tasks = [
        ("Entrega reporte de investigación", "Cálculo Integral", "Pendiente", "18 Nov 2025"),
        ("Proyecto final unidad 3", "POO", "Entregada", "12 Nov 2025"),
        ("Script SQL Normalización", "Bases de Datos", "Pendiente", "22 Nov 2025"),
        ("Caso de uso — Documentación", "Ing. Software", "Pendiente", "20 Nov 2025")
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // Filtro (chips)
                    TaskFilterBarView(primaryColor: primaryColor)
                        .padding(.top, 16)
                    
                    // Lista de tareas
                    ForEach(tasks, id: \.0) { task in
                        TaskRowView(
                            title: task.0,
                            subject: task.1,
                            status: task.2,
                            date: task.3,
                            primaryColor: primaryColor
                        )
                    }
                }
                .padding(.horizontal)
            }
            .background(lightBackground.ignoresSafeArea())
            .navigationTitle("Tareas")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    TasksView()
}

