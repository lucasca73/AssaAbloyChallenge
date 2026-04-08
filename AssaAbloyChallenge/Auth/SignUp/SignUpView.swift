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
    func signUp(firstName: String, lastName: String, email: String, password: String)
    func backToSignIn()
}

fileprivate enum SignUpFields: Hashable {
    case firstName, lastName, email, password
}

struct SignUpView<ViewModel: SignUpViewModelProtocol>: View {

    @State private var email = ""
    @State private var password = ""
    @State private var firstName = ""
    @State private var lastName = ""

    @State var viewModel: ViewModel
    
    @FocusState private var focusedField: SignUpFields?

    var body: some View {
        ScrollView() {
            Spacer()
            NameField(title: "First Name", name: $firstName)
                .focused($focusedField, equals: .firstName)
                .onSubmit { focusedField = .lastName }
            
            NameField(title: "Last Name", name: $lastName)
                .focused($focusedField, equals: .lastName)
                .onSubmit { focusedField = .email }
            
            EmailField(title: "Email", email: $email)
                .focused($focusedField, equals: .email)
                .onSubmit { focusedField = .password }
            
            PasswordField(title: "Password", password: $password)
                .focused($focusedField, equals: .password)
                .onSubmit { submit() }
            
            if viewModel.isLoading {
                ProgressView()
            }

            ErrorText(error: viewModel.signUpError)

            PrimaryButton(title: "Sign Up") {
                submit()
            }
            
            SecondaryButton(title: "Already have an account?") {
                viewModel.backToSignIn()
            }
        }
        .padding()
    }
    
    func submit() {
        viewModel.signUp(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password)
    }
}

fileprivate final class MockViewModel: SignUpViewModelProtocol {
    var isLoading: Bool = false
    var signUpError: String? = nil
    func signUp(firstName: String, lastName: String, email: String, password: String) {
        debugPrint("Here is the signup")
    }
    func backToSignIn() {
        debugPrint("backToSignIn")
    }
}

#Preview {
    SignUpView(viewModel: MockViewModel())
}

