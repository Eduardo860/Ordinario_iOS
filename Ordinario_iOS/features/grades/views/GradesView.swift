//
//  GradesView.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 06/12/25.
//
import SwiftUI

struct GradesView: View {
    
    // Colores institucionales
    private let primaryColor = Color(red: 0.63, green: 0.00, blue: 0.24)
    private let lightBackground = Color(red: 0.95, green: 0.95, blue: 0.97)
    
    // Datos falsos por ahora
    private let grades = [
        ("Cálculo Integral", "9.2"),
        ("Programación Orientada a Objetos", "9.8"),
        ("Bases de Datos", "8.7"),
        ("Ingeniería de Software", "9.5"),
        ("Probabilidad y Estadística", "8.9")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                
                GradeHeaderView(primaryColor: primaryColor)
                    .padding(.horizontal)
                    .padding(.top, 16)
                
                ForEach(grades, id: \.0) { materia in
                    GradeRowView(
                        subjectName: materia.0,
                        grade: materia.1,
                        color: primaryColor
                    )
                }
            }
            .padding(.horizontal)
        }
        .background(lightBackground.ignoresSafeArea())
        .navigationTitle("Calificaciones")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack {
        GradesView()
    }
}

