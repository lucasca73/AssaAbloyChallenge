//
//  SecondaryButton.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 07/04/26.
//

import SwiftUI

struct SecondaryButton: View {
    
    var title: String
    @State var buttonAction: (() -> Void)? = nil
    
    var body: some View {
        Button {
            buttonAction?()
        } label: {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.blue)
                .cornerRadius(8)
        }
    }
}
