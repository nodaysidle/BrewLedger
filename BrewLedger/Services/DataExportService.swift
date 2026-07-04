import Foundation
import SwiftData
#if canImport(AppKit)
import AppKit
import UniformTypeIdentifiers
#endif

struct BrewExportDTO: Codable {
    let id: String
    let date: String
    let beanName: String
    let grindSize: String
    let waterTemp: Double
    let brewMethod: String
    let rating: Int
    let notes: String?

    init(from brew: Brew) {
        self.id = brew.id.uuidString
        self.date = ISO8601DateFormatter().string(from: brew.date)
        self.beanName = brew.beanName
        self.grindSize = brew.grindSize
        self.waterTemp = brew.waterTemp
        self.brewMethod = brew.brewMethod
        self.rating = brew.rating
        self.notes = brew.notes
    }
}

struct DataExportService {
    static func exportJSON(_ brews: [Brew]) -> String {
        let dtos = brews.map { BrewExportDTO(from: $0) }
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        do {
            let data = try encoder.encode(dtos)
            return String(data: data, encoding: .utf8) ?? "[]"
        } catch {
            return "[]"
        }
    }

    #if canImport(AppKit)
    static func savePanel(jsonString: String) {
        savePanel(jsonString: jsonString) { _ in }
    }

    static func savePanel(jsonString: String, completion: @escaping (Bool) -> Void) {
        let savePanel = NSSavePanel()
        savePanel.title = "Export Brews"
        savePanel.nameFieldStringValue = "brewledger_export.json"
        savePanel.allowedContentTypes = [.json]
        savePanel.canCreateDirectories = true

        savePanel.begin { response in
            if response == .OK, let url = savePanel.url {
                do {
                    try jsonString.write(to: url, atomically: true, encoding: .utf8)
                    completion(true)
                } catch {
                    completion(false)
                }
            } else {
                completion(false)
            }
        }
    }
    #endif
}
