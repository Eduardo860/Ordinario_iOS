//
//  Array.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 11/12/25.
//
import Foundation

extension Array where Element == Int {
    var average: Double {
        return isEmpty ? 0 : Double(self.reduce(0, +)) / Double(self.count)
    }
}

