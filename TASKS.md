# Task Breakdown — BrewLedger

## Implementation Phases
### phase-1 - Xcode Project Foundation and Core Data Models
- task_id: phase-1
- objective: Set up the Xcode project with SwiftUI app entry, SwiftData models, PersistenceController, asset catalog, and verify build with xcodebuild.
- files_to_create:
  - BrewLedger.xcodeproj/project.pbxproj
  - BrewLedger/BrewLedgerApp.swift
  - BrewLedger/Views/RootView.swift
  - BrewLedger/Views/DashboardView.swift
  - BrewLedger/Models/Brew.swift
  - BrewLedger/Models/Bean.swift
  - BrewLedger/Storage/PersistenceController.swift
  - BrewLedger/Assets.xcassets/Contents.json
  - BrewLedger/Assets.xcassets/AppIcon.appiconset/Contents.json
- files_to_modify:
  []
- acceptance_criteria:
- Xcode project BrewLedger.xcodeproj exists and contains a macOS app target named BrewLedger.
- BrewLedgerApp.swift defines a SwiftUI App with WindowGroup and .modelContainer for PersistenceController.
- DashboardView.swift shows a simple welcome text.
- Brew.swift is a SwiftData @Model with id, date, beanName, grindSize, waterTemp, brewMethod, rating, notes.
- Bean.swift is a SwiftData @Model with id, name, roastDate, remainingAmount.
- PersistenceController.swift creates a ModelContainer with Brew and Bean models and provides a shared instance.
- xcodebuild -project BrewLedger.xcodeproj -scheme BrewLedger -destination 'platform=macOS' build succeeds.
- The Xcode project file defines a macOS app target and a test target.
- The SwiftUI app entry launches RootView or DashboardView without a web wrapper.
- SwiftData @Model files and ModelContainer or PersistenceController setup compile.
- Asset catalog and AppIcon resources exist in Assets.xcassets.
- xcodebuild build completes for the concrete app scheme.
- validation_cmd: xcodebuild -project BrewLedger.xcodeproj -scheme BrewLedger -destination 'platform=macOS' build
- task_prompt: Create the native macOS Xcode project foundation, SwiftUI app entry, RootView or DashboardView, SwiftData @Model files, PersistenceController or ModelContainer setup, asset catalog, AppIcon resources, and run xcodebuild build for the concrete app scheme.

### phase-2 - Brew Logging and Bean Inventory Views
- task_id: phase-2
- objective: Implement main product data models, services, local persistence workflows, SwiftUI views for brew logging and bean inventory, SwiftData integration.
- files_to_create:
  - BrewLedger/Views/BrewListView.swift
  - BrewLedger/Views/BrewDetailView.swift
  - BrewLedger/Views/AddBrewView.swift
  - BrewLedger/Views/BeanInventoryView.swift
  - BrewLedger/Views/AddBeanView.swift
  - BrewLedger/Services/DataExportService.swift
- files_to_modify:
  - BrewLedger/Views/RootView.swift
  - BrewLedger/Views/DashboardView.swift
- acceptance_criteria:
- BrewListView displays all brews sorted by date descending, with search bar filtering by beanName, brewMethod, or rating.
- AddBrewView presents a form with fields for beanName, grindSize, waterTemp, brewMethod (picker), rating (stepper 1-5), notes (optional), and saves to SwiftData.
- BrewDetailView shows full brew details and allows deletion.
- BeanInventoryView lists all beans with name, roast date, and remaining amount, with context menu or toolbar delete (macOS-native, not swipe-to-delete).
- AddBeanView provides form for name, roastDate (date picker), remainingAmount (text field), and saves to SwiftData.
- DashboardView shows recent 5 brews and total bean count.
- DataExportService can export brews as JSON to a user-chosen file via NSSavePanel.
- Core product models and services implement the main user workflow with Swift types.
- SwiftData writes and reads the primary local records through ModelContext or PersistenceController.
- Permission or AppKit bridge code is isolated to native macOS APIs that SwiftUI cannot own directly.
- Primary feature views render real local data instead of static sample content.
- xcodebuild build completes after the core workflow is wired.
- validation_cmd: xcodebuild -project BrewLedger.xcodeproj -scheme BrewLedger -destination 'platform=macOS' build
- task_prompt: Implement the primary product workflow with SwiftData-backed models, Swift services, permission handling where needed, isolated AppKit bridge code only for native macOS APIs, real SwiftUI views wired to local data, and run xcodebuild build.

