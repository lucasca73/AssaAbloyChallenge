//
//  SignUpView.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 07/04/26.
//

import SwiftUI

protocol SignUpViewModelProtocol: AnyObject {
    var isLoading: Bool { get }
    var signUpError: String? { get }
    func signUp(email: String, password: String, confirmPassword: String) async
    func backToSignIn()
}

struct SignUpView<ViewModel: SignUpViewModelProtocol>: View {

    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""

    @State var viewModel: ViewModel

    var body: some View {
        VStack(spacing: 16) {
            
            EmailField(title: "Email", email: $email)
            PasswordField(title: "Password", password: $password)
            PasswordField(title: "Confirm Password", password: $confirmPassword)

            if viewModel.isLoading {
                ProgressView()
            }

            if let errorMessage = viewModel.signUpError, !errorMessage.isEmpty {
                Text(errorMessage).foregroundStyle(.red)
            }

            PrimaryButton(title: "Sign Up") {
                Task {
                    await viewModel.signUp(email: email, password: password, confirmPassword: confirmPassword)
                }
            }
            
            SecondaryButton(title: "Already have an account?") {
                viewModel.backToSignIn()
            }
            
        }
        .padding()
    }
}

fileprivate final class MockViewModel: SignUpViewModelProtocol {
    var isLoading: Bool = false
    var signUpError: String? = nil
    func signUp(email: String, password: String, confirmPassword: String) async {
        debugPrint("Here is the signup")
    }
    func backToSignIn() {
        debugPrint("backToSignIn")
    }
}

#Preview {
    SignUpView(viewModel: MockViewModel())
}

