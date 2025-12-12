import SwiftUI
import Combine

class SchoolViewModel: ObservableObject {
    
    @Published var config: SchoolConfig? // Configuración de la escuela
    @Published var announcements: [Announcement] = [] // Anuncios
    @Published var subjects: [Subject] = [] // Materias
    @Published var tasks: [Task] = [] // Tareas
    @Published var grades: [Grade] = [] // Calificaciones
    @Published var student: Student? // Estudiante
    
    private let provider: SchoolProvider
    
    // schoolId puede cambiar dinámicamente
    @Published var schoolId: String = "nahualschool"
    
    // Inicialización
    init(provider: SchoolProvider = FirebaseSchoolProvider()) {
        self.provider = provider
        loadInitialData(studentId: "alumno02")
    }
    
    // Cargar datos de Firebase
    func loadInitialData(studentId: String) {
        // Usar schoolId dinámico en las llamadas de Firebase
        provider.fetchConfig(schoolId: schoolId) { [weak self] config in
            self?.config = config
        }
        
        provider.fetchAnnouncements(schoolId: schoolId) { [weak self] list in
            self?.announcements = list
        }
        
        provider.fetchSubjects(for: studentId, schoolId: schoolId) { [weak self] list in
            self?.subjects = list
        }
        
        provider.fetchTasks(for: studentId, schoolId: schoolId) { [weak self] list in
            self?.tasks = list
        }
        
        provider.fetchGrades(for: studentId, schoolId: schoolId) { [weak self] list in
            self?.grades = list
        }
        
        provider.fetchStudent(studentId: studentId, schoolId: schoolId) { [weak self] student in
            self?.student = student
        }
    }
}
