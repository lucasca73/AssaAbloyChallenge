//
//  Item.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 07/04/26.
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
