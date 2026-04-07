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
    var onAuthSuccess: (() -> Void)?
    
    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
    }
    
    func makeSignin(router: AuthRouter) -> some View {
        let viewModel = SignInViewModel(loginService: dependencies.networkService)
        
        viewModel.onSignUp = {
            router.navigate(to: .signup)
        }
        
        viewModel.onLoginSuccess = { [weak self] in
            self?.onAuthSuccess?()
        }
        
        let view = SigninView(viewModel: viewModel)
        return view
    }
    
    func makeSignUp() -> some View {
        return SignUpView()
    }
}
