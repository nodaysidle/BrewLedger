import SwiftUI
import SwiftData

struct DashboardView: View {
    @Query(sort: \Brew.date, order: .reverse) private var allBrews: [Brew]
    @Query private var allBeans: [Bean]

    var recentBrews: [Brew] {
        Array(allBrews.prefix(5))
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Header
                    VStack(alignment: .leading, spacing: 4) {
                        Text("BrewLedger")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("Your coffee companion")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal)

                    // Summary cards
                    HStack(spacing: 16) {
                        NavigationLink {
                            BrewListView()
                        } label: {
                            SummaryCard(
                                title: "Total Brews",
                                value: "\(allBrews.count)",
                                systemImage: "mug.fill",
                                color: .brown
                            )
                        }
                        .buttonStyle(.plain)

                        NavigationLink {
                            BeanInventoryView()
                        } label: {
                            SummaryCard(
                                title: "Beans in Stock",
                                value: "\(allBeans.count)",
                                systemImage: "leaf.fill",
                                color: .green
                            )
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal)

                    // Recent Brews section
                    GroupBox {
                        VStack(alignment: .leading, spacing: 0) {
                            if recentBrews.isEmpty {
                                emptyState(
                                    icon: "mug.fill",
                                    title: "No brews yet",
                                    subtitle: "Start logging your coffee journey!"
                                )
                            } else {
                                ForEach(Array(recentBrews.enumerated()), id: \.element.id) { index, brew in
                                    NavigationLink {
                                        BrewDetailView(brew: brew)
                                    } label: {
                                        BrewCard(brew: brew)
                                    }
                                    .buttonStyle(.plain)

                                    if index < recentBrews.count - 1 {
                                        Divider()
                                            .padding(.leading, 12)
                                    }
                                }
                            }
                        }
                        .padding(8)
                    } label: {
                        Label("Recent Brews", systemImage: "mug.fill")
                    }
                    .padding(.horizontal)

                    // Bean Inventory section
                    GroupBox {
                        VStack(alignment: .leading, spacing: 0) {
                            if allBeans.isEmpty {
                                emptyState(
                                    icon: "leaf.fill",
                                    title: "No beans in stock",
                                    subtitle: "Add beans to your inventory to get started."
                                )
                            } else {
                                let previewBeans = Array(allBeans.prefix(5))
                                ForEach(Array(previewBeans.enumerated()), id: \.element.id) { index, bean in
                                    BeanCard(bean: bean)

                                    if index < previewBeans.count - 1 || allBeans.count > 5 {
                                        Divider()
                                            .padding(.leading, 12)
                                    }
                                }
                                if allBeans.count > 5 {
                                    NavigationLink {
                                        BeanInventoryView()
                                    } label: {
                                        HStack {
                                            Text("See all \(allBeans.count) beans...")
                                                .font(.subheadline)
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .font(.caption)
                                        }
                                        .padding(.vertical, 4)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        .padding(8)
                    } label: {
                        Label("Bean Inventory", systemImage: "leaf.fill")
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .frame(maxWidth: 650)
        }
    }

    @ViewBuilder
    private func emptyState(icon: String, title: String, subtitle: String) -> some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title)
                .foregroundStyle(.secondary)
            Text(title)
                .font(.headline)
                .foregroundStyle(.secondary)
            Text(subtitle)
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
    }
}

private struct SummaryCard: View {
    let title: String
    let value: String
    let systemImage: String
    let color: Color

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: systemImage)
                .font(.title)
                .foregroundStyle(color)
            Text(value)
                .font(.title)
                .fontWeight(.bold)
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

private struct BrewCard: View {
    let brew: Brew

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(brew.beanName)
                    .font(.headline)
                HStack(spacing: 8) {
                    Text(brew.brewMethod)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    HStack(spacing: 1) {
                        ForEach(1...5, id: \.self) { star in
                            Image(systemName: star <= brew.rating ? "star.fill" : "star")
                                .font(.system(size: 8))
                                .foregroundStyle(.yellow)
                        }
                    }
                }
            }
            Spacer()
            Text(brew.date, style: .relative)
                .font(.caption2)
                .foregroundStyle(.tertiary)
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
        .padding(.vertical, 8)
    }
}

private struct BeanCard: View {
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
        .padding(.vertical, 8)
    }
}
