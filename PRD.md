# Product Requirements Document — BrewLedger

## Product Summary
A native macOS app for home coffee enthusiasts to log, track, and review their brews with local-only persistence.

## Stack Lock
- Preset: native-macos-swiftui (Native macOS App).
- Stack enforcement lives in AGENTS.md Must Use / Must Not Use; do not substitute forbidden technologies.

## Target User
- Home coffee enthusiasts who want to track their brewing process and bean inventory offline.

## Problem
Coffee lovers lack a simple, private, local-first tool to log brew parameters and maintain bean inventory without cloud dependency.

## Goals
- Enable quick logging of brew details with bean, grind, water temp, method, and rating.
- Maintain a local bean inventory with roast date and remaining amount.
- Allow browsing and searching past brews by bean, method, or rating.

## Non-Goals
- No cloud sync, no accounts, no push notifications, no analytics charts, no multi-user support.

## Core Features
- Brew logging with bean name, grind size, water temp, brew method, and 1-5 rating.
- Bean inventory management with roast date and remaining amount.
- Search and filter brews by bean, method, or rating.
- Settings for default brew method and data export.

## Success Criteria
- User can log a brew with all required fields and see it in the brew list.
- User can add, edit, and delete beans in inventory.
- User can search brews by bean name, method, or rating.
- All data persists locally across app launches.
- App builds and runs with xcodebuild.
