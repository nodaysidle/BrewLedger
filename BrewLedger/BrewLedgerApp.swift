import SwiftUI
import SwiftData

@main
struct BrewLedgerApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(PersistenceController.shared)
    }
}
