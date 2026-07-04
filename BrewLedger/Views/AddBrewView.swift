import SwiftUI
import SwiftData

struct AddBrewView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var beanName = ""
    @State private var grindSize = ""
    @State private var waterTemp: Double = 93.0
    @State private var brewMethod = "Pour Over"
    @State private var rating = 3
    @State private var notes = ""

    @State private var showingValidationAlert = false

    let brewMethods = ["Pour Over", "French Press", "Espresso", "AeroPress", "Cold Brew", "Other"]

    var body: some View {
        NavigationStack {
            Form {
                Section("Bean & Method") {
                    TextField("Bean Name", text: $beanName)

                    Picker("Brew Method", selection: $brewMethod) {
                        ForEach(brewMethods, id: \.self) { method in
                            Text(method).tag(method)
                        }
                    }
                }

                Section("Brew Details") {
                    TextField("Grind Size", text: $grindSize)
                    TextField("Water Temperature", value: $waterTemp, format: .number)
                }

                Section("Rating") {
                    Stepper(value: $rating, in: 1...5) {
                        HStack {
                            Text("Rating")
                            Spacer()
                            HStack(spacing: 2) {
                                ForEach(1...5, id: \.self) { star in
                                    Image(systemName: star <= rating ? "star.fill" : "star")
                                        .foregroundStyle(.yellow)
                                        .font(.caption)
                                }
                            }
                        }
                    }
                }

                Section("Notes (Optional)") {
                    TextField("Tasting notes...", text: $notes, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .formStyle(.grouped)
            .navigationTitle("New Brew")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveBrew()
                    }
                    .disabled(beanName.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
            .alert("Validation Error", isPresented: $showingValidationAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Bean name is required.")
            }
        }
        .frame(minWidth: 400, minHeight: 500)
    }

    private func saveBrew() {
        let trimmedName = beanName.trimmingCharacters(in: .whitespaces)
        guard !trimmedName.isEmpty else {
            showingValidationAlert = true
            return
        }

        let brew = Brew(
            date: Date(),
            beanName: trimmedName,
            grindSize: grindSize.trimmingCharacters(in: .whitespaces),
            waterTemp: waterTemp,
            brewMethod: brewMethod,
            rating: rating,
            notes: notes.trimmingCharacters(in: .whitespaces).isEmpty ? nil : notes.trimmingCharacters(in: .whitespaces)
        )
        modelContext.insert(brew)
        dismiss()
    }
}
