import SwiftUI

struct FCPillGallery: View {
    // Multi-selection: cada pill gestiona su propio estado
    @State private var multiA = false
    @State private var multiB = false
    @State private var multiC = false

    // Single-selection: estado compartido, solo una pill activa a la vez
    @State private var singlePrimary: Int? = nil
    @State private var singleSecondary: Int? = nil

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                // MARK: Multi-selection · Primary
                Text("Multi-selection · Primary")
                    .font(.headline)
                HStack(spacing: 10) {
                    FCPill(
                        viewModel: createPillViewModel(text: "Option A", image: "star.fill", variant: .primary(textColor: .white, backgroundColor: .blue)),
                        isSelected: $multiA
                    )
                    FCPill(
                        viewModel: createPillViewModel(text: "Option B", image: "heart.fill", variant: .primary(textColor: .white, backgroundColor: .blue)),
                        isSelected: $multiB
                    )
                    FCPill(
                        viewModel: createPillViewModel(text: "Option C", variant: .primary(textColor: .white, backgroundColor: .blue)),
                        isSelected: $multiC
                    )
                }

                // MARK: Single-selection · Primary
                Text("Single-selection · Primary")
                    .font(.headline)
                HStack(spacing: 10) {
                    ForEach(0..<3, id: \.self) { index in
                        let labels = ["Todos", "Activos", "Cerrados"]
                        FCPill(
                            viewModel: createPillViewModel(
                                text: labels[index],
                                variant: .primary(textColor: .white, backgroundColor: .blue),
                                onTap: { singlePrimary = index }
                            ),
                            isSelected: Binding(
                                get: { singlePrimary == index },
                                set: { _ in singlePrimary = index }
                            )
                        )
                    }
                }

                // MARK: Multi-selection · Secondary
                Text("Multi-selection · Secondary")
                    .font(.headline)
                HStack(spacing: 10) {
                    FCPill(
                        viewModel: createPillViewModel(text: "Tag A", image: "line.3.horizontal.decrease.circle", variant: .secondary(textAndBorderColor: .blue, backgroundColor: .blue)),
                        isSelected: $multiA
                    )
                    FCPill(
                        viewModel: createPillViewModel(text: "Tag B", image: "line.3.horizontal.decrease.circle", variant: .secondary(textAndBorderColor: .blue, backgroundColor: .blue)),
                        isSelected: $multiB
                    )
                    FCPill(
                        viewModel: createPillViewModel(text: "Tag C", variant: .secondary(textAndBorderColor: .blue, backgroundColor: .blue)),
                        isSelected: $multiC
                    )
                }

                // MARK: Single-selection · Secondary
                Text("Single-selection · Secondary")
                    .font(.headline)
                HStack(spacing: 10) {
                    ForEach(0..<3, id: \.self) { index in
                        let labels = ["Social", "Jurídica", "Médica"]
                        FCPill(
                            viewModel: createPillViewModel(
                                text: labels[index],
                                variant: .secondary(textAndBorderColor: .indigo, backgroundColor: .indigo),
                                onTap: { singleSecondary = index }
                            ),
                            isSelected: Binding(
                                get: { singleSecondary == index },
                                set: { _ in singleSecondary = index }
                            )
                        )
                    }
                }

                // MARK: Sizes
                Text("Sizes")
                    .font(.headline)
                HStack(spacing: 10) {
                    FCPill(
                        viewModel: createPillViewModel(text: "Small", variant: .primary(textColor: .white, backgroundColor: .blue), size: .small),
                        isSelected: $multiA
                    )
                    FCPill(
                        viewModel: createPillViewModel(text: "Medium", variant: .primary(textColor: .white, backgroundColor: .blue), size: .medium),
                        isSelected: $multiB
                    )
                    FCPill(
                        viewModel: createPillViewModel(text: "Large", variant: .primary(textColor: .white, backgroundColor: .blue), size: .large),
                        isSelected: $multiC
                    )
                }
            }
            .padding()
        }
    }

    private func createPillViewModel(text: String? = nil,
                                     image: String? = nil,
                                     variant: FCPill.Variant,
                                     size: FCPill.Size = .medium,
                                     onTap: @escaping @MainActor @Sendable () -> Void = {}) -> FCPill.ViewModel {
        let configuration = FCPill.Configuration(text: text, image: image)
        let viewState = FCPill.ViewState.enabled
        let style = FCPill.Style()
        let interaction = FCPill.Interaction(onTap: onTap)

        return FCPill.ViewModel(
            configuration: configuration,
            viewState: viewState,
            variant: variant,
            style: style,
            size: size,
            interaction: interaction
        )
    }
}

#Preview {
    ZStack {
        FCPillGallery()
    }
}
