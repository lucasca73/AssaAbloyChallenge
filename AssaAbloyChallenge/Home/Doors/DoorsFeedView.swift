//
//  DoorsFeedView.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 08/04/26.
//

import SwiftUI

protocol DoorsFeedViewModelProtocol: AnyObject {}

struct DoorsFeedView<ViewModel: DoorsFeedViewModelProtocol>: View {

    var viewModel: ViewModel

    var body: some View {
        VStack(spacing: 16) {
            Text("This is a template")
        }
        .padding()
    }
}

fileprivate final class DoorsFeedMockViewModel: DoorsFeedViewModelProtocol {}

#Preview {
    DoorsFeedView(viewModel: DoorsFeedMockViewModel())
}
