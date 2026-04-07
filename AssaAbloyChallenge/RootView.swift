//
//  ContentView.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 07/04/26.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject private var coordinator: AppCoordinator
    
    var body: some View {
        switch(coordinator.activeFlow) {
        case .auth:
            AuthRouterView()
                .environmentObject(coordinator.makeAuthCoordinator())
        case .home:
            HomeRouterView()
                .environmentObject(coordinator.makeHomeCoordinator())
        }
    }
}

#Preview {
    RootView()
        .environmentObject(AppCoordinator(initialRoute: .auth))
}
