//
//  GradeHeaderView.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 06/12/25.
//
import SwiftUI

struct GradeHeaderView:  View {
    
    @EnvironmentObject var vm: SchoolViewModel
    
    var body:  some View {
        let config = vm.config ?? SchoolConfig.preview
        let primaryColor = Color(hex: config.primaryColor)
        
        // 🔥 CALCULAR EL PROMEDIO DINÁMICAMENTE
        let averageGrade:  String = {
            if vm.grades.isEmpty {
                return "--"
            } else {
                let average = vm.grades.map { $0.value }.average
                return String(format: "%.1f", average)
            }
        }()
        
        VStack(alignment: .leading, spacing: 12) {
            
            Text("Resumen")
                .font(.title2.bold())
                .foregroundColor(primaryColor)
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Promedio General")
                        . font(.caption)
                        . foregroundColor(.gray)
                    
                    // ✅ USAR EL PROMEDIO CALCULADO
                    Text(averageGrade)
                        .font(.largeTitle.bold())
                        .foregroundColor(primaryColor)
                    
                    // OPCIONAL: Mostrar cantidad de calificaciones
                    Text("\(vm.grades.count) calificaciones")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Image(systemName: "graduationcap.fill")
                    .font(.largeTitle)
                    .foregroundColor(primaryColor.opacity(0.9))
            }
            . padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .shadow(color: .black.opacity(0.06), radius: 8)
            )
        }
    }
}

#Preview {
    GradeHeaderView()
        .environmentObject(SchoolViewModel())
}
