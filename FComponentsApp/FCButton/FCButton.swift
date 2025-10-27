//
//  ContentView.swift
//  FComponents
//
//  Created by Javier Martin on 14/2/25.
//

import SwiftUI

public struct FCButton: View {

    @ObservedObject private var viewModel: ViewModel

    @State private var pressed = false

    public init(_ viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        mainContentView
    }
}

private extension FCButton {
    var mainContentView: some View {
        HStack {
            if let leadingIcon = configuration.leadingIcon {
                imageView(resource: leadingIcon, color: style.leadingIconColor, size: size.iconSize())
            }
            titleView
            if let trailingIcon = configuration.trailingIcon {
                imageView(resource: trailingIcon, color: style.trailingIconColor, size: size.iconSize())
            }
        }
        .frame(maxWidth: configuration.maxWidth ? .infinity : nil)
        .padding(.vertical, 8)
        .padding(.horizontal, 8)
        // Background: normal (color o gradient) + overlay pressed (si aplica)
        .background(
            ZStack {
                // fondo normal (puede ser Color o LinearGradient a través de AnyView)
                variant.normalBackgroundView()
                // overlay pressed (semi-transparente) colocado encima del fondo
                if pressed && !variant.underlineText() {
                    variant.pressedOverlayView()
                }
            }
        )
        .clipShape(
            .rect(
                topLeadingRadius: configuration.invertCornerRadius ? 5 : 20,
                bottomLeadingRadius: configuration.invertCornerRadius ? 20 : 5,
                bottomTrailingRadius: configuration.invertCornerRadius ? 20 : 5,
                topTrailingRadius: configuration.invertCornerRadius ? 5 : 20
            )
        )
        .overlay {
            UnevenRoundedRectangle(cornerRadii:.init(
                                topLeading: configuration.invertCornerRadius ? 5 : 20,
                                bottomLeading: configuration.invertCornerRadius ? 20 : 5,
                                bottomTrailing: configuration.invertCornerRadius ? 20 : 5,
                                topTrailing: configuration.invertCornerRadius ? 5 : 20))
            .stroke(variant.normalBorderColor(), lineWidth: size.borderWidth())
        }
        .onTapGesture {
            interaction.onTap()
        }
        .onPressStateChanged { pressed = $0 }
        .animation(.easeInOut(duration: 0.10), value: pressed)
    }

    func imageView(resource: String, color: Color?, size: CGFloat) -> some View {
        let shouldDim = pressed && variant.underlineText() && configuration.label == nil
        let finalColor = (color ?? .primary).opacity(shouldDim ? 0.6 : 1.0)

        if UIImage(systemName: resource) != nil {
            return Image(systemName: resource)
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .foregroundStyle(finalColor)
                .eraseToAnyView()
        } else {
            return Image(resource)
                .resizable()
                .renderingMode(color != nil ? .template : .original)
                .scaledToFit()
                .frame(width: size, height: size)
                .foregroundStyle(finalColor)
                .eraseToAnyView()
        }
    }

    var titleView: some View {
        Group {
            if let label = configuration.label {
                let shouldDim = pressed && variant.underlineText()
                let textColor = style.textColor.opacity(shouldDim ? 0.6 : 1.0)
                Text(label)
                    .foregroundStyle(textColor)
                    .font(size.fontSize())
                    .underline(variant.underlineText())
            }
        }
    }

}

// Small helper to erase View to AnyView from this file (keeps code tidy)
private extension View {
    func eraseToAnyView() -> AnyView { AnyView(self) }
}

private extension FCButton {
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

#Preview {
    ScrollView {
        FCButtonRegularGallery()
    }
}

//#Preview {
//    ScrollView {
//        FCButtonAlternativeGallery()
//    }
//}
//
//#Preview {
//    ScrollView {
//        FCButtonLinkGallery()
//    }
//}
