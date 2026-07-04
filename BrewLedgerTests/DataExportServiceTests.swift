import XCTest
@testable import BrewLedger

final class DataExportServiceTests: XCTestCase {

    func testExportJSON_ContainsExpectedKeys() {
        let brew = Brew(
            beanName: "Test Bean",
            grindSize: "Medium",
            waterTemp: 92.5,
            brewMethod: "V60",
            rating: 4,
            notes: "Great coffee"
        )
        let json = DataExportService.exportJSON([brew])
        XCTAssertTrue(json.contains("beanName"), "JSON should contain beanName key")
        XCTAssertTrue(json.contains("rating"), "JSON should contain rating key")
        XCTAssertTrue(json.contains("brewMethod"), "JSON should contain brewMethod key")
        XCTAssertTrue(json.contains("grindSize"), "JSON should contain grindSize key")
        XCTAssertTrue(json.contains("waterTemp"), "JSON should contain waterTemp key")
    }

    func testExportJSON_EmptyArray() {
        let json = DataExportService.exportJSON([])
        let data = json.data(using: .utf8)!
        let objects = try! JSONSerialization.jsonObject(with: data) as! [Any]
        XCTAssertEqual(objects.count, 0, "Empty array should produce zero objects")
    }

    func testExportJSON_IsValidJSON() {
        let brew = Brew(
            beanName: "Test",
            grindSize: "Fine",
            waterTemp: 95.0,
            brewMethod: "Espresso",
            rating: 5
        )
        let json = DataExportService.exportJSON([brew])
        let data = json.data(using: .utf8)!
        XCTAssertNoThrow(try JSONSerialization.jsonObject(with: data), "JSON should be valid")
    }

    func testExportJSON_MultipleBrews() {
        var brews: [Brew] = []
        for i in 0..<3 {
            let brew = Brew(
                beanName: "Bean \(i)",
                grindSize: "Medium",
                waterTemp: 90.0 + Double(i),
                brewMethod: "V60",
                rating: i + 1
            )
            brews.append(brew)
        }
        let json = DataExportService.exportJSON(brews)
        let data = json.data(using: .utf8)!
        let objects = try! JSONSerialization.jsonObject(with: data) as! [[String: Any]]
        XCTAssertEqual(objects.count, 3, "Should have 3 objects in JSON array")
    }
}
