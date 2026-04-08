//
//  Toast.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 08/04/26.
//

import SwiftUI

struct Toast: Equatable {
    let message: String
    var style: Style = .info

    enum Style {
        case info, success, error, warning

        var color: Color {
            switch self {
            case .info:    return .blue
            case .success: return .green
            case .error:   return .red
            case .warning: return .orange
            }
        }

        var icon: String {
            switch self {
            case .info:    return "info.circle.fill"
            case .success: return "checkmark.circle.fill"
            case .error:   return "xmark.circle.fill"
            case .warning: return "exclamationmark.triangle.fill"
            }
        }
    }
}
