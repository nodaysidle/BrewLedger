import XCTest
import SwiftData
@testable import BrewLedger

final class PersistenceTests: XCTestCase {

    var container: ModelContainer!

    @MainActor
    override func setUp() async throws {
        let schema = Schema([Brew.self, Bean.self])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        container = try ModelContainer(for: schema, configurations: [config])
    }

    override func tearDown() {
        container = nil
        super.tearDown()
    }

    @MainActor
    func testInsertAndFetchBrew() throws {
        let context = container.mainContext
        let brew = Brew(
            beanName: "Test Brew",
            grindSize: "Medium",
            waterTemp: 92.0,
            brewMethod: "V60",
            rating: 4
        )
        context.insert(brew)
        try context.save()

        let fetchDescriptor = FetchDescriptor<Brew>()
        let brews = try context.fetch(fetchDescriptor)

        XCTAssertEqual(brews.count, 1)
        XCTAssertEqual(brews.first?.beanName, "Test Brew")
        XCTAssertEqual(brews.first?.rating, 4)
    }

    @MainActor
    func testInsertAndFetchBean() throws {
        let context = container.mainContext
        let bean = Bean(name: "Test Bean", remainingAmount: 200.0)
        context.insert(bean)
        try context.save()

        let fetchDescriptor = FetchDescriptor<Bean>()
        let beans = try context.fetch(fetchDescriptor)

        XCTAssertEqual(beans.count, 1)
        XCTAssertEqual(beans.first?.name, "Test Bean")
        XCTAssertEqual(beans.first?.remainingAmount, 200.0)
    }

    @MainActor
    func testMultipleEntities() throws {
        let context = container.mainContext

        for i in 0..<3 {
            let brew = Brew(
                beanName: "Brew \(i)",
                grindSize: "Medium",
                waterTemp: 90.0,
                brewMethod: "V60",
                rating: 3
            )
            context.insert(brew)
        }

        for i in 0..<2 {
            let bean = Bean(name: "Bean \(i)")
            context.insert(bean)
        }

        try context.save()

        let brewFetch = FetchDescriptor<Brew>()
        let brews = try context.fetch(brewFetch)
        XCTAssertEqual(brews.count, 3)

        let beanFetch = FetchDescriptor<Bean>()
        let beans = try context.fetch(beanFetch)
        XCTAssertEqual(beans.count, 2)
    }
}
