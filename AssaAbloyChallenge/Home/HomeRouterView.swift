//
//  HomeRouterView.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 07/04/26.
//

import SwiftUI

enum HomeRoutes: Hashable {
    case home
}

typealias HomeRouter = Router<HomeRoutes>

struct HomeRouterView: View {
    
    @StateObject var router = HomeRouter()
    @EnvironmentObject var homeCoordinator: HomeCoordinator
    
    var body: some View {
        NavigationStack(path: $router.path) {
            homeCoordinator.makeHome()
                .navigationDestination(for: HomeRoutes.self) { route in
                switch route {
                case .home:
                    homeCoordinator.makeHome()
                }
            }
        }
    }
}

