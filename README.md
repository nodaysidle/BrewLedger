# BrewLedger

> A native macOS app for home coffee enthusiasts to log, track, and review their brews — local-first, no cloud, no accounts.

![Platform](https://img.shields.io/badge/platform-macOS%2014%2B-silver)
![Swift](https://img.shields.io/badge/Swift-6.0-FA7343)
![SwiftUI](https://img.shields.io/badge/SwiftUI-6-007AFF)
![License](https://img.shields.io/badge/license-MIT-green)

## What It Does

BrewLedger helps you track every aspect of your home coffee brewing:

- **Log brews** — bean name, grind size, water temp, brew method, and 1–5 rating
- **Manage beans** — inventory with roast date and remaining amount (grams)
- **Search & filter** — find past brews by bean, method, or rating
- **Export data** — save your brew history as JSON
- **100% local** — all data stays on your Mac. No cloud, no accounts, no telemetry.

## Screenshots

| Dashboard | Brews | Beans |
|-----------|-------|-------|
| Recent activity + inventory overview | Searchable brew log | Bean inventory with context menu delete |

## Tech Stack

- **Swift 6** + **SwiftUI 6** — macOS-native UI
- **SwiftData** — local persistence, no Core Data or SQLite directly
- **Xcode project** — `xcodebuild` build + test, no SwiftPM
- **macOS 14+** — Sonoma or later
- **AppKit bridge** — `NSSavePanel` only for JSON export (no other AppKit bleed)

## Build & Run

### Requirements

- **Xcode 15.3+** (or Command Line Tools with `xcodebuild`)
- **macOS 14 (Sonoma)** or later

### Build

```bash
xcodebuild -project BrewLedger.xcodeproj -scheme BrewLedger -destination 'platform=macOS' build
```

### Test

```bash
xcodebuild test -project BrewLedger.xcodeproj -scheme BrewLedger -destination 'platform=macOS'
```

14 tests: model validation, persistence round-trip, JSON export correctness.

### Install

```bash
cp -R ~/Library/Developer/Xcode/DerivedData/BrewLedger-*/Build/Products/Debug/BrewLedger.app /Applications/
open /Applications/BrewLedger.app
```

## Architecture

BrewLedger follows a simple MV-like architecture:

```
RootView (TabView)
├── DashboardView    — recent brews + bean count summary
├── BrewListView     — searchable brew log
│   ├── BrewDetailView  — full detail + delete
│   └── AddBrewView     — brew logging form
├── BeanInventoryView   — bean list with context menu delete
│   └── AddBeanView     — bean entry form
└── SettingsView     — default method + JSON export

Models: Brew, Bean (SwiftData @Model)
Storage: PersistenceController (ModelContainer)
Services: DataExportService (JSONEncoder + NSSavePanel)
```

## Design Decisions

- **Rating clamped at model level** — `Brew.init` enforces 1–5, not just the view stepper
- **Bean amount non-negative** — clamped at model init
- **macOS-native delete** — context menu and toolbar buttons only, never swipe-to-delete
- **AppKit bridge isolated** — `DataExportService.swift` is the only file importing `AppKit`
- **In-memory test container** — `PersistenceController.inMemory` for isolated test runs
- **JSON export decoupled from dialog** — `exportJSON()` is pure and testable; `savePanel()` is manual verification only

## Project Structure

```
BrewLedger/
├── BrewLedger.xcodeproj/     # Xcode project (hand-crafted pbxproj)
├── BrewLedger/
│   ├── BrewLedgerApp.swift   # @main app entry
│   ├── Views/                # 8 SwiftUI views
│   ├── Models/               # Brew, Bean (@Model)
│   ├── Storage/              # PersistenceController
│   ├── Services/             # DataExportService
│   └── Assets.xcassets/      # App icon + asset catalog
├── BrewLedgerTests/          # 14 unit tests across 4 suites
├── PRD.md                    # Product requirements
├── ARD.md                    # Architecture requirements
├── TRD.md                    # Technical requirements
├── TASKS.md                  # Implementation task breakdown
├── AGENTS.md                 # Agent execution contract
└── USERGUIDE.md              # End-user guide
```

## License

MIT — see [LICENSE](LICENSE) for details.

## What It's Not

- ❌ No cloud sync, accounts, or sign-in
- ❌ No analytics, telemetry, or tracking
- ❌ No push notifications or background services
- ❌ No multi-user or collaboration features
- ❌ Not a recipe app, coffee timer, or brewing calculator

BrewLedger is a focused, private, local-first logbook for your coffee journey. Nothing more.
