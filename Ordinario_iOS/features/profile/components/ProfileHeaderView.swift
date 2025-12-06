//
//  ProfileHeaderView.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 06/12/25.
//
import SwiftUI

struct ProfileHeaderView: View {
    
    let primaryColor: Color
    
    var body: some View {
        VStack(spacing: 12) {
            
            // Foto o avatar
            ZStack {
                Circle()
                    .fill(primaryColor.opacity(0.15))
                    .frame(width: 110, height: 110)
                
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                    .foregroundColor(primaryColor)
            }
            
            // Nombre del estudiante
            Text("Alex Johnson")
                .font(.title2.bold())
                .foregroundColor(.black)
            
            // Correo / matrícula
            Text("alex.johnson@universidad.edu")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.bottom, 12)
    }
}

#Preview {
    ProfileHeaderView(primaryColor: Color(red: 0.63, green: 0.00, blue: 0.24))
}

