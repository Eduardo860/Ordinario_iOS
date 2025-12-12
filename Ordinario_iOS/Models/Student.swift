//
//  Student.swift
//  Ordinario_iOS
//
//  Updated to match backend response
//

import Foundation

struct Student: Codable, Identifiable {
    let id: String
    let institutionId: String
    let name: String
    let email: String
    let career: String
    let group: String
    let profilePicture:  String?
    let password: String?
    
    // Inicializador con valores por defecto para compatibilidad
    init(
        id: String = "",
        institutionId: String = "",
        name: String,
        email: String,
        career: String,
        group: String,
        profilePicture: String?  = nil,
        password: String? = nil
    ) {
        self.id = id
        self.institutionId = institutionId
        self.name = name
        self.email = email
        self.career = career
        self.group = group
        self.profilePicture = profilePicture
        self.password = password
    }
    
    // MARK: - Decodable
    init(from decoder:  Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Manejar tanto "id" como "_id" o "uid"
        if let id = try? container.decode(String.self, forKey: .id) {
            self.id = id
        } else if let uid = try? container.decode(String.self, forKey: .uid) {
            self.id = uid
        } else {
            self.id = ""
        }
        
        institutionId = try container.decodeIfPresent(String.self, forKey: .institutionId) ?? ""
        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
        career = try container.decode(String.self, forKey: .career)
        group = try container.decode(String.self, forKey: .group)
        profilePicture = try container.decodeIfPresent(String.self, forKey: .profilePicture)
        password = try container.decodeIfPresent(String.self, forKey: .password)
    }
    
    // MARK: - Encodable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(institutionId, forKey: .institutionId)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(career, forKey: .career)
        try container.encode(group, forKey: .group)
        try container.encodeIfPresent(profilePicture, forKey: .profilePicture)
        try container.encodeIfPresent(password, forKey: .password)
    }
    
    // MARK: - CodingKeys
    enum CodingKeys:  String, CodingKey {
        case id
        case uid
        case institutionId
        case name
        case email
        case career
        case group
        case profilePicture
        case password
    }
}
