import SwiftUI

// MARK: - Pills
/// A selectable pill for filters and multi-selection scenarios.
public struct FCPill: View {
    @State private var viewModel: ViewModel

    @Binding var isSelected: Bool

    public init(viewModel: ViewModel, isSelected: Binding<Bool>) {
        self.viewModel = viewModel
        self._isSelected = isSelected
    }

    public var body: some View {
        mainContent
    }
}

private extension FCPill {

    var mainContent: some View {
        Button(action: {
            isSelected.toggle()
            interaction.onTap()
        }) {
            HStack(spacing: 6) {
                if let image = configuration.image {
                    imageView(resource: image)
                }
                if let text = configuration.text {
                    Text(text)
                        .font(size.fontSize())
                }
            }
            .padding(.horizontal, size.horizontalPadding())
            .padding(.vertical, size.verticalPadding())
            .background(
                Capsule()
                    .fill(variant.backgroundColor(isSelected: isSelected))
            )
            .overlay(
                Capsule()
                    .stroke(variant.borderColor(isSelected: isSelected), lineWidth: 1)
            )
            .foregroundStyle(textColor)
        }
        .buttonStyle(.plain)
        .disabled(viewState.type == .disabled)
    }

    func imageView(resource: String) -> some View {
        let finalColor = iconColor

        if UIImage(systemName: resource) != nil {
            return Image(systemName: resource)
                .resizable()
                .scaledToFit()
                .frame(width: size.iconSize(), height: size.iconSize())
                .foregroundStyle(finalColor)
                .eraseToAnyView()
        } else {
            return Image(resource)
                .resizable()
                .renderingMode(style.iconColor != nil ? .template : .original)
                .scaledToFit()
                .frame(width: size.iconSize(), height: size.iconSize())
                .foregroundStyle(finalColor)
                .eraseToAnyView()
        }
    }

    var textColor: Color {
        if let customColor = style.textColor {
            return customColor
        }
        return variant.textColor(isSelected: isSelected)
    }

    var iconColor: Color {
        if let customColor = style.iconColor {
            return customColor
        }
        return variant.textColor(isSelected: isSelected)
    }
}

private extension FCPill {
    var configuration: Configuration {
        viewModel.configuration
    }

    var viewState: ViewState {
        viewModel.viewState
    }

    var variant: Variant {
        viewModel.variant
    }

    var style: Style {
        viewModel.style
    }

    var size: Size {
        viewModel.size
    }

    var interaction: Interaction {
        viewModel.interaction
    }
}

// Small helper to erase View to AnyView from this file (keeps code tidy)
private extension View {
    func eraseToAnyView() -> AnyView { AnyView(self) }
}
