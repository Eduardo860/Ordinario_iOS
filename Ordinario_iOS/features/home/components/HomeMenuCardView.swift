//
//  HomeMenuCardView.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 03/12/25.
//
import SwiftUI

struct HomeMenuCardView: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
                .frame(width: 38, height: 38)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(color.opacity(0.12))
                )
            
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.06), radius: 6)
        )
    }
}

#Preview {
    HomeMenuCardView(
        icon: "book.closed",
        title: "Materias",
        color: Color(red: 0.63, green: 0.00, blue: 0.24)
    )
}

