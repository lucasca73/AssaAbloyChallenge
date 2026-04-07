//
//  AssaAbloyChallengeApp.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 07/04/26.
//

import SwiftUI

@main
struct AppEntry: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(AppCoordinator())
        }
    }
}
