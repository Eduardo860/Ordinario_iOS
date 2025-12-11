//
//  FirebaseSchoolProvider.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 10/12/25.
//
import Foundation
import FirebaseDatabase

class FirebaseSchoolProvider: SchoolProvider {
    
    private let ref = Database.database().reference()
    private let schoolId = "nahualschool"  // puedes hacerlo dinámico
    
    // MARK: - Config
    func fetchConfig(completion: @escaping (SchoolConfig?) -> Void) {
        ref.child("institutions").child(schoolId).child("config").observeSingleEvent(of: .value) { snap in
            guard let dict = snap.value as? [String: Any] else { return completion(nil) }
            let config = SchoolAdapter.convertConfig(dict: dict)
            completion(config)
        }
    }
    
    // MARK: - Announcements
    func fetchAnnouncements(completion: @escaping ([Announcement]) -> Void) {
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
    
    // MARK: - Subjects
    func fetchSubjects(for studentId: String, completion: @escaping ([Subject]) -> Void) {
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

    // MARK: - Tasks
    func fetchTasks(for studentId: String, completion: @escaping ([Task]) -> Void) {
        ref.child("institutions").child(schoolId).child("tasks").child(studentId)
            .observe(.value) { snap in
                
                var list: [Task] = []
                
                for child in snap.children {
                    if let snap = child as? DataSnapshot,
                       let dict = snap.value as? [String: Any] {
                        list.append(SchoolAdapter.convertTask(id: snap.key, dict: dict))
                    }
                }
                completion(list)
            }
    }
    
    // MARK: - Grades
    func fetchGrades(for studentId: String, completion: @escaping ([Grade]) -> Void) {
        ref.child("institutions").child(schoolId).child("grades").child(studentId).child("ios")
            .observe(.value) { snap in
                
                var list: [Grade] = []
                
                for child in snap.children {
                    if let snap = child as? DataSnapshot,
                       let dict = snap.value as? [String: Any] {
                        list.append(SchoolAdapter.convertGrade(id: snap.key, dict: dict))
                    }
                }
                completion(list)
            }
    }
    
    // MARK: - Student
    func fetchStudent(studentId: String, completion: @escaping (Student?) -> Void) {
        ref.child("institutions").child(schoolId).child("students").child(studentId)
            .observeSingleEvent(of: .value) { snap in
                
                guard let dict = snap.value as? [String: Any] else { return completion(nil) }
                
                let student = Student(
                    name: dict["name"] as? String ?? "",
                    email: dict["email"] as? String ?? "",
                    career: dict["career"] as? String ?? "",
                    group: dict["group"] as? String ?? ""
                )
                
                completion(student)
            }
    }
}

