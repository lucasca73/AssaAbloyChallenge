//
//  SettingsViewModel.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 08/04/26.
//

import SwiftUI

@Observable
final class SettingsViewModel: SettingsViewModelProtocol {
    var onLogout: (() -> Void)?

    func logout() {
        onLogout?()
    }
}
