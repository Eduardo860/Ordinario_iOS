//
//  StudentTask.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 10/12/25.
//
import Foundation

struct StudentTask:  Codable, Identifiable, Equatable {
    let id: String
    let title: String
    let subject: String
    var status: String  
    let dueDate:  String
    
    // Inicializador
    init(id: String, title: String, subject: String, status: String, dueDate: String) {
        self.id = id
        self.title = title
        self.subject = subject
        self.status = status
        self.dueDate = dueDate
    }
}
