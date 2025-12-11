//
//  HomeHeaderView.swift
//  Ordinario_iOS
//

import SwiftUI

struct HomeHeaderView: View {

    let config: SchoolConfig
    let student: Student?
    
    var body: some View {
        HStack(spacing: 16) {
            
            
            ZStack {
                Circle()
                    .fill(Color(hex: config.primaryColor).opacity(0.15))
                    .frame(width: 60, height: 60)
                
               
                AsyncImage(url: URL(string: config.logo)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 38, height: 38)
                        .padding(6)  // Un poco de espacio entre el logo y el borde
                } placeholder: {
                    ProgressView()
                        .tint(.gray)
                }
            }
            
            // Textos dinámicos
            VStack(alignment: .leading, spacing: 4) {
                
                
                Text(config.name)
                    .font(.caption)
                    .foregroundColor(Color(hex: config.secondaryColor)) // Usamos secondaryColor para el texto de la institución
                
                Text(config.welcomeMessage)
                    .font(.body)
                    .foregroundColor(Color(hex: config.secondaryColor))
                 
                
                Text(student?.name ?? "Estudiante")
                    .font(.headline.bold())
                    .foregroundColor(Color(hex: config.primaryColor)) 
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    HomeHeaderView(
        config: .preview,
        student: Student(name: "Diego Hernández", email: "test@mail.com", career: "Ing", group: "7A", profilePicture: "")
    )
}
