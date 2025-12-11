//
//  HomeMenuCardView.swift
//  Ordinario_iOS
//

import SwiftUI

struct HomeMenuCardView: View {
    let icon: String
    let title: String
    let primaryColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(primaryColor)
                .frame(width: 38, height: 38)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(primaryColor.opacity(0.12))
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
        primaryColor: Color(hex: SchoolConfig.preview.primaryColor)
    )
}
