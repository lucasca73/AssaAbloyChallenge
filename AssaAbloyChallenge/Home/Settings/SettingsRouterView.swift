//
//  SettingsRouterView.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 08/04/26.
//

import SwiftUI

enum SettingsRoutes: Hashable {
    case settings
}

typealias SettingsRouter = Router<SettingsRoutes>

struct SettingsRouterView: View {

    @StateObject var router = SettingsRouter()
    @EnvironmentObject var coordinator: SettingsCoordinator

    var body: some View {
        NavigationStack(path: $router.path) {
            coordinator.makeSettings(router: router)
                .navigationDestination(for: SettingsRoutes.self) { route in
                    switch route {
                    case .settings:
                        coordinator.makeSettings(router: router)
                    }
                }
        }
    }
}
