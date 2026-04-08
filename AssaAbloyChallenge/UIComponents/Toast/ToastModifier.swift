//
//  ToastModifier.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 08/04/26.
//

import SwiftUI

struct ToastModifier: ViewModifier {
    @Binding var toast: Toast?
    @State private var isVisible = false
    @State private var task: Task<Void, Never>?

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .top) {
                if let toast, isVisible {
                    ToastView(toast: toast)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .padding(.top, 16)
                }
            }
            .onChange(of: toast) { _, newValue in
                if newValue != nil {
                    show()
                }
            }
    }

    private func show() {
        task?.cancel()
        withAnimation(.spring) { isVisible = true }

        task = Task {
            try? await Task.sleep(for: .seconds(3))
            withAnimation(.spring) { isVisible = false }
            try? await Task.sleep(for: .seconds(0.3))
            toast = nil
        }
    }
}

// MARK: - View Extension

extension View {
    func toast(_ toast: Binding<Toast?>) -> some View {
        modifier(ToastModifier(toast: toast))
    }
}
