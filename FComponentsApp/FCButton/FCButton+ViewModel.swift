//
//  ViewModel.swift
//  FComponents
//
//  Created by Javier Martin on 14/2/25.
//

import SwiftUI

public extension FCButton {
    struct Configuration: Sendable {
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

    struct ViewState: Sendable {
        let type: ViewStateType

        enum ViewStateType: Sendable {
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

    struct Variant: Sendable {
        public let type: VariantType

        public enum VariantType: Sendable {
            // Existing color-based cases (kept for backward compatibility)
            case regular(color: Color?)
            case alternative(color: Color)
            case link
            // New gradient-based cases
            case regularGradient(LinearGradient)
            case alternativeGradient(LinearGradient)
        }

        public init(type: VariantType) {
            self.type = type
        }

        // Backwards-compatible defaults
        public static var regular: Variant {
            Variant(type: .regular(color: Color.clear))
        }

        public static var alternative: Variant {
            Variant(type: .alternative(color: Color.clear))
        }

        public static var link: Variant {
            Variant(type: .link)
        }

        // **New**: convenience creators for gradient variants
        public static func regularGradient(_ gradient: LinearGradient) -> Variant {
            Variant(type: .regularGradient(gradient))
        }

        public static func alternativeGradient(_ gradient: LinearGradient) -> Variant {
            Variant(type: .alternativeGradient(gradient))
        }

        // MARK: - New view-returning helpers (used by FCButton)
        // Dev note: return AnyView so we can return either Color or LinearGradient.
        func normalBackgroundView() -> AnyView {
            switch type {
            case .regular(color: let color):
                return AnyView((color ?? Color.clear))
            case .regularGradient(let gradient):
                return AnyView(gradient)
            case .alternative, .alternativeGradient:
                // alternative variants keep a clear background by design (border is used)
                return AnyView(Color.clear)
            case .link:
                return AnyView(Color.clear)
            }
        }

        func pressedOverlayView() -> AnyView {
            // For pressed state we place a semi-transparent black overlay above the normal background.
            // This works both for solid colors and gradients.
            switch type {
            case .link:
                return AnyView(Color.clear)
            default:
                return AnyView(Color.black.opacity(0.2))
            }
        }

        // MARK: - Backwards-compatible color helpers (some callers may still use them)
        func normalBackgroundColor() -> Color? {
            switch type {
            case .regular(color: let color):
                return color
            case .regularGradient:
                // gradient -> no single color; return nil to indicate it isn't a solid color
                return nil
            case .alternative:
                return .clear
            case .alternativeGradient:
                return .clear
            case .link:
                return .clear
            }
        }

        func pressedBackgroundColor() -> Color {
            // kept for compatibility; pressed overlay will visually be the same
            return Color.black.opacity(0.2)
        }

        func normalBorderColor() -> Color {
            switch type {
            case .regular, .regularGradient:
                return .clear
            case .alternative(color: let color):
                return color
            case .alternativeGradient:
                // not implementing gradient stroke — keep clear so existing behavior intact
                return .clear
            case .link:
                return .clear
            }
        }

        func underlineText() -> Bool {
            switch type {
            case .regular:
                return false
            case .regularGradient:
                return false
            case .alternative:
                return false
            case .alternativeGradient:
                return false
            case .link:
                return true
            }
        }
    }

    struct Style: Sendable {
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

    struct Size: Sendable {
        let type: SizeType

        enum SizeType: Sendable {
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

    struct Interaction: Sendable {
        public var onTap: @MainActor @Sendable () -> Void

        public init(onTap: @escaping @MainActor @Sendable () -> Void) {
            self.onTap = onTap
        }
    }

    @MainActor
    @Observable
    final class ViewModel {

        var configuration: Configuration
        var viewState: ViewState
        var variant: Variant
        var style: Style
        var size: Size
        var interaction: Interaction

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
