import SwiftUI

public extension FCPill {
    struct Configuration: Sendable {
        public var text: String?
        public var image: String?

        public init(text: String? = nil,
                    image: String? = nil) {
            self.text = text
            self.image = image
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
            case primary(textColor: Color, backgroundColor: Color)
            case secondary(textAndBorderColor: Color, backgroundColor: Color)
        }

        public init(type: VariantType) {
            self.type = type
        }

        public static func primary(textColor: Color, backgroundColor: Color) -> Variant {
            Variant(type: .primary(textColor: textColor, backgroundColor: backgroundColor))
        }

        public static func secondary(textAndBorderColor: Color, backgroundColor: Color) -> Variant {
            Variant(type: .secondary(textAndBorderColor: textAndBorderColor, backgroundColor: backgroundColor))
        }

        func backgroundColor(isSelected: Bool) -> Color {
            switch type {
            case .primary( _, let backgroundColor):
                if isSelected {
                    return backgroundColor
                } else {
                    return backgroundColor.opacity(0.7)
                }
            case .secondary( _, let backgroundColor):
                if isSelected {
                    return backgroundColor.opacity(0.2)
                } else {
                    return Color.clear
                }
            }
        }

        func borderColor(isSelected _: Bool) -> Color {
            switch type {
            case .primary:
                return Color.clear
            case .secondary(let textAndBorderColor, _):
                return textAndBorderColor
            }
        }

        func textColor(isSelected: Bool) -> Color {
            switch type {
            case .primary(let textColor, _):
                if isSelected {
                    return textColor
                } else {
                    return textColor.opacity(0.7)
                }
            case .secondary(let textAndBorderColor, _):
                return textAndBorderColor
            }
        }
    }

    struct Style: Sendable {
        let textColor: Color?
        let iconColor: Color?

        public init(textColor: Color? = nil,
                    iconColor: Color? = nil) {
            self.textColor = textColor
            self.iconColor = iconColor
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
                return .caption2
            case .medium:
                return .subheadline
            case .large:
                return .body
            }
        }

        func iconSize() -> CGFloat {
            switch type {
            case .small:
                return 10
            case .medium:
                return 12
            case .large:
                return 16
            }
        }

        func horizontalPadding() -> CGFloat {
            switch type {
            case .small:
                return 10
            case .medium:
                return 14
            case .large:
                return 18
            }
        }

        func verticalPadding() -> CGFloat {
            switch type {
            case .small:
                return 6
            case .medium:
                return 8
            case .large:
                return 10
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
