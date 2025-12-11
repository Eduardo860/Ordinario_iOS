//
//  SchoolProvider.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 10/12/25.
//
import Foundation

protocol SchoolProvider {
    func fetchConfig(completion: @escaping (SchoolConfig?) -> Void)
    func fetchAnnouncements(completion: @escaping ([Announcement]) -> Void)
    func fetchSubjects(for studentId: String, completion: @escaping ([Subject]) -> Void)
    func fetchTasks(for studentId: String, completion: @escaping ([Task]) -> Void)
    func fetchGrades(for studentId: String, completion: @escaping ([Grade]) -> Void)
    func fetchStudent(studentId: String, completion: @escaping (Student?) -> Void)
}

