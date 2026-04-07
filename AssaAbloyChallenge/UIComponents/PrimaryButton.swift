//
//  PrimaryButton.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 07/04/26.
//

import SwiftUI

struct PrimaryButton: View {
    
    var title: String
    @State var buttonAction: (() -> Void)? = nil
    
    var body: some View {
        Button {
            buttonAction?()
        } label: {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}
