//
//  PasswordField.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 07/04/26.
//

import SwiftUI

struct PasswordField: View {
    var title: String
    @Binding var password: String
    var error: String? = nil
    
    var body: some View {
        VStack {
            SecureField(title, text: $password)
                .frame(maxWidth: .infinity)
                .textContentType(.password)
                .padding()
                .background(Color.gray.opacity(0.15))
                .cornerRadius(8)
            ErrorText(error: error)
                .padding(.leading)
        }
    }
}

#Preview {
    PasswordField(title: "Password", password: Binding.constant("123123"), error: "Something")
}
