//
//  HomeCoordinator.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 07/04/26.
//

import SwiftUI
import Combine

final class HomeCoordinator: Coordinator, ObservableObject {
    let dependencies: AppDependencies
    
    var onLogout: (() -> Void)?
    
    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
    }
    
    func makeHome() -> some View {
        return HomeView()
    }
}
