//
//  FCTextField+ViewModel.swift
//  FComponents
//
//  Created by Javier Martin on 23/6/25.
//

import SwiftUI

public extension FCTextField {
    struct Configuration: Sendable {
        public var placeholder: String?
        public var icon: String?

        public init(placeholder: String? = nil,
                    icon: String? = nil) {
            self.placeholder = placeholder
            self.icon = icon
        }
    }

    struct Variant: Sendable {
        let type: VariantType

        enum VariantType: Sendable {
            case bordered
            case plain
            case basic
        }

        public static var bordered: Variant {
            Variant(type: .bordered)
        }

        public static var plain: Variant {
            Variant(type: .plain)
        }

        public static var basic: Variant {
            Variant(type: .basic)
        }

        func borderWidth() -> CGFloat {
            switch type {
            case .bordered:
                return 1
            case .plain:
                return 0
            case .basic:
                return 0
            }
        }

        func background() -> Color {
            switch type {
            case .bordered:
                return .white
            case .basic:
                return .white
            case .plain:
                return .clear
            }
        }
    }

    @MainActor
    @Observable
    final class ViewModel {
        
        var configuration: Configuration
        var variant: Variant

        public init(configuration: Configuration, variant: Variant) {
            self.configuration = configuration
            self.variant = variant
        }
    }
}
