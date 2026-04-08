//
//  DoorsFeedCoordinator.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 08/04/26.
//

import SwiftUI
import Combine

final class DoorsFeedCoordinator: Coordinator, ObservableObject {
    let dependencies: AppDependencies
    var onAuthSuccess: (() -> Void)?

    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
    }

    func makeFlowDoorsFeed(router: DoorsFeedRouter) -> some View {
        let viewModel = DoorsFeedViewModel()
        let view = DoorsFeedView(viewModel: viewModel)
        return view
    }

    func makeAnotherFlowDoorsFeed(router: DoorsFeedRouter) -> some View {
        Text("Another flow")
    }
}
