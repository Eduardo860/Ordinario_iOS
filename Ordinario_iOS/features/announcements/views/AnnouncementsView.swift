//
//  AnnouncementsView.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 06/12/25.
//
import SwiftUI

struct AnnouncementsView: View {
    
    @EnvironmentObject var vm: SchoolViewModel  
    
    private let lightBackground = Color(red: 0.95, green: 0.95, blue: 0.97)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    
                    ForEach(vm.announcements, id: \.id) { item in
                        AnnouncementCardView(
                            title: item.title,
                            message: item.message,
                            date: item.date,
                            primaryColor: Color(hex: vm.config?.primaryColor ?? "#63c")
                        )
                    }
                }
                .padding(.horizontal)
                .padding(.top, 16)
            }
            .background(lightBackground.ignoresSafeArea())
            .navigationTitle("Anuncios")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    AnnouncementsView()
        .environmentObject(SchoolViewModel())
}
