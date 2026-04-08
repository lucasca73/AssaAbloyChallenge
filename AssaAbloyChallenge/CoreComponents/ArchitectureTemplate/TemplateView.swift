//
//  LoginView.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 07/04/26.
//

import SwiftUI
import Combine

protocol TemplateViewModelProtocol: AnyObject {}

struct TemplateView<ViewModel: TemplateViewModelProtocol>: View {
    
    @State var viewModel: ViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            Text("This is a template")
        }
        .padding()
    }
}

fileprivate final class TemplateMockViewModel: TemplateViewModelProtocol {}

#Preview {
    TemplateView(viewModel: TemplateMockViewModel())
}
