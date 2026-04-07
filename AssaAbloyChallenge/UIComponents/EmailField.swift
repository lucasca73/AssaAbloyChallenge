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
    
    var body: some View {
        TextField(title, text: $email)
            .keyboardType(.emailAddress)
            .textContentType(.emailAddress)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .padding()
            .background(Color.gray.opacity(0.15))
            .cornerRadius(8)
    }
}

#Preview {
    EmailField(title: "Email", email: Binding.constant("something@example.com"))
}
