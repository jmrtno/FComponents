//
//  FCCard+ViewModel.swift
//  FComponents
//
//  Created by Javier Martin on 13/6/25.
//

import SwiftUI

public extension FCCard {
    struct Configuration {
        public var doubleCard: Bool
        public var maxWidth: Bool
        public var topLeadingContent: Bool
        public var topLeadingIcon: String?
        public var topLeadingLabel: String?
        public var topTrailingContent: Bool
        public var topTrailingIcon: String?
        public var topTrailingLabel: String?

        public init(doubleCard: Bool,
                    maxWidth: Bool,
                    topLeadingContent: Bool = false,
                    topLeadingIcon: String? = nil,
                    topLeadingLabel: String? = nil,
                    topTrailingContent: Bool = false,
                    topTrailingIcon: String? = nil,
                    topTrailingLabel: String? = nil) {
            self.doubleCard = doubleCard
            self.maxWidth = maxWidth
            self.topLeadingContent = topLeadingContent
            self.topLeadingIcon = topLeadingIcon
            self.topLeadingLabel = topLeadingLabel
            self.topTrailingContent = topTrailingContent
            self.topTrailingIcon = topTrailingIcon
            self.topTrailingLabel = topTrailingLabel
        }
    }

    struct Style {
        let doubleCardBgColor: Color
        let innerCardBgColor: Color
        let topLeadingContentColor: Color
        let topTrailingContentColor: Color

        public init(doubleCardBgColor: Color,
                    innerCardBgColor: Color,
                    topLeadingContentColor: Color = .clear,
                    topTrailingContentColor: Color = .clear) {
            self.doubleCardBgColor = doubleCardBgColor
            self.innerCardBgColor = innerCardBgColor
            self.topLeadingContentColor = topLeadingContentColor
            self.topTrailingContentColor = topTrailingContentColor
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
        @Published public var style: Style
        @Published public var interaction: Interaction

        public init(configuration: Configuration,
                    style: Style,
                    interaction: Interaction) {
            self.configuration = configuration
            self.style = style
            self.interaction = interaction
        }
    }
}
