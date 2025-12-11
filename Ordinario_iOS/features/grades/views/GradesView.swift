//
//  GradesView.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 06/12/25.
//
import SwiftUI

struct GradesView: View {
    
    @EnvironmentObject var vm: SchoolViewModel 
    
    private let lightBackground = Color(red: 0.95, green: 0.95, blue: 0.97)
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                
                GradeHeaderView()
                    .padding(.horizontal)
                    .padding(.top, 16)
                
                ForEach(vm.grades, id: \.id) { grade in
                    GradeRowView(
                        subjectName: grade.title,
                        grade: String(grade.value),
                        primaryColor: Color(hex: vm.config?.primaryColor ?? "#63c")
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
    GradesView()
        .environmentObject(SchoolViewModel())
}
