//
//  DoorModel.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 08/04/26.
//

import Foundation

struct DoorModel: Codable {
    let id: Int
    let isOpen: Bool
    let name: String
    let lastOpened: Date?
    let lastClosed: Date?
}
