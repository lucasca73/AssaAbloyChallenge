//
//  HomeRouterView.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 07/04/26.
//

import SwiftUI


struct HomeRouterView: View {

    @EnvironmentObject var homeCoordinator: HomeCoordinator

    var body: some View {
        TabView(selection: $homeCoordinator.activeTab) {
            DoorsFeedRouterView()
                .environmentObject(homeCoordinator.makeFeedCoordinator())
                .tabItem { Label("Doors", systemImage: "door.left.hand.closed") }
                .tag(HomeCoordinator.ActiveTab.feed)

            SettingsRouterView()
                .environmentObject(homeCoordinator.makeSettingsCoordinator())
                .tabItem { Label("Settings", systemImage: "gearshape") }
                .tag(HomeCoordinator.ActiveTab.settings)
        }
    }
}

