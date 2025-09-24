//
//  Item.swift
//  MomentSail
//
//  Created by Stella on 25.09.25.
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
