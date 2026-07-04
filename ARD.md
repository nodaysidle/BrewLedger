# Architecture Requirements Document — BrewLedger

## Architecture Summary
SwiftUI app with SwiftData persistence, local-first, no cloud. MV-like separation with models, views, and a persistence controller.

## Selected Preset
- native-macos-swiftui - Native macOS App

## Required Stack
- Use Native macOS App as the architecture preset.
- Keep the app native macOS with SwiftUI app lifecycle, SwiftData persistence, and local-first privacy defaults.
- Use an Xcode project boundary with xcodebuild validation, not SwiftPM.

## System Boundaries
- SwiftData models are the single source of truth for all domain data.
- Views observe @Model objects and use @Query for fetching.
- PersistenceController sets up ModelContainer and provides shared ModelContext.

## Folder Structure
- BrewLedgerTests/
- The Xcode project groups app source, assets, entitlements when needed, and tests without duplicating TASKS file ownership.
- The app source group owns SwiftUI app entry, root/dashboard/detail/settings views, SwiftData models, local services, and storage helpers.
- The test target owns model, service, and persistence tests for the local-first workflow.

## Rendering/Data Flow Model
- SwiftUI views use @State, @Binding, @Query, and @Environment for data flow.
- All data mutations go through SwiftData ModelContext via modelContainer.

## Trade-offs
- No cloud sync limits multi-device use but ensures privacy.
- SwiftData is used for all persistence; no Core Data or SQLite directly.
- AppKit bridge avoided unless required for file export dialogs (NSOpenPanel/NSSavePanel).

## Architecture Rules
- Architecture rule: Use SwiftUI app lifecycle with an Xcode project boundary and xcodebuild validation.
- Architecture rule: Use SwiftData with ModelContainer or PersistenceController for local persistence.
- Architecture rule: Keep AppKit bridges isolated to native APIs SwiftUI cannot access directly.
- Architecture rule: Treat TRD.md and TASKS.md as owners of concrete models, views, services, and validation commands.
