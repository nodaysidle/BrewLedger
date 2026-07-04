import SwiftUI
import SwiftData

struct BrewDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    let brew: Brew

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Rating stars
                HStack {
                    ForEach(1...5, id: \.self) { star in
                        Image(systemName: star <= brew.rating ? "star.fill" : "star")
                            .foregroundStyle(.yellow)
                            .font(.title2)
                    }
                }

                // Bean name
                VStack(alignment: .leading, spacing: 4) {
                    Text("Bean")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(brew.beanName)
                        .font(.title2)
                        .fontWeight(.semibold)
                }

                // Date
                VStack(alignment: .leading, spacing: 4) {
                    Text("Date")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(brew.date.formatted(date: .long, time: .shortened))
                        .font(.body)
                }

                // Brew Method
                VStack(alignment: .leading, spacing: 4) {
                    Text("Method")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(brew.brewMethod)
                        .font(.body)
                }

                // Grind Size
                VStack(alignment: .leading, spacing: 4) {
                    Text("Grind Size")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(brew.grindSize)
                        .font(.body)
                }

                // Water Temperature
                VStack(alignment: .leading, spacing: 4) {
                    Text("Water Temperature")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(String(format: "%.0f°C", brew.waterTemp))
                        .font(.body)
                }

                // Notes
                if let notes = brew.notes, !notes.isEmpty {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Notes")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(notes)
                            .font(.body)
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationTitle("Brew Detail")
        .toolbar {
            ToolbarItem {
                Button(role: .destructive) {
                    modelContext.delete(brew)
                    dismiss()
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
    }
}
