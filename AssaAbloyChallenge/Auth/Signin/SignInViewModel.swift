//
//  SignInViewModel.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 07/04/26.
//

import SwiftUI
import Combine

@Observable
final class SignInViewModel: SignInViewModelProtocol {
    
    // MARK: Depedencies
    let loginService: LoginService
    
    // MARK: Callbacks
    var onLoginSuccess: (() -> Void)?
    var onSignUp: (() -> Void)?
    
    // MARK: View
    var isLoading: Bool = false
    var loginError: String? = nil
    
    init(loginService: LoginService) {
        self.loginService = loginService
    }
    
    func signUp() {
        onSignUp?()
    }
    
    func login(email: String, password: String) {
        loginError = nil
        isLoading = true
        loginService.login(email: email, password: password) { [weak self] result in
            switch result {
            case .success(_):
                self?.onLoginSuccess?()
                
            case .failure(let error):
                self?.loginError = error.localizedDescription
            }
            self?.isLoading = false
        }
    }
}
