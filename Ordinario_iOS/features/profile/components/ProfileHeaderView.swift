//
//  ProfileHeaderView.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 06/12/25.
//
import SwiftUI

struct ProfileHeaderView: View {

    let config: SchoolConfig
    let student: Student?
    
    var body: some View {
        VStack(spacing: 12) {
            
            
            ZStack {
                Circle()
                    .fill(Color(hex: config.primaryColor).opacity(0.15))
                    .frame(width: 110, height: 110)
                
              
                AsyncImage(url: URL(string: student?.profilePicture ?? config.logo)) { image in
                    image.resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 90, height: 90)
                        .padding(6)
                } placeholder: {
                    ProgressView()
                        .tint(.gray)
                }
            }
            
            // Nombre del estudiante y correo (si existe)
            Text(student?.name ?? "Estudiante")
                .font(.title2.bold())
                .foregroundColor(.black)
            
            Text(student?.email ?? "Correo no disponible")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.bottom, 12)
    }
}

#Preview {
    ProfileHeaderView(
        config: .preview,
        student: Student(name: "Diego Hernández", email: "test@mail.com", career: "Ingeniería", group: "7A", profilePicture: "")
    )
}
