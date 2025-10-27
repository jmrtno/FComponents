//
//  Utils.swift
//  FComponents
//
//  Created by Javier Martin on 17/6/25.
//

import SwiftUI

struct PressGestureViewModifier: ViewModifier {
    let onChanged: (Bool) -> Void

    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in onChanged(true) }
                    .onEnded { _ in onChanged(false) }
            )
    }
}

extension View {
    func onPressStateChanged(_ action: @escaping (Bool) -> Void) -> some View {
        self.modifier(PressGestureViewModifier(onChanged: action))
    }
}

