//
//  Grade.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 10/12/25.
//
import Foundation

struct Grade:  Codable, Identifiable, Equatable {
    let id: String
    let title: String
    let value: Int
    let subjectId: String?
    let subjectName: String?
    let date: String?
    let weight: Double?
    
    init(id: String, title: String, value: Int, subjectId: String?  = nil, subjectName: String? = nil, date: String?  = nil, weight: Double? = nil) {
        self.id = id
        self.title = title
        self.value = value
        self.subjectId = subjectId
        self.subjectName = subjectName
        self.date = date
        self.weight = weight
    }
}
