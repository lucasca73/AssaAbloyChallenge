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
    func login(email: String, password: String)
}

fileprivate enum SignInFields: Hashable {
    case email
    case password
}

struct SigninView<ViewModel: SignInViewModelProtocol>: View {
    
    @State private var email = ""
    @State private var password = ""
    
    @State var viewModel: ViewModel
    
    @FocusState private var focusedField: SignInFields?
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            EmailField(title: "Email", email: $email)
                .focused($focusedField, equals: .email)
                .onSubmit {
                    focusedField = .password
                }
            PasswordField(title: "Password", password: $password)
                .focused($focusedField, equals: .password)
                .onSubmit {
                    if !email.isEmpty {
                        submit()
                    } else {
                        focusedField = .email
                    }
                }
            
            if viewModel.isLoading {
                ProgressView()
            }
            
            ErrorText(error: viewModel.loginError)
            
            PrimaryButton(title: "Login") {
                submit()
            }
            
            SecondaryButton(title: "Sign Up") {
                viewModel.signUp()
            }
            Spacer()
            Text("Challange made by Lucas Costa Araújo")
        }
        .padding()
    }
    
    func submit() {
        viewModel.login(email: email, password: password)
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
