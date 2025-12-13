import SwiftUI
import Combine

class SchoolViewModel: ObservableObject {
    
    @Published var config: SchoolConfig?
    @Published var announcements: [Announcement] = []
    @Published var subjects: [Subject] = []
    @Published var tasks: [StudentTask] = []
    @Published var grades: [Grade] = []
    @Published var student: Student?
    
    private let provider:  SchoolProvider
    private var cancellables = Set<AnyCancellable>()
    
    // schoolId puede cambiar dinámicamente
    @Published var schoolId: String = "nahualschool"
    @Published var studentId: String?  = nil  // ← AHORA ES OPCIONAL
    
    // Inicialización SIN cargar datos automáticamente
    init(provider:  SchoolProvider = FirebaseSchoolProvider()) {
        self.provider = provider
        // NO cargar datos aquí, esperar a que se autentique
    }
    
    // Cargar datos cuando se tenga el studentId
    func loadData(for student: Student) {
        self.studentId = student.id
        self.schoolId = student.institutionId
        self.student = student
        
        // Cargar config
        provider.fetchConfig(schoolId: schoolId) { [weak self] config in
            self?.config = config
        }
        
        // Cargar announcements
        provider.fetchAnnouncements(schoolId:  schoolId) { [weak self] list in
            self?.announcements = list
        }
        
        // Cargar subjects
        provider.fetchSubjects(for: student.id, schoolId: schoolId) { [weak self] list in
            self?.subjects = list
        }
        
        // Cargar tasks
        provider.fetchTasks(for: student.id, schoolId: schoolId) { [weak self] list in
            self?.tasks = list
        }
        
        // Cargar grades
        provider.fetchGrades(for: student.id, schoolId: schoolId) { [weak self] list in
            self?.grades = list
        }
    }
    
    // Método para recargar datos si es necesario
    func reloadData() {
        guard let student = student else { return }
        loadData(for: student)
    }
}
