//
//  Item.swift
//  PowerPal
//
//  Created by Metoděj Janota on 14.03.2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
