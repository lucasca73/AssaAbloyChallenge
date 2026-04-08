//
//  DoorsFeedRouterView.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 08/04/26.
//

import SwiftUI

enum DoorsFeedRoutes: Hashable {
    case feed
    case doorDetails(id: Int)
}

typealias DoorsFeedRouter = Router<DoorsFeedRoutes>

struct DoorsFeedRouterView: View {

    @StateObject var router = DoorsFeedRouter()
    @EnvironmentObject var coordinator: DoorsFeedCoordinator

    var body: some View {
        NavigationStack(path: $router.path) {
            coordinator.makeFeed(router: router)
                .navigationDestination(for: DoorsFeedRoutes.self) { route in
                    switch route {
                    case .feed:
                        coordinator.makeFeed(router: router)
                    case .doorDetails(let id):
                        coordinator.makeDoorDetail(router: router, doorId: id)
                    }
                }
        }
    }
}
