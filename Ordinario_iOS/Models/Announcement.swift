//
//  Announcement.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 10/12/25.
//
import Foundation

struct Announcement: Codable, Identifiable {
    let id: String
    let title: String
    let message: String
    let date: String
}

