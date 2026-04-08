//
//  DoorsFeedRouterView.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 08/04/26.
//

import SwiftUI

enum DoorsFeedRoutes: Hashable {
    case flowDoorsFeed
    case anotherFlowDoorsFeed
}

typealias DoorsFeedRouter = Router<DoorsFeedRoutes>

struct DoorsFeedRouterView: View {

    @StateObject var router = DoorsFeedRouter()
    @EnvironmentObject var coordinator: DoorsFeedCoordinator

    var body: some View {
        NavigationStack(path: $router.path) {
            coordinator.makeFlowDoorsFeed(router: router)
                .navigationDestination(for: DoorsFeedRoutes.self) { route in
                    switch route {
                    case .flowDoorsFeed:
                        coordinator.makeFlowDoorsFeed(router: router)
                    case .anotherFlowDoorsFeed:
                        coordinator.makeAnotherFlowDoorsFeed(router: router)
                    }
                }
        }
    }
}
