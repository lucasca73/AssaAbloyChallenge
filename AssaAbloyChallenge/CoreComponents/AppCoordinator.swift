//
//  AppCoordinator.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 07/04/26.
//

import Foundation
import Combine

class AppCoordinator: ObservableObject {
    
    enum AppFlow: Equatable {
        case auth
        case home
    }
    
    private let dependencies: AppDependencies
    
    @Published var activeFlow: AppFlow
    
    
    init(initialRoute: AppFlow) {
        // Setup dependencies
        dependencies = AppDependencies()
        activeFlow = initialRoute
    }
    
    func makeAuthCoordinator() -> AuthCoordinator {
        AuthCoordinator(dependencies: dependencies)
    }
    
    func makeHomeCoordinator() -> HomeCoordinator {
        HomeCoordinator(dependencies: dependencies)
    }
    
}
