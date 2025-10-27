//
//  FCTextField.swift
//  FComponents
//
//  Created by Javier Martin on 18/6/25.
//

import SwiftUI

public struct FCTextField: View {

    @ObservedObject private var viewModel: ViewModel

    @State private var value : String = ""

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        mainContent
    }
}

private extension FCTextField {

    var mainContent: some View {
        VStack(spacing: 0) {
            HStack {
                TextField(
                    configuration.placeholder ?? "",
                    text: $value
                )
                if let icon = configuration.icon {
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                        .foregroundStyle(.secondary)
                        .padding(.trailing, 1)
                        .padding(.bottom, variant.type == .plain ? 6 : 0)
                }
            }
            
            if variant.type == .plain {
                Divider()
                    .frame(height: 1)
                    .background(.gray)
            }
        }
        .padding(10)
        .background(variant.background())
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: variant.borderWidth())
        )
    }
}

private extension FCTextField {
    var configuration: Configuration {
        viewModel.configuration
    }

    var variant: Variant {
        viewModel.variant
    }
}

#Preview {
    VStack {
        let configuration = FCTextField.Configuration(placeholder: "Placeholder",
                                                      icon: "square.and.arrow.up")
        let variant = FCTextField.Variant(type: .plain)
        let viewModel = FCTextField.ViewModel(configuration: configuration,
                                              variant: variant)
        FCTextField(viewModel: viewModel)
    }
    .padding()
    .background(.gray.opacity(0.4))
}
