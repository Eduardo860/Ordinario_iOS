//
//  TaskFilterBarView.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 06/12/25.
//
import SwiftUI

struct TaskFilterBarView: View {
    
    let primaryColor: Color
    
    @State private var selectedFilter = "Pendientes"
    
    private let filters = ["Pendientes", "Entregadas", "Todas"]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                
                ForEach(filters, id: \.self) { filter in
                    Button {
                        selectedFilter = filter
                    } label: {
                        Text(filter)
                            .font(.subheadline)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(filter == selectedFilter ?
                                          primaryColor.opacity(0.15) :
                                          Color.white)
                            )
                            .foregroundColor(filter == selectedFilter ? primaryColor : .gray)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .strokeBorder(filter == selectedFilter ?
                                                  primaryColor.opacity(0.5) :
                                                  Color.gray.opacity(0.3))
                            )
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    TaskFilterBarView(
        primaryColor: Color(red: 0.63, green: 0.00, blue: 0.24)
    )
}

