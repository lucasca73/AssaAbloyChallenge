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

    func makeFeed(router: DoorsFeedRouter) -> some View {
        let viewModel = DoorsFeedViewModel(doorsService: dependencies.networkService)
        
        viewModel.onDoorSelected = { id in
            router.navigate(to: .doorDetails(id: id))
        }
        
        let view = DoorsFeedView(viewModel: viewModel)
        return view
    }

    func makeDoorDetail(router: DoorsFeedRouter, doorId: Int) -> some View {
        Text("Here it is the door id \(doorId)")
    }
}
