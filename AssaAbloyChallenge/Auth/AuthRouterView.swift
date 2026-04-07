//
//  AuthRouterView.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 07/04/26.
//

import SwiftUI

enum AuthRoutes: Hashable {
    case signin
    case signup
}

typealias AuthRouter = Router<AuthRoutes>


struct AuthRouterView: View {
    
    @StateObject var router = AuthRouter()
    @EnvironmentObject var authCoordinator: AuthCoordinator
    
    var body: some View {
        NavigationStack(path: $router.path) {
            authCoordinator.makeSignin(router: router)
                .navigationDestination(for: AuthRoutes.self) { route in
                switch route {
                case .signin:
                    authCoordinator.makeSignin(router: router)
                case .signup:
                    authCoordinator.makeSignUp()
                }
            }
        }
    }
}
