//
//  LoginView.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 07/04/26.
//

import SwiftUI
import Combine

protocol SignInViewModelProtocol: AnyObject {
    var isLoading: Bool { get }
    var loginError: String? { get }
    func signUp()
    func login(email: String, password: String) async
}

struct SigninView<ViewModel: SignInViewModelProtocol>: View {
    
    @State private var email = ""
    @State private var password = ""
    
    @State var viewModel: ViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            EmailField(title: "Email", email: $email)
            PasswordField(title: "Password", password: $password)
            
            if viewModel.isLoading {
                ProgressView()
            }
            
            if let errorMessage = viewModel.loginError, !errorMessage.isEmpty {
                Text(errorMessage).foregroundStyle(.red)
            }
            
            PrimaryButton(title: "Login") {
                Task {
                    await viewModel.login(email: email, password: password)
                }
            }
            
            SecondaryButton(title: "Sign Up") {
                viewModel.signUp()
            }
            Spacer()
            Text("Challange by Lucas Costa Araújo")
        }
        .padding()
    }
}

fileprivate final class MockViewModel: SignInViewModelProtocol {
    var isLoading: Bool = false
    var loginError: String? = ""
    func signUp() { debugPrint("Here is the signup") }
    func login(email: String, password: String) {
        isLoading = !isLoading
        debugPrint("Here is the login")
    }
}

#Preview {
    SigninView(viewModel: MockViewModel())
}
