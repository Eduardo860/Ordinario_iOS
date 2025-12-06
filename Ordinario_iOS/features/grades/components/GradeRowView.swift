//
//  GradeRowView.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 06/12/25.
//
import SwiftUI

struct GradeRowView: View {
    let subjectName: String
    let grade: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 16) {
            
            // Ícono con color institucional
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(color.opacity(0.12))
                    .frame(width: 48, height: 48)
                
                Image(systemName: "chart.bar.fill")
                    .foregroundColor(color)
                    .font(.title3)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(subjectName)
                    .font(.headline)
                    .foregroundColor(.black)
                
                Text("Calificación final")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Calificación grande a la derecha
            Text(grade)
                .font(.title2.bold())
                .foregroundColor(color)
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
    GradeRowView(
        subjectName: "Cálculo Integral",
        grade: "9.2",
        color: Color(red: 0.63, green: 0.00, blue: 0.24)
    )
}

