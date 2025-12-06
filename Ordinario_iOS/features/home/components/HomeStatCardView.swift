//
//  HomeStatCardView.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 03/12/25.
//
import SwiftUI

struct HomeStatCardView: View {
    let title: String
    let value: String
    let subtitle: String
    let primaryColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            
            Text(value)
                .font(.title.bold())
                .foregroundColor(primaryColor)
            
            Text(subtitle)
                .font(.footnote)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.06), radius: 8)
        )
    }
}

#Preview {
    HomeStatCardView(
        title: "Materias",
        value: "6",
        subtitle: "Inscritas",
        primaryColor: Color(red: 0.63, green: 0.00, blue: 0.24)
    )
}

