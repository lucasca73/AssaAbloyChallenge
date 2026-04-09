//
//  SettingsView.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 08/04/26.
//

import SwiftUI

protocol SettingsViewModelProtocol: AnyObject, Observable {
    func logout()
}

struct SettingsView<ViewModel: SettingsViewModelProtocol>: View {

    @State var viewModel: ViewModel

    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            SecondaryButton(title: "Logout") {
                viewModel.logout()
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Settings")
    }
}

@Observable fileprivate final class SettingsMockViewModel: SettingsViewModelProtocol {
    func logout() { debugPrint("Logout") }
}

#Preview {
    SettingsView(viewModel: SettingsMockViewModel())
}
