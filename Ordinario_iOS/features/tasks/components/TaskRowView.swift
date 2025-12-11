//
//  TaskRowView.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 06/12/25.
//
import SwiftUI

struct TaskRowView: View {
    
    let title: String
    let subject: String
    let status: String
    let date: String
    let primaryColor: Color
    
    var statusColor: Color {
        switch status.lowercased() {
        case "pendiente":
            return .orange
        case "entregada":
            return .green
        default:
            return .gray
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            // Título
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
                .fixedSize(horizontal: false, vertical: true)
            
            // Materia
            HStack {
                Image(systemName: "book.fill")
                    .foregroundColor(primaryColor)
                Text(subject)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            // Fecha + Estado
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(.gray)
                Text(date)
                    .foregroundColor(.gray)
                    .font(.subheadline)
                
                Spacer()
                
                Text(status)
                    .font(.caption.bold())
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(statusColor.opacity(0.15))
                    .foregroundColor(statusColor)
                    .cornerRadius(10)
            }
            
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
    TaskRowView(
        title: "Entrega reporte de investigación",
        subject: "Cálculo Integral",
        status: "Pendiente",
        date: "18 Nov 2025",
        primaryColor: Color(hex: SchoolConfig.preview.primaryColor)
    )
}
