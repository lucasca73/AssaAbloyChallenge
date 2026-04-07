//
//  SignUpViewModel.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 07/04/26.
//

import SwiftUI

@Observable
final class SignUpViewModel: SignUpViewModelProtocol {

    // MARK: Dependencies
    let signUpService: SignUpService

    // MARK: Callbacks
    var onSignUpSuccess: (() -> Void)?
    var onSignIn: (() -> Void)?

    // MARK: View
    var isLoading: Bool = false
    var signUpError: String? = nil

    init(signUpService: SignUpService) {
        self.signUpService = signUpService
    }

    func signUp(email: String, password: String, confirmPassword: String) async {
        guard password == confirmPassword else {
            signUpError = "Passwords do not match"
            return
        }

        signUpError = nil
        isLoading = true
        signUpService.signUp(email: email, password: password) { [weak self] result in
            switch result {
            case .success:
                self?.onSignUpSuccess?()
            case .failure(let error):
                self?.signUpError = error.localizedDescription
            }
            self?.isLoading = false
        }
    }
    
    func backToSignIn() {
        onSignIn?()
    }
}
