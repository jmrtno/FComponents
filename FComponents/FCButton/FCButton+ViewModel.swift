//
//  ViewModel.swift
//  FComponents
//
//  Created by Javier Martin on 14/2/25.
//

import SwiftUI

public extension FCButton {
    struct Configuration {
        public var label: String?
        public var leadingIcon: String?
        public var trailingIcon: String?
        public var maxWidth: Bool
        public var invertCornerRadius: Bool

        public init(label: String? = nil,
                    leadingIcon: String? = nil,
                    trailingIcon: String? = nil,
                    maxWidth: Bool = false,
                    invertCornerRadius: Bool = false) {
            self.label = label
            self.leadingIcon = leadingIcon
            self.trailingIcon = trailingIcon
            self.maxWidth = maxWidth
            self.invertCornerRadius = invertCornerRadius
        }
    }

    struct ViewState {
        let type: ViewStateType

        enum ViewStateType {
            case enabled
            case disabled
        }

        public static var enabled: ViewState {
            ViewState(type: .enabled)
        }

        public static var disabled: ViewState {
            ViewState(type: .disabled)
        }
    }

    struct Variant {
        let type: VariantType

        enum VariantType {
            case regular(color: Color?)
            case alternative(color: Color)
            case link
        }

        public static var regular: Variant {
            Variant(type: .regular(color: Color.clear))
        }

        public static var alternative: Variant {
            Variant(type: .alternative(color: Color.clear))
        }

        public static var link: Variant {
            Variant(type: .link)
        }

        func normalBackgroundColor() -> Color? {
            switch type {
            case .regular(color: let color):
                return color
            case .alternative:
                return .clear
            case .link:
                return .clear
            }
        }

        func pressedBackgroundColor() -> Color {
            switch type {
            case .regular:
                return Color.black.opacity(0.2)
            case .alternative:
                return Color.black.opacity(0.2)
            case .link:
                return .clear
            }
        }

        func normalBorderColor() -> Color {
            switch type {
            case .regular:
                return .red
            case .alternative(color: let color):
                return color
            case .link:
                return .clear
            }
        }

        func underlineText() -> Bool {
            switch type {
            case .regular:
                return false
            case .alternative:
                return false
            case .link:
                return true
            }
        }
    }

    struct Style {
        let textColor: Color
        let leadingIconColor: Color?
        let trailingIconColor: Color?

        public init(textColor: Color,
                    leadingIconColor: Color? = nil,
                    trailingIconColor: Color? = nil) {
            self.textColor = textColor
            self.leadingIconColor = leadingIconColor
            self.trailingIconColor = trailingIconColor
        }
    }

    struct Size {
        let type: SizeType

        enum SizeType {
            case small
            case medium
            case large
        }

        public static var small: Size {
            Size(type: .small)
        }

        public static var medium: Size {
            Size(type: .medium)
        }

        public static var large: Size {
            Size(type: .large)
        }

        func fontSize() -> Font {
            switch type {
            case .small:
                return .caption
            case .medium:
                return .body
            case .large:
                return .title
            }
        }

        func iconSize() -> CGFloat {
            switch type {
            case .small:
                return 10
            case .medium:
                return 16
            case .large:
                return 24
            }
        }

        func borderWidth() -> CGFloat {
            switch type {
            case .small:
                return 1
            case .medium:
                return 1.5
            case .large:
                return 2
            }
        }
    }

    struct Interaction {
        public var onTap: () -> Void

        public init(onTap: @escaping () -> Void) {
            self.onTap = onTap
        }
    }

    final class ViewModel: ObservableObject {

        @Published public var configuration: Configuration
        @Published public var viewState: ViewState
        @Published public var variant: Variant
        @Published public var style: Style
        @Published public var size: Size
        @Published public var interaction: Interaction

        public init(configuration: Configuration,
                    viewState: ViewState,
                    variant: Variant,
                    style: Style,
                    size: Size,
                    interaction: Interaction) {
            self.configuration = configuration
            self.viewState = viewState
            self.variant = variant
            self.style = style
            self.size = size
            self.interaction = interaction
        }
    }
}
