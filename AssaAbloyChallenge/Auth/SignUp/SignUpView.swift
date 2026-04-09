//
//  SignUpView.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 07/04/26.
//

import SwiftUI

protocol SignUpViewModelProtocol: AnyObject, Observable {
    var isLoading: Bool { get }
    var signUpError: String? { get }
    var fieldErrors: [SignUpFields: String] { get }
    func signUp(firstName: String, lastName: String, email: String, password: String)
    func backToSignIn()
}

enum SignUpFields: String, Hashable {
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
            Spacer(minLength: 128)
            NameField(title: "First Name", name: $firstName, error: viewModel.fieldErrors[.firstName])
                .focused($focusedField, equals: .firstName)
                .onSubmit { focusedField = .lastName }
            
            NameField(title: "Last Name", name: $lastName, error: viewModel.fieldErrors[.lastName])
                .focused($focusedField, equals: .lastName)
                .onSubmit { focusedField = .email }
            
            EmailField(title: "Email", email: $email, error: viewModel.fieldErrors[.email])
                .focused($focusedField, equals: .email)
                .onSubmit { focusedField = .password }
            
            PasswordField(title: "Password", password: $password, error: viewModel.fieldErrors[.password])
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
    let fieldErrors: [SignUpFields : String] = [.password: "Something gone wrong"]
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

