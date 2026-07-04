# Agent Execution Contract — BrewLedger

## Read Order
- PRD.md
- ARD.md
- TRD.md
- TASKS.md
- AGENTS.md

## Hard Stack Contract
- Preset id: native-macos-swiftui
- Preset label: Native macOS App
- Swift
- SwiftUI 6
- SwiftData when persistence is needed
- native macOS app architecture
- Xcode-style project
- xcodebuild validation
- local-first/privacy-first design
- AppKit bridge only when SwiftUI cannot handle native macOS APIs
- local-first by default
- native macOS

## Must Use
- Swift
- SwiftUI 6
- SwiftData when persistence is needed
- Xcode-style native macOS project
- ModelContainer or PersistenceController for local persistence
- AppKit bridge only where SwiftUI cannot access required native macOS APIs

## Must Not Use
- React
- Electron
- Tauri
- WebView shell
- Node backend
- browser-first architecture
- Package.swift
- swift build

## Architecture Rules
- Agent must enforce SwiftUI 6 + SwiftData in an Xcode-style native macOS project validated by xcodebuild.
- Agent must keep local-first persistence with no cloud sync or telemetry by default.
- Agent must keep AppKit bridges isolated to permissions or native APIs SwiftUI cannot provide.
- Agent must implement TASKS.md file ownership exactly and treat TRD.md as the technical contract.

## File Rules
- Use an Xcode-style native macOS project with separate app and test targets.
- Keep SwiftUI app entry, views, models, services, storage, assets, and tests in clearly named project groups.
- Keep exact file creation and modification ownership in TASKS.md only.
- Do not repeat concrete TASKS file paths in AGENTS.md file rules.

## Task Execution Rules
- Implement tasks in TASKS.md phase order.
- Start with Phase 1 and create the Xcode project foundation before feature expansion.
- Keep generated application source outside this documentation packet until a downstream build task starts.
- Do not substitute the selected preset or add unrequested cloud services.

## Validation Rules
- Run the validation command listed on each task before marking that task complete.
- Use xcodebuild as the packet-level acceptance baseline for build validation.
- Use xcodebuild test when test files exist.
- Treat missing Xcode project files, SwiftData models, ModelContainer/PersistenceController setup, or AppIcon assets as task failures.

## Stop Conditions
- Stop if a task asks for a technology listed under Must Not Use.
- Stop if Phase 1 cannot produce the named Xcode project foundation files.
- Stop if validation uses a non-Xcode build command for the native macOS app.
- Stop if a validation command fails and the failure is not documented with a concrete fix path.
