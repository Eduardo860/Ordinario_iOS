//
//  AnnouncementsView.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 06/12/25.
//
import SwiftUI

struct AnnouncementsView: View {
    
    // Colores institucionales
    private let primaryColor = Color(red: 0.63, green: 0.00, blue: 0.24)  // rojo vino
    private let lightBackground = Color(red: 0.95, green: 0.95, blue: 0.97) // gris clarito
    
    // Datos dummy por ahora
    private let announcements = [
        (
            "Suspensión de clases",
            "Las actividades académicas se suspenden el día 20 por mantenimiento eléctrico.",
            "18 Nov 2025"
        ),
        (
            "Entrega de credenciales",
            "Los estudiantes podrán recoger sus credenciales en la oficina de control escolar.",
            "16 Nov 2025"
        ),
        (
            "Simulacro general",
            "Se realizará un simulacro de evacuación obligatorio para toda la comunidad.",
            "14 Nov 2025"
        ),
        (
            "Actualización de plataforma",
            "La plataforma estará en mantenimiento el sábado de 3 a 7 PM.",
            "12 Nov 2025"
        )
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    ForEach(announcements, id: \.0) { item in
                        AnnouncementCardView(
                            title: item.0,
                            message:item.1,
                            date: item.2,
                            primaryColor: primaryColor
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
}
