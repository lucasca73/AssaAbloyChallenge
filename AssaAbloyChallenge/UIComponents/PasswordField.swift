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
    
    var body: some View {
        SecureField(title, text: $password)
            .textContentType(.password)
            .padding()
            .background(Color.gray.opacity(0.15))
            .cornerRadius(8)
    }
}

#Preview {
    PasswordField(title: "Password", password: Binding.constant("123123"))
}
