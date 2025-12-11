//
//  Task.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 10/12/25.
//
import Foundation

struct Task: Codable, Identifiable {
    var id: String { title }  
    
    let title: String
    let subject: String
    let status: String
    let dueDate: String
}

