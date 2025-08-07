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
            if configuration.showTopLeadingContent || configuration.showTopTrailingContent {
                topBar
            }
            content
                .frame(maxWidth: configuration.maxWidth ? .infinity : nil,
                       alignment: configuration.contentAlignment)
                .background(style.innerCardBgColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding(configuration.doubleCard ? 16 : 0)
        .background(configuration.doubleCard ? style.doubleCardBgColor : .clear)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }


    private var topBar: some View {
        HStack {
            if configuration.showTopLeadingContent {
                leadingContent(
                    image: configuration.topLeadingIcon,
                    label: configuration.topLeadingLabel
                )
                Spacer()
            }

            if configuration.showTopTrailingContent {
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
                showTopLeadingContent: true,
                topLeadingIcon: "star.fill",
                topLeadingLabel: "Destacado",
                showTopTrailingContent: true,
                topTrailingIcon: "ellipsis",
                topTrailingLabel: "Más"
               ),
               style: .init(
                   doubleCardBgColor: Color.gray.opacity(0.1),
                   innerCardBgColor: .cyan,
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
                contentAlignment: .leading,
                showTopLeadingContent: false,
                topLeadingIcon: "star.fill",
                topLeadingLabel: "Destacado",
                showTopTrailingContent: false,
                topTrailingIcon: "ellipsis",
                topTrailingLabel: "Más"
               ),
               style: .init(
                   doubleCardBgColor: Color.gray.opacity(0.1),
                   innerCardBgColor: .cyan,
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
    }
    .padding()
}
