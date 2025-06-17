//
//  Utils.swift
//  FComponents
//
//  Created by Javier Martin on 17/6/25.
//

import SwiftUI

extension View {
    func onPressStateChanged(_ action: @escaping (Bool) -> Void) -> some View {
        self
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in action(true) }
                    .onEnded { _ in action(false) }
            )
    }
}
