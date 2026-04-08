//
//  AuthCoordinator.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 07/04/26.
//

import SwiftUI
import Combine

final class TemplateCoordinator: Coordinator, ObservableObject {
    let dependencies: AppDependencies
    var onAuthSuccess: (() -> Void)?
    
    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
    }
    
    func makeFlowTemplate(router: TemplateRouter) -> some View {
        let viewModel = TemplateViewModel()
        let view = TemplateView(viewModel: viewModel)
        return view
    }
    
    func makeAnotherFlowTemplate(router: AuthRouter) -> some View {
        Text("Another flow")
    }
}
