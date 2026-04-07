//
//  Coordinator.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 07/04/26.
//

import Foundation
import Combine

protocol Coordinator: ObservableObject {
    var dependencies: AppDependencies { get }
}
