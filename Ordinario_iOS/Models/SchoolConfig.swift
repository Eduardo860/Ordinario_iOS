//
//  SchoolConfig.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 10/12/25.
//

import Foundation

struct SchoolConfig: Codable {
    let name: String
    let logo: String
    let welcomeMessage: String
    let homeText: String
    let supportUrl: String
    let primaryColor: String
    let secondaryColor: String
}


extension SchoolConfig {
    static let preview: SchoolConfig = SchoolConfig(
        name: "Plataforma Educativa",
        logo: "https://us.123rf.com/450wm/blumer/blumer1411/blumer141100027/33238082-white-book-icon-on-blue-background-flat-design.jpg",
        welcomeMessage: "Bienvenido a tu plataforma educativa",
        homeText: "Consulta tus materias, tareas y calificaciones",
        supportUrl: "https://soporte.demo.com",
        primaryColor: "#0055ff",
        secondaryColor: "#ffffff"
    )
}
