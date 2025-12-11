//
//  SchoolAdapter.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 10/12/25.
//
import Foundation

enum SchoolAdapter {
    
    // MARK: - Adaptar Config
    static func convertConfig(dict: [String: Any]) -> SchoolConfig {
        let colors = dict["colors"] as? [String: String] ?? [:]

        return SchoolConfig(
            name: dict["name"] as? String ?? "",
            logo: dict["logo"] as? String ?? "",
            welcomeMessage: dict["welcomeMessage"] as? String ?? "",
            homeText: dict["homeText"] as? String ?? "",
            supportUrl: dict["supportUrl"] as? String ?? "",
            primaryColor: colors["primary"] ?? "#000000",
            secondaryColor: colors["secondary"] ?? "#FFFFFF"
        )
    }
    
    // MARK: - Adaptar Announcement
    static func convertAnnouncement(id: String, dict: [String: Any]) -> Announcement {
        Announcement(
            id: id,
            title: dict["title"] as? String ?? "",
            message: dict["message"] as? String ?? "",
            date: dict["date"] as? String ?? ""
        )
    }
    
    // MARK: - Adaptar Subject
    static func convertSubject(id: String, dict: [String: Any]) -> Subject {
        Subject(
            id: id,
            name: dict["name"] as? String ?? "",
            description: dict["description"] as? String ?? "",
            schedule: dict["schedule"] as? String ?? "",
            teacher: dict["teacher"] as? String ?? ""
        )
    }

    // MARK: - Adaptar Task
    static func convertTask(id: String, dict: [String: Any]) -> Task {
            return Task(
                //id: id, NO SE SI SE IMPLEMENTA EN BACKEND
                title: dict["title"] as? String ?? "",
                subject: dict["subject"] as? String ?? "",
                status: dict["status"] as? String ?? "Pendiente",
                dueDate: dict["dueDate"] as? String ?? "No definida"
            )
        }
    
    // MARK: - Adaptar Grade
    static func convertGrade(id: String, dict: [String: Any]) -> Grade {
        Grade(
            id: id,
            title: dict["title"] as? String ?? "",
            value: dict["value"] as? Int ?? 0
        )
    }
}

