//
//  HomeHeaderView.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 03/12/25.
//
import SwiftUI

struct HomeHeaderView: View {
    let institutionName: String
    let welcomeMessage: String
    let studentName: String
    let primaryColor: Color
    
    var body: some View {
        HStack(spacing: 16) {
            
            // Logo institucional o avatar
            ZStack {
                Circle()
                    .fill(primaryColor.opacity(0.15))
                    .frame(width: 60, height: 60)
                
                Image("InstitutionLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 38, height: 38)
            }
            
            // Textos
            VStack(alignment: .leading, spacing: 4) {
                Text(institutionName)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text(welcomeMessage)
                    .font(.body)
                
                Text(studentName)
                    .font(.headline.bold())
                    .foregroundColor(primaryColor)
            }
            
            Spacer()
        }
    }
}

#Preview {
    HomeHeaderView(
        institutionName: "Universidad Modelo",
        welcomeMessage: "Bienvenido",
        studentName: "Alex Johnson",
        primaryColor: Color(red: 0.63, green: 0.00, blue: 0.24)
    )
}

