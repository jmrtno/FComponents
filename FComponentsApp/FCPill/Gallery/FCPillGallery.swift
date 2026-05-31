import SwiftUI

struct FCPillGallery: View {
    @State private var isSelected1 = false
    @State private var isSelected2 = true
    @State private var isSelected3 = false
    @State private var isSelected4 = true
    @State private var isSelectedSmall = false
    @State private var isSelectedMedium = false
    @State private var isSelectedLarge = false
    @State private var isSelectedText1 = false
    @State private var isSelectedText2 = true
    @State private var isSelectedImage1 = false
    @State private var isSelectedImage2 = true

    var body: some View {
        VStack(spacing: 20) {
            // Variant primary
            Text("Primary Variant")
                .font(.headline)
            HStack(spacing: 10) {
                FCPill(
                    viewModel: createPillViewModel(text: "Option 1", image: "star.fill", variant: .primary),
                    isSelected: $isSelected1
                )
                FCPill(
                    viewModel: createPillViewModel(text: "Option 2", image: "heart.fill", variant: .primary),
                    isSelected: $isSelected2
                )
            }

            // Variant secondary
            Text("Secondary Variant")
                .font(.headline)
            HStack(spacing: 10) {
                FCPill(
                    viewModel: createPillViewModel(text: "Filter A", image: "line.3.horizontal.decrease.circle", variant: .secondary),
                    isSelected: $isSelected3
                )
                FCPill(
                    viewModel: createPillViewModel(text: "Filter B", image: "line.3.horizontal.decrease.circle", variant: .secondary),
                    isSelected: $isSelected4
                )
            }

            // Different sizes
            Text("Different Sizes")
                .font(.headline)
            HStack(spacing: 10) {
                FCPill(
                    viewModel: createPillViewModel(text: "Small", image: "circle", variant: .primary, size: .small),
                    isSelected: $isSelectedSmall
                )
                FCPill(
                    viewModel: createPillViewModel(text: "Medium", image: "circle", variant: .primary, size: .medium),
                    isSelected: $isSelectedMedium
                )
                FCPill(
                    viewModel: createPillViewModel(text: "Large", image: "circle", variant: .primary, size: .large),
                    isSelected: $isSelectedLarge
                )
            }

            // Text only
            Text("Text Only")
                .font(.headline)
            HStack(spacing: 10) {
                FCPill(
                    viewModel: createPillViewModel(text: "Text Only", image: nil, variant: .primary),
                    isSelected: $isSelectedText1
                )
                FCPill(
                    viewModel: createPillViewModel(text: "Selected", image: nil, variant: .primary),
                    isSelected: $isSelectedText2
                )
            }

            // Image only
            Text("Image Only")
                .font(.headline)
            HStack(spacing: 10) {
                FCPill(
                    viewModel: createPillViewModel(text: nil, image: "star.fill", variant: .primary),
                    isSelected: $isSelectedImage1
                )
                FCPill(
                    viewModel: createPillViewModel(text: nil, image: "heart.fill", variant: .primary),
                    isSelected: $isSelectedImage2
                )
            }
        }
        .padding()
    }

    private func createPillViewModel(text: String? = nil,
                                     image: String? = nil,
                                     variant: PillVariant,
                                     size: FCPill.Size = .medium) -> FCPill.ViewModel {
        let configuration = FCPill.Configuration(text: text, image: image)
        let viewState = FCPill.ViewState.enabled
        let style = FCPill.Style()
        let interaction = FCPill.Interaction(onTap: {})

        return FCPill.ViewModel(
            configuration: configuration,
            viewState: viewState,
            variant: variant.colors,
            style: style,
            size: size,
            interaction: interaction
        )
    }
}

enum PillVariant {
    case primary
    case secondary

    var colors: FCPill.Variant {
        switch self {
        case .primary:
            return FCPill.Variant(
                selectedColor: .white,
                unselectedColor: .white
            )
        case .secondary:
            return FCPill.Variant(
                selectedColor: .blue,
                unselectedColor: .gray
            )
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        FCPillGallery()
    }
}
