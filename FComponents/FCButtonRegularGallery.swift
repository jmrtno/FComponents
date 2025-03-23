//
//  FCButtonGallery.swift
//  FComponents
//
//  Created by Javier Martin on 23/3/25.
//

import SwiftUI

struct FCButtonRegularGallery: View {
    var body: some View {
        VStack(alignment: .leading) {
            // Sección 1: Botones sin iconos
            Text("Botones sin iconos")
                .padding(.top, 10)
            VStack(alignment: .leading) {
                HStack {
                    FCButton(createButtonViewModel(label: "Button",
                                                   leadingIcon: nil,
                                                   trailingIcon: nil))
                    FCButton(createButtonViewModel(label: "Button",
                                                   leadingIcon: nil,
                                                   trailingIcon: nil,
                                                   invertCorners: true))
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)

            // Sección 2: Botones sin texto
            Text("Botones sin texto")
                .padding(.top, 10)
            VStack(alignment: .leading)  {
                HStack {
                    FCButton(createButtonViewModel(trailingIcon: nil))
                    FCButton(createButtonViewModel(trailingIcon: nil,
                                                   invertCorners: true))
                }
                HStack {
                    FCButton(createButtonViewModel())
                    FCButton(createButtonViewModel(invertCorners: true))
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)

            // Sección 3: Botones con iconos
            Text("Botones con iconos")
                .padding(.top, 10)
            VStack(alignment: .leading)  {
                HStack {
                    FCButton(createButtonViewModel(label: "Button",
                                                   trailingIcon: nil))
                    FCButton(createButtonViewModel(label: "Button",
                                                   trailingIcon: nil,
                                                   invertCorners: true))
                }
                HStack {
                    FCButton(createButtonViewModel(label: "Button",
                                                   leadingIcon: nil))
                    FCButton(createButtonViewModel(label: "Button",
                                                   leadingIcon: nil,
                                                   invertCorners: true))
                }
                HStack {
                    FCButton(createButtonViewModel(label: "Button"))
                    FCButton(createButtonViewModel(label: "Button",
                                                   invertCorners: true))
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)

            // Sección 4: Botones con diferentes tamaños
            Text("Botones con diferentes tamaños")
                .padding(.top, 10)
            VStack(alignment: .leading)  {
                HStack {
                    FCButton(createButtonSizedViewModel(label: "Button", size: .small))
                    FCButton(createButtonSizedViewModel(label: "Button", size: .medium))
                    FCButton(createButtonSizedViewModel(label: "Button", size: .large))
                }
                HStack {
                    FCButton(createButtonSizedViewModel(label: "Button", size: .large, invertCorners: true))
                    FCButton(createButtonSizedViewModel(label: "Button", size: .medium, invertCorners: true))
                    FCButton(createButtonSizedViewModel(label: "Button", size: .small, invertCorners: true))
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)

            // Sección 5: Botones con diferentes tamaños
            Text("Botones con diferentes tamaños de iconos")
                .padding(.top, 10)
            VStack(alignment: .leading)  {
                HStack {
                    FCButton(createButtonIconSizedViewModel(label: "Button", size: .small))
                    FCButton(createButtonIconSizedViewModel(label: "Btn", size: .medium))
                    FCButton(createButtonIconSizedViewModel(label: "B", size: .large))
                }
                HStack {
                    FCButton(createButtonIconSizedViewModel(label: "B", size: .large, invertCorners: true))
                    FCButton(createButtonIconSizedViewModel(label: "Btn", size: .medium, invertCorners: true))
                    FCButton(createButtonIconSizedViewModel(label: "Button", size: .small, invertCorners: true))
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)

            // Sección 6: Botones con maxWidth
            Text("Boton con maxWidth")
                .padding(.top, 10)
            VStack {
                FCButton(createButtonViewModel(label: "Button",
                                               maxWidth: true))
                FCButton(createButtonViewModel(label: "Button",
                                               maxWidth: true,
                                               invertCorners: true))
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
        .padding()
    }

    private func createButtonViewModel(label: String? = nil,
                                       color: Color? = .gray,
                                       leadingIcon: String? = "folder",
                                       trailingIcon: String? = "trash",
                                       maxWidth: Bool = false,
                                       invertCorners: Bool = false) -> FCButton.ViewModel {
        let configuration = FCButton.Configuration(label: label,
                                                   leadingIcon: leadingIcon,
                                                   trailingIcon: trailingIcon,
                                                   maxWidth: maxWidth,
                                                   invertCornerRadius: invertCorners)
        let viewState = FCButton.ViewState(type: .enabled)
        let variant = FCButton.Variant(type: .regular(color: color))
        let style = FCButton.Style(textColor: .white,
                                   leadingIconColor: .black,
                                   trailingIconColor: .black)
        let size = FCButton.Size(type: .medium)
        let interaction = FCButton.Interaction(onTap: {})

        return FCButton.ViewModel(configuration: configuration,
                                  viewState: viewState,
                                  variant: variant,
                                  style: style,
                                  size: size,
                                  interaction: interaction)
    }

    private func createButtonSizedViewModel(label: String? = nil,
                                            size: FCButton.Size,
                                            color: Color? = .gray,
                                            invertCorners: Bool = false) -> FCButton.ViewModel {
        let configuration = FCButton.Configuration(label: label, invertCornerRadius: invertCorners)
        let viewState = FCButton.ViewState(type: .enabled)
        let variant = FCButton.Variant(type: .regular(color: color))
        let style = FCButton.Style(textColor: .white)
        let interaction = FCButton.Interaction(onTap: {})
        
        return FCButton.ViewModel(configuration: configuration,
                                  viewState: viewState,
                                  variant: variant,
                                  style: style,
                                  size: size,
                                  interaction: interaction)
    }

    private func createButtonIconSizedViewModel(label: String? = nil,
                                            size: FCButton.Size,
                                            leadingIcon: String? = "folder",
                                            trailingIcon: String? = "trash",
                                            color: Color? = .gray,
                                            invertCorners: Bool = false) -> FCButton.ViewModel {
        let configuration = FCButton.Configuration(label: label,
                                                   leadingIcon: leadingIcon,
                                                   trailingIcon: trailingIcon,
                                                   invertCornerRadius: invertCorners)
        let viewState = FCButton.ViewState(type: .enabled)
        let variant = FCButton.Variant(type: .regular(color: color))
        let style = FCButton.Style(textColor: .white)
        let interaction = FCButton.Interaction(onTap: {})

        return FCButton.ViewModel(configuration: configuration,
                                  viewState: viewState,
                                  variant: variant,
                                  style: style,
                                  size: size,
                                  interaction: interaction)
    }
}

#Preview {
    ScrollView {
        FCButtonRegularGallery()
    }
}
