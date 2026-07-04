import SwiftUI
import SwiftData

struct BeanInventoryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Bean.name) private var beans: [Bean]
    @State private var showingAddBean = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(beans) { bean in
                    BeanRow(bean: bean)
                        .contextMenu {
                            Button("Delete", role: .destructive) {
                                modelContext.delete(bean)
                            }
                        }
                }
            }
            .listStyle(.inset)
            .overlay {
                if beans.isEmpty {
                    ContentUnavailableView {
                        Label("No Beans in Inventory", systemImage: "leaf.fill")
                    } description: {
                        Text("Add your first beans to get started.")
                    } actions: {
                        Button("Add Beans") {
                            showingAddBean = true
                        }
                    }
                }
            }
            .navigationTitle("Beans")
            .toolbar {
                ToolbarItem {
                    Button {
                        showingAddBean = true
                    } label: {
                        Label("Add Bean", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddBean) {
                AddBeanView()
            }
        }
    }
}

private struct BeanRow: View {
    let bean: Bean

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(bean.name)
                    .font(.headline)
                Text("Roasted: \(bean.roastDate.formatted(date: .abbreviated, time: .omitted))")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text(String(format: "%.0f g", bean.remainingAmount))
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }
}
