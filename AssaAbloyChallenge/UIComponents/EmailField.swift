//
//  EmailField.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 07/04/26.
//

import SwiftUI

struct EmailField: View {
    let title: String
    @Binding var email: String
    var error: String? = nil
    
    var body: some View {
        HStack {
            TextField(title, text: $email)
                .frame(maxWidth: .infinity)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .padding()
                .background(Color.gray.opacity(0.15))
                .cornerRadius(8)
            ErrorText(error: error)
        }
    }
}

#Preview {
    EmailField(title: "Email", email: Binding.constant("something@example.com"))
}
