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
    let primaryColor: Color
    
    var statusColor: Color {
        return grade >= "9.0" ? .green : grade >= "7.0" ? .orange : .red
    }
    
    var body: some View {
        HStack(spacing: 16) {
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(primaryColor.opacity(0.12))
                    .frame(width: 48, height: 48)
                
                Image(systemName: "chart.bar.fill")
                    .foregroundColor(primaryColor)
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
            
            Text(grade)
                .font(.title2.bold())
                .foregroundColor(primaryColor)
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
        primaryColor: Color(hex: SchoolConfig.preview.primaryColor)
    )
        .environmentObject(SchoolViewModel())
}
