//
//  EmailField.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 07/04/26.
//

import SwiftUI

struct NameField: View {
    let title: String
    @Binding var name: String
    var error: String? = nil
    
    var body: some View {
        HStack {
            TextField(title, text: $name)
                .frame(maxWidth: .infinity)
                .keyboardType(.namePhonePad)
                .textContentType(.name)
                .textInputAutocapitalization(.words)
                .autocorrectionDisabled()
                .padding()
                .background(Color.gray.opacity(0.15))
                .cornerRadius(8)
            ErrorText(error: error)
        }
    }
}

#Preview {
    NameField(title: "Name", name: Binding.constant("Jorge Washington"))
}
