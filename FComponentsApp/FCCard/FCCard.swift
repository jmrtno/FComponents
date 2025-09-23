//
//  FCCard.swift
//  FComponents
//
//  Created by Javier Martin on 13/6/25.
//

import SwiftUI

public struct FCCard<Content: View>: View {

    @ObservedObject private var viewModel: ViewModel
    @State private var pressed = false
    private let content: Content

    public init(viewModel: ViewModel,
                @ViewBuilder content: () -> Content) {
        self.viewModel = viewModel
        self.content = content()
    }

    public var body: some View {
        mainContentView
    }
}

public extension FCCard {
    var mainContentView: some View {
        VStack {
            if hasTopBarContent {
                topBar
            }
            content
                .frame(maxWidth: configuration.maxWidth ? .infinity : nil,
                       alignment: configuration.contentAlignment)
                .background(style.innerCardBgColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(style.innerCardBorderColor, lineWidth: 1)
                }
        }
        .padding(configuration.doubleCard ? 16 : 0)
        .background(configuration.doubleCard ? style.doubleCardBgColor : .clear)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(style.doubleCardBorderColor, lineWidth: 1)
        }
    }
    
    private var hasTopBarContent: Bool {
        configuration.topLeadingIcon != nil ||
        configuration.topLeadingLabel != nil ||
        configuration.topTrailingIcon != nil ||
        configuration.topTrailingLabel != nil
    }

    private var topBar: some View {
        HStack {
            if configuration.topLeadingIcon != nil || configuration.topLeadingLabel != nil {
                leadingContent(
                    image: configuration.topLeadingIcon,
                    label: configuration.topLeadingLabel
                )
                Spacer()
            }

            if configuration.topTrailingIcon != nil || configuration.topTrailingLabel != nil {
                Spacer()
                trailingContent(
                    image: configuration.topTrailingIcon,
                    label: configuration.topTrailingLabel
                )
            }
        }
    }

    private func leadingContent(image: String?, label: String?) -> some View {
        HStack(alignment: .center, spacing: 4) {
            if let image {
                Image(systemName: image)
                    .padding(.vertical, 2)
            }
            if let label {
                Text(label)
                    .font(.headline)
            }
        }
        .foregroundStyle(style.topLeadingContentColor)
    }

    private func trailingContent(image: String?, label: String?) -> some View {
        HStack(alignment: .center, spacing: 4) {
            if let label {
                Text(label)
            }
            if let image {
                Image(systemName: image)
                    .padding(.vertical, 2)
            }
        }
        .foregroundStyle(style.topTrailingContentColor.opacity(pressed ? 0.6 : 1))
        .onTapGesture {
            interaction.onTap()
        }
        .onPressStateChanged { pressed = $0 }
        .animation(.easeInOut(duration: 0.10), value: pressed)
    }
}

private extension FCCard {
    var configuration: Configuration {
        viewModel.configuration
    }

    var style: Style {
        viewModel.style
    }

    var interaction: Interaction {
        viewModel.interaction
    }
}

#Preview {
    VStack {
        FCCard(viewModel: .init(
               configuration: .init(
                doubleCard: true,
                maxWidth: true,
                contentAlignment: .leading,
                topLeadingIcon: "star.fill",
                topLeadingLabel: "Destacado",
                topTrailingIcon: "ellipsis",
                topTrailingLabel: "Más"
               ),
               style: .init(
                   doubleCardBgColor: Color.gray.opacity(0.1),
                   innerCardBgColor: .cyan,
                   doubleCardBorderColor: .red,
                   innerCardBorderColor: .green,
                   topLeadingContentColor: .accentColor,
                   topTrailingContentColor: .green
               ),
               interaction: .init(onTap: {
                   print("Card tapped")
               })
           )
       ) {
            HStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                VStack(alignment: .leading) {
                    Text("Titulo")
                    Text("Subtitulo Subtitulo sub sub")
                }
            }
            .padding()
       }
        
        FCCard(viewModel: .init(
               configuration: .init(
                doubleCard: true,
                maxWidth: true,
                contentAlignment: .leading
               ),
               style: .init(
                   doubleCardBgColor: Color.gray.opacity(0.1),
                   innerCardBgColor: .cyan,
                   doubleCardBorderColor: .clear,
                   innerCardBorderColor: .clear
               ),
               interaction: .init(onTap: {
                   print("Card tapped")
               })
           )
       ) {
            HStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                VStack(alignment: .leading) {
                    Text("Titulo")
                    Text("Subtitulo Subtitulo sub sub")
                }
            }
            .padding()
       }
    }
    .padding()
}
