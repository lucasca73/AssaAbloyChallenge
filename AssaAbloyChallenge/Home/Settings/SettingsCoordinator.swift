//
//  SettingsCoordinator.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 08/04/26.
//

import SwiftUI
import Combine

final class SettingsCoordinator: Coordinator, ObservableObject {
    let dependencies: AppDependencies
    var onLogout: (() -> Void)?

    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
    }

    func makeSettings(router: SettingsRouter) -> some View {
        let viewModel = SettingsViewModel()
        viewModel.onLogout = { [weak self] in
            self?.onLogout?()
        }
        return SettingsView(viewModel: viewModel)
    }
}
