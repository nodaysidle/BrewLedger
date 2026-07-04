import SwiftUI
import SwiftData

struct SettingsView: View {
    @AppStorage("defaultBrewMethod") private var defaultBrewMethod = "Pour Over"
    @Query(sort: \Brew.date, order: .reverse) private var brews: [Brew]
    @State private var exportFeedback: String?
    @State private var exportSuccess = false

    let brewMethods = ["Pour Over", "French Press", "Espresso", "AeroPress", "Cold Brew", "Other"]

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Default Brew Method", selection: $defaultBrewMethod) {
                        ForEach(brewMethods, id: \.self) { method in
                            Text(method).tag(method)
                        }
                    }
                } header: {
                    Label("Brewing Preferences", systemImage: "gearshape")
                }

                Section {
                    HStack {
                        Button("Export Brews as JSON") {
                            exportBrews()
                        }

                        if let feedback = exportFeedback {
                            Text(feedback)
                                .foregroundStyle(exportSuccess ? .green : .red)
                                .font(.caption)
                        }
                    }
                } header: {
                    Label("Data", systemImage: "square.and.arrow.up")
                } footer: {
                    Text("Exports all brew logs as a JSON file to your chosen location.")
                }
            }
            .formStyle(.grouped)
            .navigationTitle("Settings")
        }
    }

    private func exportBrews() {
        let jsonString = DataExportService.exportJSON(brews)
        DataExportService.savePanel(jsonString: jsonString) { success in
            exportFeedback = success ? "Export successful!" : "Export cancelled or failed."
            exportSuccess = success
        }
    }
}
