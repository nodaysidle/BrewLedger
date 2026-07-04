import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "house.fill")
                }

            BrewListView()
                .tabItem {
                    Label("Brews", systemImage: "mug.fill")
                }

            BeanInventoryView()
                .tabItem {
                    Label("Beans", systemImage: "leaf.fill")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
}
