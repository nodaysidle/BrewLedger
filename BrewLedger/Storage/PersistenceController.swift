import SwiftData

struct PersistenceController {
    static let shared: ModelContainer = {
        let schema = Schema([Brew.self, Bean.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    static let inMemory: ModelContainer = {
        let schema = Schema([Brew.self, Bean.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create in-memory ModelContainer: \(error)")
        }
    }()
}
