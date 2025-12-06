//
//  SubjectRowView.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 06/12/25.
//
import SwiftUI

struct SubjectRowView: View {
    let title: String
    let schedule: String
    let primaryColor: Color
    
    var body: some View {
        HStack(spacing: 16) {
            
            // Ícono del curso
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(primaryColor.opacity(0.12))
                    .frame(width: 48, height: 48)
                
                Image(systemName: "book.fill")
                    .font(.title3)
                    .foregroundColor(primaryColor)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.black)
                
                Text(schedule)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        )
    }
}

#Preview {
    SubjectRowView(
        title: "Cálculo Integral",
        schedule: "Lun / Mié · 10:00 - 11:30",
        primaryColor: Color(red: 0.63, green: 0.00, blue: 0.24)
    )
}

