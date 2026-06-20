import SwiftUI

// MARK: - Pills
/// A selectable pill for filters and multi-selection scenarios.
public struct FCPill: View {
    @State private var viewModel: ViewModel

    @Binding public var isSelected: Bool

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
        Button {
            isSelected.toggle()
            interaction.onTap()
        } label: {
            HStack(spacing: 6) {
                if let image = configuration.image {
                    imageView(resource: image)
                }
                if let text = configuration.text {
                    Text(text)
                        .font(size.fontSize())
                        .fixedSize(horizontal: true, vertical: false)
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
                    .strokeBorder(variant.borderColor(isSelected: isSelected), lineWidth: 1)
            )
            .foregroundStyle(textColor)
        }
        .buttonStyle(.plain)
        .disabled(viewState.type == .disabled)
    }

    @ViewBuilder
    func imageView(resource: String) -> some View {
        let finalColor = iconColor
        let isSystemImage = resource.contains(".")

        if isSystemImage {
            Image(systemName: resource)
                .resizable()
                .scaledToFit()
                .frame(width: size.iconSize(), height: size.iconSize())
                .foregroundStyle(finalColor)
        } else {
            Image(resource)
                .resizable()
                .renderingMode(style.iconColor != nil ? .template : .original)
                .scaledToFit()
                .frame(width: size.iconSize(), height: size.iconSize())
                .foregroundStyle(finalColor)
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

