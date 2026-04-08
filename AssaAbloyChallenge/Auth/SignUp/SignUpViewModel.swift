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
    var fieldErrors: [SignUpFields : String] = [:]
    
    
    init(signUpService: SignUpService) {
        self.signUpService = signUpService
    }

    func signUp(firstName: String, lastName: String, email: String, password: String) {
        signUpError = nil
        isLoading = true
        signUpService.signUp(firstName: firstName, lastName: lastName, email: email, password: password) { [weak self] result in
            switch result {
            case .success:
                self?.onSignUpSuccess?()
            case .failure(let error):
                if error.fieldErrors.isEmpty {
                    self?.fieldErrors = [:]
                    self?.signUpError = error.description
                } else {
                    var newFieldErrors = [SignUpFields: String]()
                    error.fieldErrors.forEach { fieldError in
                        if let field = SignUpFields(rawValue: fieldError.field) {
                            newFieldErrors[field] = fieldError.message
                        }
                    }
                    self?.fieldErrors = newFieldErrors
                }
            }
            self?.isLoading = false
        }
    }
    
    func backToSignIn() {
        onSignIn?()
    }
}
