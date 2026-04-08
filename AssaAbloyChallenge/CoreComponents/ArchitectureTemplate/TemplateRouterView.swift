//
//  AuthRouterView.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 07/04/26.
//

import SwiftUI

enum TemplateRoutes: Hashable {
    case flowTemplate
    case anotherFlowTemplate
}

typealias TemplateRouter = Router<AuthRoutes>


struct TemplateRouterView: View {
    
    @StateObject var router = TemplateRouter()
    @EnvironmentObject var coordinator: TemplateCoordinator
    
    var body: some View {
        NavigationStack(path: $router.path) {
            coordinator.makeFlowTemplate(router: router)
                .navigationDestination(for: TemplateRoutes.self) { route in
                switch route {
                case .flowTemplate:
                    coordinator.makeFlowTemplate(router: router)
                case .anotherFlowTemplate:
                    coordinator.makeAnotherFlowTemplate(router: router)
                }
            }
        }
    }
}
