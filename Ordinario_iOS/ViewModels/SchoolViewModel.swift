//
//  SchoolViewModel.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 10/12/25.
//

import SwiftUI
import Combine

class SchoolViewModel: ObservableObject {
    
    @Published var config: SchoolConfig? // Configuración de la escuela
    @Published var announcements: [Announcement] = [] // Anuncios
    @Published var subjects: [Subject] = [] // Materias
    @Published var tasks: [Task] = [] // Tareas
    @Published var grades: [Grade] = [] // Calificaciones
    @Published var student: Student? // Estudiante
    
    private let provider: SchoolProvider // Proveedor de datos (Firebase o Mock)
    
    // Inicialización
    init(provider: SchoolProvider = FirebaseSchoolProvider()) {
        self.provider = provider
        loadInitialData(studentId: "alumno02") // Cargar datos del alumno con ID "alumno02"
    }
    
    // Cargar datos de Firebase
    func loadInitialData(studentId: String) {
        
        // Cargar configuración
        provider.fetchConfig { [weak self] config in
            self?.config = config
        }
        
        // Cargar anuncios
        provider.fetchAnnouncements { [weak self] list in
            self?.announcements = list
        }
        
        // Cargar materias
        provider.fetchSubjects(for: studentId) { [weak self] list in
            self?.subjects = list
        }
        
        // Cargar tareas
        provider.fetchTasks(for: studentId) { [weak self] list in
            self?.tasks = list
        }
        
        // Cargar calificaciones
        provider.fetchGrades(for: studentId) { [weak self] list in
            self?.grades = list
        }
        
        // Cargar datos del estudiante
        provider.fetchStudent(studentId: studentId) { [weak self] student in
            self?.student = student
        }
    }
}
