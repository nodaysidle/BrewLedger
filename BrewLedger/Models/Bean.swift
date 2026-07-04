import Foundation
import SwiftData

@Model
final class Bean {
    var id: UUID
    var name: String
    var roastDate: Date
    var remainingAmount: Double

    init(
        id: UUID = UUID(),
        name: String,
        roastDate: Date = Date(),
        remainingAmount: Double = 0.0
    ) {
        self.id = id
        self.name = name
        self.roastDate = roastDate
        self.remainingAmount = max(remainingAmount, 0)
    }
}
