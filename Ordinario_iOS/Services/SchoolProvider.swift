//
//  SchoolProvider.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 10/12/25.
//
protocol SchoolProvider {
    func fetchConfig(schoolId: String, completion: @escaping (SchoolConfig?) -> Void)
    func fetchAnnouncements(schoolId: String, completion: @escaping ([Announcement]) -> Void)
    func fetchSubjects(for studentId: String, schoolId: String, completion: @escaping ([Subject]) -> Void)
    func fetchTasks(for studentId: String, schoolId: String, completion: @escaping ([StudentTask]) -> Void)
    func fetchGrades(for studentId: String, schoolId: String, completion: @escaping ([Grade]) -> Void)
    func fetchStudent(studentId: String, schoolId: String, completion: @escaping (Student?) -> Void)
}

