//
//  SubjectsListView.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 06/12/25.
//
import SwiftUI

struct SubjectsListView: View {
    
    @EnvironmentObject var vm: SchoolViewModel
    
    private let lightBackground = Color(red: 0.95, green: 0.95, blue: 0.97)
    
    var body: some View {
        // Usamos config dinámica
        let config = vm.config ?? SchoolConfig.preview
        let primaryColor = Color(hex: config.primaryColor)
        
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    
                    ForEach(vm.subjects, id: \.id) { subject in
                        NavigationLink {
                            SubjectDetailView(
                                subjectName: subject.name,
                                schedule: subject.schedule
                            )
                        } label: {
                            SubjectRowView(
                                title: subject.name,
                                schedule: subject.schedule,
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
        .environmentObject(SchoolViewModel())
}
