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
    
    init(initialRoute: AppFlow = .auth) {
        // Setup dependencies
        dependencies = AppDependencies()
        activeFlow = dependencies.networkService.isAuthenticated ? .home : .auth
    }
    
    func makeAuthCoordinator() -> AuthCoordinator {
        let coordinator = AuthCoordinator(dependencies: dependencies)
        
        coordinator.onAuthSuccess = { [weak self] in
            Task { @MainActor in
                self?.activeFlow = .home
            }
        }
        
        return coordinator
    }
    
    func makeHomeCoordinator() -> HomeCoordinator {
        let coordinator = HomeCoordinator(dependencies: dependencies)
        coordinator.onLogout = { [weak self] in
            Task { @MainActor in
                self?.activeFlow = .auth
            }
        }
        return coordinator
    }
    
}
