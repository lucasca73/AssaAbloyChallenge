//
//  AuthCoordinator.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 07/04/26.
//

import SwiftUI
import Combine

final class AuthCoordinator: Coordinator, ObservableObject {
    let dependencies: AppDependencies
    
    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
    }
    
    func makeSignin() -> some View {
        return SigninView()
    }
    
    func makeSignUp() -> some View {
        return SignUpView()
    }
}
