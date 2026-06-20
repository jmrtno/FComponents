//
//  FCCard+ViewModel.swift
//  FComponents
//
//  Created by Javier Martin on 13/6/25.
//

import SwiftUI

public extension FCCard {
    struct Configuration: Sendable {
        public var doubleCard: Bool
        public var maxWidth: Bool
        public var contentAlignment: Alignment
        public var topLeadingIcon: String?
        public var topLeadingLabel: String?
        public var topTrailingIcon: String?
        public var topTrailingLabel: String?

        public init(doubleCard: Bool,
                    maxWidth: Bool,
                    contentAlignment: Alignment = .center,
                    topLeadingIcon: String? = nil,
                    topLeadingLabel: String? = nil,
                    topTrailingIcon: String? = nil,
                    topTrailingLabel: String? = nil) {
            self.doubleCard = doubleCard
            self.maxWidth = maxWidth
            self.contentAlignment = contentAlignment
            self.topLeadingIcon = topLeadingIcon
            self.topLeadingLabel = topLeadingLabel
            self.topTrailingIcon = topTrailingIcon
            self.topTrailingLabel = topTrailingLabel
        }
    }

    struct Style: Sendable {
        let doubleCardBgColor: Color
        let innerCardBgColor: Color
        let doubleCardBorderColor: Color
        let innerCardBorderColor: Color
        let topLeadingContentColor: Color
        let topTrailingContentColor: Color

        public init(doubleCardBgColor: Color = .clear,
                    innerCardBgColor: Color,
                    doubleCardBorderColor: Color = .clear,
                    innerCardBorderColor: Color,
                    topLeadingContentColor: Color = .black,
                    topTrailingContentColor: Color = .black) {
            self.doubleCardBgColor = doubleCardBgColor
            self.innerCardBgColor = innerCardBgColor
            self.doubleCardBorderColor = doubleCardBorderColor
            self.innerCardBorderColor = innerCardBorderColor
            self.topLeadingContentColor = topLeadingContentColor
            self.topTrailingContentColor = topTrailingContentColor
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
        var style: Style
        var interaction: Interaction

        public init(configuration: Configuration,
                    style: Style,
                    interaction: Interaction) {
            self.configuration = configuration
            self.style = style
            self.interaction = interaction
        }
    }
}
