//
//  FirebaseSchoolProvider.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 10/12/25.
//
import FirebaseDatabase
class FirebaseSchoolProvider: SchoolProvider {
    
    private let ref = Database.database().reference()
    
    // Cambiar la función fetchConfig para aceptar el schoolId dinámico
    func fetchConfig(schoolId: String, completion: @escaping (SchoolConfig?) -> Void) {
        ref.child("institutions").child(schoolId).child("config").observeSingleEvent(of: .value) { snap in
            guard let dict = snap.value as? [String: Any] else { return completion(nil) }
            let config = SchoolAdapter.convertConfig(dict: dict)
            completion(config)
        }
    }
    
    // Cambiar la función fetchAnnouncements para aceptar el schoolId dinámico
    func fetchAnnouncements(schoolId: String, completion: @escaping ([Announcement]) -> Void) {
        ref.child("institutions").child(schoolId).child("announcements").observe(.value) { snap in
            var list: [Announcement] = []
            
            for child in snap.children {
                if let snap = child as? DataSnapshot,
                   let dict = snap.value as? [String: Any] {
                    list.append(SchoolAdapter.convertAnnouncement(id: snap.key, dict: dict))
                }
            }
            completion(list)
        }
    }
    
    // Cambiar la función fetchSubjects para aceptar el schoolId dinámico
    func fetchSubjects(for studentId: String, schoolId: String, completion: @escaping ([Subject]) -> Void) {
        ref.child("institutions").child(schoolId).child("subjects").child(studentId)
            .observe(.value) { snap in
                var list: [Subject] = []
                
                for child in snap.children {
                    if let snap = child as? DataSnapshot,
                       let dict = snap.value as? [String: Any] {
                        list.append(SchoolAdapter.convertSubject(id: snap.key, dict: dict))
                    }
                }
                completion(list)
            }
    }

    // Cambiar la función fetchTasks para aceptar el schoolId dinámico
    func fetchTasks(for studentId: String, schoolId: String, completion: @escaping ([StudentTask]) -> Void) {
        ref.child("institutions").child(schoolId).child("tasks").child(studentId)
            .observe(.value) { snap in
                var list: [StudentTask] = []
                
                for child in snap.children {
                    if let snap = child as? DataSnapshot,
                       let dict = snap.value as? [String: Any] {
                        list.append(SchoolAdapter.convertTask(id: snap.key, dict: dict))
                    }
                }
                completion(list)
            }
    }
    
    // MARK: - Update Task Status
    func updateTaskStatus(taskId: String, studentId:  String, schoolId: String, newStatus: String, completion: @escaping (Bool) -> Void) {
        ref.child("institutions").child(schoolId).child("tasks").child(studentId).child(taskId)
            .updateChildValues(["status": newStatus]) { error, _ in
                if let error = error {
                    print("❌ Error updating task:  \(error.localizedDescription)")
                    completion(false)
                } else {
                    print("✅ Task updated successfully")
                    completion(true)
                }
            }
    }
    
    // MARK: - Fetch Grades
    func fetchGrades(for studentId: String, schoolId: String, completion: @escaping ([Grade]) -> Void) {
        ref.child("institutions").child(schoolId).child("grades").child(studentId)
            .observe(.value) { snapshot in
                var list: [Grade] = []
                
                // Primer nivel: subjectIds
                for subjectChild in snapshot.children {
                    guard let subjectSnap = subjectChild as? DataSnapshot else { continue }
                    let subjectId = subjectSnap.key
                    
                    // Segundo nivel: grades de esa materia
                    for gradeChild in subjectSnap.children {
                        guard let gradeSnap = gradeChild as?  DataSnapshot,
                              let dict = gradeSnap.value as? [String: Any] else { continue }
                        
                        // Convertir el grade y agregar el subjectId
                        var grade = SchoolAdapter.convertGrade(id: gradeSnap.key, dict: dict)
                        
                        // Crear un nuevo Grade con el subjectId incluido
                        // (necesitamos modificar el modelo para que sea mutable o recrearlo)
                        let gradeWithSubject = Grade(
                            id:  grade.id,
                            title: grade.title,
                            value: grade.value,
                            subjectId: subjectId,
                            subjectName: nil,  // Lo obtendremos después si es necesario
                            date:  grade.date,
                            weight: grade.weight
                        )
                        
                        list.append(gradeWithSubject)
                    }
                }
                
                completion(list)
            }
    }
    
    
    // Cambiar la función fetchStudent para aceptar el schoolId dinámico
    func fetchStudent(studentId: String, schoolId: String, completion: @escaping (Student?) -> Void) {
        ref.child("institutions").child(schoolId).child("students").child(studentId)
            .observeSingleEvent(of: .value) { snap in
            guard let dict = snap.value as? [String: Any] else { return completion(nil) }
            let student = Student(
                name: dict["name"] as? String ?? "",
                email: dict["email"] as? String ?? "",
                career: dict["career"] as? String ?? "",
                group: dict["group"] as? String ?? "",
                profilePicture: dict["profilePicture"] as? String,
                password: dict["password"] as? String ?? ""
            )
            completion(student)
        }
    }
}
