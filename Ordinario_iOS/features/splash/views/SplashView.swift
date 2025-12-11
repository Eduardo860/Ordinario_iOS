//
//  SplashView.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 03/12/25.
//

import SwiftUI

struct SplashView: View {
    
    @EnvironmentObject var vm: SchoolViewModel  // Usamos SchoolViewModel
    
    var body: some View {
        let config = vm.config ?? SchoolConfig.preview  // Usamos config dinámica

        ZStack {
            Color(hex: config.primaryColor)  // Fondo con color primario dinámico
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()

                // Logo de la institución
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 120, height: 120)
                        .shadow(radius: 10)
                    
                    AsyncImage(url: URL(string: config.logo)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                    } placeholder: {
                        ProgressView()
                            .tint(.gray)
                    }
                }

                // Nombre de la app / institución
                VStack(spacing: 4) {
                    Text(config.name)
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                    
                    Text(config.welcomeMessage)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
                
                Spacer()

                // Loading / mensaje dinámico
                VStack(spacing: 8) {
                    ProgressView()
                        .tint(.white)
                    
                    Text("Cargando configuración…")
                        .font(.footnote)
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(.bottom, 40)
            }
            .padding(.horizontal, 32)
        }
    }
}

#Preview {
    SplashView()
        .environmentObject(SchoolViewModel()) 
}
