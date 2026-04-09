//
//  HomeCoordinator.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 07/04/26.
//

import SwiftUI
import Combine

final class HomeCoordinator: Coordinator, ObservableObject {
    
    enum ActiveTab: Equatable {
        case feed
        case settings
    }
    
    let dependencies: AppDependencies
    
    var onLogout: (() -> Void)?
    
    @Published var activeTab: ActiveTab = .feed
    
    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
    }
    
    func makeFeedCoordinator() -> DoorsFeedCoordinator {
        let coordinator = DoorsFeedCoordinator(dependencies: dependencies)
        return coordinator
    }

    func makeSettingsCoordinator() -> SettingsCoordinator {
        let coordinator = SettingsCoordinator(dependencies: dependencies)
        coordinator.onLogout = { [weak self] in
            self?.onLogout?()
        }
        return coordinator
    }
}
