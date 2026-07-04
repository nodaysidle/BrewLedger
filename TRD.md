# Technical Requirements Document — BrewLedger

## Technical Summary
The technical plan maps the native macOS SwiftUI 6 app into Xcode project files, SwiftData models, local persistence, native services, permissions, and xcodebuild validation.

## Routes / Interfaces
- RootView: tab-based navigation with Dashboard, Brews, Beans, Settings.
- DashboardView: summary of recent brews and bean inventory overview.
- BrewListView: list of all brews with search/filter.
- BrewDetailView: detail of a single brew.
- AddBrewView: form to log a new brew.
- BeanInventoryView: list of beans with remaining amount.
- AddBeanView: form to add/edit a bean.
- SettingsView: default brew method picker and export button.

## Data Models
- Brew: @Model with id, date, beanName, grindSize, waterTemp, brewMethod, rating (Int 1-5), notes (optional).
- Bean: @Model with id, name, roastDate, remainingAmount (Double, grams).

## State Management
- All state derived from SwiftData queries; no global state managers.
- View state like search text or filter selection is local @State.

## Persistence
- SwiftData ModelContainer configured in PersistenceController.
- ModelContext injected via .modelContainer in app scene.
- UserDefaults stores defaultBrewMethod (String) for settings.

## Validation Commands
- xcodebuild -project BrewLedger.xcodeproj -scheme BrewLedger -destination 'platform=macOS' build
- xcodebuild test -project BrewLedger.xcodeproj -scheme BrewLedger -destination 'platform=macOS' when tests exist

## Implementation Constraints
- Brew rating must be 1-5.
- Bean remainingAmount must be non-negative.
- Brew beanName must not be empty.
