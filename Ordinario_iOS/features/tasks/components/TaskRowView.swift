//
//  TaskRowView.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 06/12/25.
//
import SwiftUI

struct TaskRowView: View {
    
    let task: StudentTask  // ← Cambiar a recibir el objeto completo
    let primaryColor: Color
    let onStatusChange: (StudentTask, String) -> Void  // ← Callback para cambio de status
    
    var statusColor: Color {
        switch task.status.lowercased() {
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
            HStack {
                Text(task.title)
                    .font(. headline)
                    .foregroundColor(.black)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
                
                // ✅ BOTÓN PARA MARCAR COMO ENTREGADA
                if task.status.lowercased() == "pendiente" {
                    Button(action: {
                        onStatusChange(task, "Entregada")
                    }) {
                        Image(systemName: "checkmark.circle")
                            .font(.title2)
                            .foregroundColor(primaryColor)
                    }
                } else {
                    Image(systemName: "checkmark. circle. fill")
                        .font(. title2)
                        .foregroundColor(. green)
                }
            }
            
            // Materia
            HStack {
                Image(systemName: "book.fill")
                    .foregroundColor(primaryColor)
                Text(task.subject)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            // Fecha + Estado
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(. gray)
                Text(task.dueDate)
                    .foregroundColor(.gray)
                    .font(.subheadline)
                
                Spacer()
                
                Text(task.status)
                    .font(.caption.bold())
                    .padding(. horizontal, 10)
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
                .shadow(color: . black.opacity(0.05), radius: 4, x: 0, y: 2)
        )
    }
}

#Preview {
    TaskRowView(
        task: StudentTask(
            id:  "1",
            title: "Entrega reporte de investigación",
            subject: "Cálculo Integral",
            status: "Pendiente",
            dueDate:  "18 Nov 2025"
        ),
        primaryColor: Color(hex: SchoolConfig.preview.primaryColor),
        onStatusChange: { _, _ in }
    )
}
