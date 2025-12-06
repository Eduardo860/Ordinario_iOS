//
//  ProfileOptionRowView.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 06/12/25.
//
import SwiftUI

struct ProfileOptionRowView: View {
    
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 16) {
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(color.opacity(0.12))
                    .frame(width: 48, height: 48)
                
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.title3)
            }
            
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(
                    color: .black.opacity(0.05),
                    radius: 4,
                    x: 0, y: 2
                )
        )
    }
}

#Preview {
    ProfileOptionRowView(
        icon: "gearshape.fill",
        title: "Configuración",
        color: Color(red: 0.63, green: 0.00, blue: 0.24)
    )
}

