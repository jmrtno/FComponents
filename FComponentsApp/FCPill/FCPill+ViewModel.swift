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
        public var selectedColor: Color
        public var unselectedColor: Color

        public init(selectedColor: Color,
                    unselectedColor: Color) {
            self.selectedColor = selectedColor
            self.unselectedColor = unselectedColor
        }

        func backgroundColor(isSelected: Bool) -> Color {
            if isSelected {
                return selectedColor.opacity(0.15)
            } else {
                return Color.clear
            }
        }

        func borderColor(isSelected: Bool) -> Color {
            if isSelected {
                return selectedColor.opacity(0.4)
            } else {
                return unselectedColor.opacity(0.2)
            }
        }

        func textColor(isSelected: Bool) -> Color {
            if isSelected {
                return selectedColor
            } else {
                return unselectedColor.opacity(0.5)
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
        public var onTap: @Sendable () -> Void

        public init(onTap: @escaping @Sendable () -> Void) {
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
