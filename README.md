# FComponents

A reusable SwiftUI component library for iOS. A collection of customizable, production-ready UI components built with Swift 6 and SwiftUI, designed to be dropped into any project as a framework.

## 🎯 Purpose

FComponents provides a set of well-structured, highly configurable SwiftUI components that follow a consistent architecture. Instead of rewriting UI components from scratch in every project, you can use this library to get polished, flexible components with a clean, declarative configuration API.

## ✨ Features

- **Reusable Components**: A growing collection of SwiftUI components for common UI patterns
- **Consistent Architecture**: Every component follows the same Configuration / ViewState / Variant / Style / Size / Interaction pattern
- **Swift 6 Ready**: Built with Swift 6.0 using `@Observable` view models and `Sendable`-conformant value types
- **Gallery Previews**: Components include gallery views for visual inspection in Xcode Previews
- **Framework Target**: Distributed as a Swift framework with DocC documentation catalog

## 🏗️ Architecture

Every component in FComponents follows a **consistent, declarative architecture** based on a ViewModel with clearly separated concerns.

### 🧩 Component Pattern

Each component is split into two files:

- **`<Component>.swift`** — The SwiftUI `View` implementation (presentation only)
- **`<Component>+ViewModel.swift`** — The configuration types and `@Observable` `ViewModel`

The ViewModel is composed of these value-type building blocks:

| Building Block   | Responsibility                                              |
|------------------|-------------------------------------------------------------|
| `Configuration`  | Data-level config (labels, icons, layout flags, alignment)  |
| `ViewState`      | Enabled / disabled state                                    |
| `Variant`        | Visual variant (colors, gradients, borders, etc.)           |
| `Style`          | Colors (text, icons, backgrounds, borders)                  |
| `Size`           | Size enum (small, medium, large) with derived metrics       |
| `Interaction`    | Tap callback (`@MainActor @Sendable` closure)               |

### 📁 Project Structure

```
FComponents/
├── FComponents.xcodeproj
├── FComponents/                          # Framework target
│   ├── FComponents_framework.h           # Umbrella header
│   └── FComponents_framework.docc/       # DocC documentation catalog
│       └── FComponents_framework.md
└── FComponentsApp/                       # Demo app target
    ├── FComponentsApp.swift              # App entry point
    ├── Assets.xcassets
    ├── <Component>/                      # One folder per component
    │   ├── <Component>.swift             # View implementation
    │   ├── <Component>+ViewModel.swift   # Configuration, variants, sizes
    │   └── Gallery/                      # Optional gallery previews
    └── Utils/
        └── Utils.swift                   # Shared view modifiers
```

### 🔄 Data Flow

1. **Configuration** → Value types define what the component shows and how it's laid out
2. **ViewModel** → `@Observable` class holds all building blocks together
3. **View** → Reads from ViewModel and renders the SwiftUI layout
4. **Interaction** → Tap callbacks are forwarded back to the caller

## 🚀 Getting Started

### Prerequisites

- iOS 18.6+
- Xcode 16.0+
- Swift 6.0+

### Installation

1. Clone the repository:
```bash
git clone https://github.com/jmrtno/FComponents.git
cd FComponents
```

2. Open the project in Xcode:
```bash
open FComponents.xcodeproj
```

3. Build and run the **FComponentsApp** target on your device or simulator to explore the components in the galleries.

### Integration Into Your Project

FComponents is built as a framework target (`FComponents.framework`). To use it in your own app:

1. Add the `FComponents.xcodeproj` to your workspace, or
2. Build the framework and add the resulting `.framework` to your project's **Embed Frameworks** build phase
3. Import the framework in your Swift files:
```swift
import FComponents
```

## 📱 Usage

### Exploring Components

The **FComponentsApp** target includes gallery views for each component. Use Xcode Previews to visually inspect all variants and configurations without running the app.

### Customizing Components

Every component is configured through its `ViewModel`, which is composed of immutable, `Sendable` value types. This makes configurations:

- **Type-safe** — The compiler ensures you provide valid configurations
- **Composable** — Mix and match variants, styles, and sizes freely
- **Testable** — Value types are easy to unit test
- **Sendable** — Safe for concurrent use in Swift 6

## 🛠️ Technical Details

### Swift 6 & Concurrency

- Built with **Swift 6.0** language mode
- All configuration types are `Sendable`
- ViewModels are `@MainActor` and `@Observable`
- Interaction closures are `@MainActor @Sendable`

### Framework Target

- `BUILD_LIBRARY_FOR_DISTRIBUTION = YES` — Supports binary distribution
- Includes a **DocC documentation catalog** (`FComponents_framework.docc`)
- Bundle identifier: `com.javidev.FComponents-framework`

### Press Gesture Utility

The `Utils.swift` file provides a reusable `onPressStateChanged` view modifier that powers the press animations across components:

```swift
extension View {
    func onPressStateChanged(_ action: @escaping (Bool) -> Void) -> some View
}
```

### Device Support

- **iPhone & iPad** (`TARGETED_DEVICE_FAMILY = 1,2`)
- **iOS Deployment Target**: 18.6

## 🔧 Configuration

### Build Settings

- **iOS Deployment Target**: 18.6
- **Swift Language Version**: 6.0
- **Architecture**: Declarative component pattern with `@Observable` ViewModels
- **Distribution**: Framework with `BUILD_LIBRARY_FOR_DISTRIBUTION`

### Environment Configurations

- **Debug**: Includes verbose logging and preview support
- **Release**: Optimized build with whole-module compilation

## 📋 Requirements

### Functional Requirements

- ✅ Reusable SwiftUI components for common UI patterns
- ✅ Consistent configuration API across all components
- ✅ Gallery previews for visual inspection

### Non-Functional Requirements

- ✅ Swift 6 concurrency-safe (`Sendable`, `@MainActor`)
- ✅ Clean, maintainable, consistent architecture
- ✅ Framework distribution ready
- ✅ iPad and iPhone support
- ✅ DocC documentation catalog

## 🧪 Testing

### Visual Testing

Use Xcode Previews to inspect each component:

1. Open any component file in Xcode
2. Use the Canvas to render the `#Preview` blocks
3. Explore the gallery views for all variants and sizes

### Manual Testing

1. Run the **FComponentsApp** target
2. Uncomment the desired component in `FComponentsApp.swift`
3. Interact with the component on device or simulator

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

When adding a new component, follow the existing pattern:
- Create a `<Component>.swift` (View) and `<Component>+ViewModel.swift` (configuration types)
- Include the building blocks: `Configuration`, `ViewState`, `Variant`, `Style`, `Size`, `Interaction`
- Add a gallery view for visual inspection
- Add the new files to both targets in `project.pbxproj`

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- SwiftUI for modern declarative UI development
- Swift 6 concurrency model for safe, predictable code
- The `@Observable` macro for reactive state management

## 📞 Support

If you have any questions or issues, please open an issue on the GitHub repository.

---

**Made with ❤️ using SwiftUI and Swift 6**
