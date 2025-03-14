//
//  Settings.swift
//  PowerPal
//
//  Created by Metoděj Janota on 14.03.2025.
//


import Foundation

struct Settings: Codable {
    var chargingLimit: Double
    var chargingLimitEnabled: Bool
    
    static let defaultSettings = Settings(
        chargingLimit: 80.0,
        chargingLimitEnabled: true
    )
}
