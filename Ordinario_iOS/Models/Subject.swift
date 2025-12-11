//
//  Subject.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 10/12/25.
//
import Foundation

struct Subject: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
    let schedule: String
    let teacher: String
}