### phase-3 - Settings, Dashboard Polish, and UX Refinements
- task_id: phase-3
- objective: Add Settings view with default brew method and data export, polish Dashboard, and refine overall UX.
- files_to_create:
  - BrewLedger/Views/SettingsView.swift
- files_to_modify:
  - BrewLedger/Views/RootView.swift
  - BrewLedger/Views/DashboardView.swift
  - BrewLedger/Views/BrewListView.swift
  - BrewLedger/Views/BeanInventoryView.swift
- acceptance_criteria:
- SettingsView includes a picker for default brew method (stored in UserDefaults) and a button to export brews as JSON using DataExportService.
- DashboardView shows a summary card with recent brews and bean count, with navigation to full lists.
- BrewListView and BeanInventoryView have empty state messages when no data.
- All views use consistent styling (e.g., listStyle, padding, SF Symbols).
- App icon is set to a proper coffee-related icon (use SF Symbol or custom asset).
- Dashboard and detail views use polished SwiftUI layouts for common macOS window sizes.
- Settings expose local privacy, storage, and permission controls relevant to the product.
- User-facing empty, loading, and error states are readable and actionable.
- Local-first behavior remains intact with no wrapper, browser-first, telemetry, or backend architecture drift.
- xcodebuild build completes after UI polish.
- validation_cmd: xcodebuild -project BrewLedger.xcodeproj -scheme BrewLedger -destination 'platform=macOS' build
- task_prompt: Polish the SwiftUI dashboard, detail screens, settings, local privacy controls, empty, loading, and error states, and macOS window behavior while preserving the native SwiftUI and SwiftData stack; run xcodebuild build.

### phase-4 - Testing and Validation
- task_id: phase-4
- objective: Add unit tests for models, services, and SwiftData persistence, and verify with xcodebuild test.
- files_to_create:
  - BrewLedgerTests/BrewModelTests.swift
  - BrewLedgerTests/BeanModelTests.swift
  - BrewLedgerTests/PersistenceTests.swift
  - BrewLedgerTests/DataExportServiceTests.swift
- files_to_modify:
  - BrewLedger.xcodeproj/project.pbxproj
- acceptance_criteria:
- BrewModelTests verify Brew initializer, default values, and rating validation (1-5).
- BeanModelTests verify Bean initializer and remainingAmount non-negative validation.
- PersistenceTests verify saving and fetching Brew and Bean objects using an in-memory ModelContainer.
- DataExportServiceTests verify JSON export string contains expected fields.
- xcodebuild test -project BrewLedger.xcodeproj -scheme BrewLedger -destination 'platform=macOS' passes all tests.
- Model tests cover the primary SwiftData entities and relationships.
- Service tests cover the main local workflow without network dependencies.
- Persistence tests use an isolated local ModelContainer or test store.
- xcodebuild test completes for the concrete macOS scheme when tests exist.
- Manual validation notes cover launch, primary path, local persistence, and relevant permissions.
- validation_cmd: xcodebuild test -project BrewLedger.xcodeproj -scheme BrewLedger -destination 'platform=macOS'
- task_prompt: Create BrewModelTests.swift: test that Brew initializer sets all properties, test that rating is clamped to 1-5 (if applicable), test that default date is set. Create BeanModelTests.swift: test Bean initializer, test that remainingAmount is non-negative (assert on creation). Create PersistenceTests.swift: use an in-memory ModelContainer, insert a Brew and a Bean, save context, then fetch and verify count and properties. Create DataExportServiceTests.swift: test that exportJSON function returns a string containing 'beanName' and 'rating' keys. Ensure all tests pass with xcodebuild test.
