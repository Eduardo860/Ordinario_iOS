//
//  AnnouncementCardView.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 06/12/25.
//
import SwiftUI

struct AnnouncementCardView: View {
    
    let title: String
    let message: String
    let date: String
    let primaryColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            
            Text(title)
                .font(.headline)
                .foregroundColor(primaryColor)
            
            
            Text(message)
                .font(.body)
                .foregroundColor(.black)
                .fixedSize(horizontal: false, vertical: true)
            
            
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(.gray)
                Text(date)
                    .foregroundColor(.gray)
                    .font(.subheadline)
                
                Spacer()
            }
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 3)
        )
    }
}

#Preview {
    AnnouncementCardView(
        title: "Actualización de plataforma",
        message: "La plataforma estará en mantenimiento el sábado de 3 a 7 PM.",
        date: "12 Nov 2025",
        primaryColor: Color(hex: SchoolConfig.preview.primaryColor)
    )
}
