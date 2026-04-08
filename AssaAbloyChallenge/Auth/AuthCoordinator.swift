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
    
    @Published var toast: Toast?
    
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
    
    func makeSignUp(router: AuthRouter) -> some View {
        let viewModel = SignUpViewModel(signUpService: dependencies.networkService)

        viewModel.onSignUpSuccess = { [weak self] in
            Task { @MainActor in
                router.goBack()
                self?.toast = Toast(message: "Succesfully created user", style: .success)
            }
        }
        
        viewModel.onSignIn = {
            Task { @MainActor in
                router.goBack()
            }
        }

        return SignUpView(viewModel: viewModel)
    }
}
