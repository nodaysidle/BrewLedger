import SwiftUI
import SwiftData

struct AddBeanView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var roastDate = Date()
    @State private var remainingAmount: Double = 250.0

    @State private var showingValidationAlert = false
    @State private var validationMessage = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Bean Details") {
                    TextField("Bean Name", text: $name)

                    DatePicker("Roast Date", selection: $roastDate, displayedComponents: .date)

                    TextField("Remaining Amount (g)", value: $remainingAmount, format: .number)
                }
            }
            .formStyle(.grouped)
            .navigationTitle("New Bean")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveBean()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
            .alert("Validation Error", isPresented: $showingValidationAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(validationMessage)
            }
        }
        .frame(minWidth: 350, minHeight: 300)
    }

    private func saveBean() {
        let trimmedName = name.trimmingCharacters(in: .whitespaces)
        guard !trimmedName.isEmpty else {
            validationMessage = "Bean name is required."
            showingValidationAlert = true
            return
        }

        guard remainingAmount >= 0 else {
            validationMessage = "Remaining amount must be 0 or greater."
            showingValidationAlert = true
            return
        }

        let bean = Bean(
            name: trimmedName,
            roastDate: roastDate,
            remainingAmount: remainingAmount
        )
        modelContext.insert(bean)
        dismiss()
    }
}
