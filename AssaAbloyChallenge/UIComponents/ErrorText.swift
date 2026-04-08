//
//  ErrorText.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 08/04/26.
//

import SwiftUI

struct ErrorText: View {
    var error: String?
    var body: some View {
        if let error = error {
            Text(error)
                .foregroundColor(.red)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.footnote)
                .padding(.bottom, 8)
        } else {
            EmptyView()
        }
    }
}
