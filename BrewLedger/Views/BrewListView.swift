import SwiftUI
import SwiftData

struct BrewListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Brew.date, order: .reverse) private var brews: [Brew]
    @State private var searchText = ""
    @State private var showingAddBrew = false

    var filteredBrews: [Brew] {
        if searchText.isEmpty {
            return brews
        }
        return brews.filter { brew in
            brew.beanName.localizedCaseInsensitiveContains(searchText) ||
            brew.brewMethod.localizedCaseInsensitiveContains(searchText) ||
            String(brew.rating).contains(searchText)
        }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredBrews) { brew in
                    NavigationLink {
                        BrewDetailView(brew: brew)
                    } label: {
                        BrewRow(brew: brew)
                    }
                    .contextMenu {
                        Button("Delete", role: .destructive) {
                            modelContext.delete(brew)
                        }
                    }
                }
            }
            .listStyle(.inset)
            .searchable(text: $searchText, prompt: "Search by bean, method, or rating")
            .overlay {
                if filteredBrews.isEmpty && !brews.isEmpty {
                    ContentUnavailableView.search(text: searchText)
                } else if brews.isEmpty {
                    ContentUnavailableView {
                        Label("No Brews Logged Yet", systemImage: "mug.fill")
                    } description: {
                        Text("Start your coffee journey by logging your first brew.")
                    } actions: {
                        Button("Log Your First Brew") {
                            showingAddBrew = true
                        }
                    }
                }
            }
            .navigationTitle("Brews")
            .toolbar {
                ToolbarItem {
                    Button {
                        showingAddBrew = true
                    } label: {
                        Label("Add Brew", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddBrew) {
                AddBrewView()
            }
        }
    }
}

private struct BrewRow: View {
    let brew: Brew

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(brew.beanName)
                    .font(.headline)
                Text(brew.brewMethod)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            HStack(spacing: 2) {
                ForEach(1...5, id: \.self) { star in
                    Image(systemName: star <= brew.rating ? "star.fill" : "star")
                        .font(.caption)
                        .foregroundStyle(.yellow)
                }
            }
            Text(brew.date.formatted(date: .abbreviated, time: .shortened))
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }
}
