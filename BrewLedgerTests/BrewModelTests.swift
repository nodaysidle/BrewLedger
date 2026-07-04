import XCTest
@testable import BrewLedger

final class BrewModelTests: XCTestCase {

    func testInit_SetsAllProperties() {
        let brew = Brew(
            beanName: "Ethiopian Yirgacheffe",
            grindSize: "Medium",
            waterTemp: 93.0,
            brewMethod: "V60",
            rating: 4,
            notes: "Fruity notes"
        )
        XCTAssertEqual(brew.beanName, "Ethiopian Yirgacheffe")
        XCTAssertEqual(brew.grindSize, "Medium")
        XCTAssertEqual(brew.waterTemp, 93.0)
        XCTAssertEqual(brew.brewMethod, "V60")
        XCTAssertEqual(brew.rating, 4)
        XCTAssertEqual(brew.notes, "Fruity notes")
        XCTAssertNotNil(brew.id)
    }

    func testDefaultDate_IsSet() {
        let before = Date()
        let brew = Brew(
            beanName: "Test Bean",
            grindSize: "Fine",
            waterTemp: 90.0,
            brewMethod: "Espresso",
            rating: 3
        )
        let after = Date()
        XCTAssertGreaterThanOrEqual(brew.date, before)
        XCTAssertLessThanOrEqual(brew.date, after)
    }

    func testRating_Clamped() {
        let brewLow = Brew(
            beanName: "Low",
            grindSize: "Coarse",
            waterTemp: 85.0,
            brewMethod: "French Press",
            rating: 0
        )
        XCTAssertEqual(brewLow.rating, 1)

        let brewHigh = Brew(
            beanName: "High",
            grindSize: "Coarse",
            waterTemp: 85.0,
            brewMethod: "French Press",
            rating: 6
        )
        XCTAssertEqual(brewHigh.rating, 5)

        let brewMid = Brew(
            beanName: "Mid",
            grindSize: "Coarse",
            waterTemp: 85.0,
            brewMethod: "French Press",
            rating: 3
        )
        XCTAssertEqual(brewMid.rating, 3)
    }

    func testDefaultValues() {
        let brew = Brew(
            beanName: "Default Test",
            grindSize: "Coarse",
            waterTemp: 100.0,
            brewMethod: "Pour Over",
            rating: 2
        )
        XCTAssertNotNil(brew.id)
        XCTAssertNil(brew.notes)
    }
}
