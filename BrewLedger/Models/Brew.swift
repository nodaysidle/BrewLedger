import Foundation
import SwiftData

@Model
final class Brew {
    var id: UUID
    var date: Date
    var beanName: String
    var grindSize: String
    var waterTemp: Double
    var brewMethod: String
    var rating: Int
    var notes: String?

    init(
        id: UUID = UUID(),
        date: Date = Date(),
        beanName: String,
        grindSize: String,
        waterTemp: Double,
        brewMethod: String,
        rating: Int,
        notes: String? = nil
    ) {
        self.id = id
        self.date = date
        self.beanName = beanName
        self.grindSize = grindSize
        self.waterTemp = waterTemp
        self.brewMethod = brewMethod
        self.rating = min(max(rating, 1), 5)
        self.notes = notes
    }
}
