//
//  SplashView.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 03/12/25.
//

import SwiftUI

struct SplashView: View {
    // Luego esto vendrá de Firebase / ViewModel
    private let appName: String = "EduApp"
    private let institutionName: String = "Nombre de la institución"
    private let primaryColor: Color = Color(red: 0.63, green: 0.0, blue: 0.24) // rojo vino
    
    var body: some View {
        ZStack {
            primaryColor
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                
                Spacer()
                
                // Logo circular
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 120, height: 120)
                        .shadow(radius: 10)
                    
                    Image("AppLogo") // TODO: agrega imagen al Assets
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                }
                
                // Nombre de la app / institución
                VStack(spacing: 4) {
                    Text(appName)
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)
                    
                    Text(institutionName)
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.8))
                }
                
                Spacer()
                
                // Loading / mensaje dinámico
                VStack(spacing: 8) {
                    ProgressView()
                        .tint(.white)
                    
                    Text("Cargando configuración…")
                        .font(.footnote)
                        .foregroundStyle(.white.opacity(0.8))
                }
                .padding(.bottom, 40)
            }
            .padding(.horizontal, 32)
        }
    }
}

#Preview {
    SplashView()
}
