//
//  Student.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 10/12/25.
//
import Foundation

struct Student: Codable, Identifiable {
    
    
    init(name: String, email: String, career: String, group: String, profilePicture: String? = nil, password:String) {
        self.name = name
        self.email = email
        self.career = career
        self.group = group
        self.profilePicture = profilePicture
        self.password = password
    }
    
    var id: String { email }
    
    let name: String
    let email: String
    let career: String
    let group: String
    let profilePicture: String?
    let password: String
}
