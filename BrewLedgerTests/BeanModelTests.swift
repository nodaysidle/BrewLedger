import XCTest
@testable import BrewLedger

final class BeanModelTests: XCTestCase {

    func testInit_SetsAllProperties() {
        let bean = Bean(
            name: "Colombian Supremo",
            roastDate: Date(),
            remainingAmount: 250.0
        )
        XCTAssertEqual(bean.name, "Colombian Supremo")
        XCTAssertNotNil(bean.roastDate)
        XCTAssertEqual(bean.remainingAmount, 250.0)
        XCTAssertNotNil(bean.id)
    }

    func testRemainingAmount_Clamped() {
        let beanNegative = Bean(name: "Test", remainingAmount: -10.0)
        XCTAssertEqual(beanNegative.remainingAmount, 0.0)

        let beanZero = Bean(name: "Test", remainingAmount: 0.0)
        XCTAssertEqual(beanZero.remainingAmount, 0.0)

        let beanPositive = Bean(name: "Test", remainingAmount: 250.0)
        XCTAssertEqual(beanPositive.remainingAmount, 250.0)
    }

    func testDefaultValues() {
        let bean = Bean(name: "Default Bean")
        XCTAssertEqual(bean.name, "Default Bean")
        XCTAssertNotNil(bean.roastDate)
        XCTAssertEqual(bean.remainingAmount, 0.0)
        XCTAssertNotNil(bean.id)
    }
}
