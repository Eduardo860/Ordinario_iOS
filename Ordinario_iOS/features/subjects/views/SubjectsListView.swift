//
//  SubjectsListView.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 06/12/25.
//
import SwiftUI

struct SubjectsListView: View {
    
    // Colores institucionales
    private let primaryColor = Color(red: 0.63, green: 0.00, blue: 0.24)
    private let lightBackground = Color(red: 0.95, green: 0.95, blue: 0.97)
    
    // Dummy data temporal
    private let subjects = [
        ("Cálculo Integral", "Lun / Mié · 10:00 - 11:30"),
        ("Programación Orientada a Objetos", "Mar / Jue · 12:00 - 13:30"),
        ("Bases de Datos", "Lun / Mié · 14:00 - 15:30"),
        ("Ingeniería de Software", "Vie · 9:00 - 12:00")
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    
                    ForEach(subjects, id: \.0) { subject in
                        NavigationLink {
                            SubjectDetailView(
                                subjectName: subject.0,
                                schedule: subject.1
                            )
                        } label: {
                            SubjectRowView(
                                title: subject.0,
                                schedule: subject.1,
                                primaryColor: primaryColor
                            )
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 16)
            }
            .background(lightBackground.ignoresSafeArea())
            .navigationTitle("Materias")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    SubjectsListView()
}

