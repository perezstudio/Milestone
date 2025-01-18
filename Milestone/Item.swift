//
//  Item.swift
//  Milestone
//
//  Created by Kevin Perez on 1/18/25.
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
