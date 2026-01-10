import SwiftUI

struct ContentView: View {
    @State private var selectedTab: AppTab = .dashboard

    var body: some View {
        ZStack {
            Theme.background
                .ignoresSafeArea()

            VStack(spacing: 0) {
                TopNav(selectedTab: $selectedTab)
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        switch selectedTab {
                        case .dashboard:
                            DashboardView()
                        case .staff:
                            StaffRootView()
                        case .finances:
                            FinancesRootView()
                        case .settings:
                            SettingsRootView()
                        case .appointments:
                            ComingSoonView(title: "Appointments")
                        case .messages:
                            ComingSoonView(title: "Messages")
                        case .clients:
                            ComingSoonView(title: "Clients")
                        case .pos:
                            ComingSoonView(title: "POS")
                        case .inventory:
                            ComingSoonView(title: "Inventory")
                        case .reports:
                            ComingSoonView(title: "Reports")
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                }
            }
        }
        .font(.custom("Inter", size: 14))
        .foregroundColor(Theme.foreground)
    }
}

struct ComingSoonView: View {
    let title: String

    var body: some View {
        VStack(spacing: 12) {
            Text("Coming Soon: \(title)")
                .font(.custom("Inter", size: 20).weight(.semibold))
            Text("This section is not yet available in the playground.")
                .font(.custom("Inter", size: 12))
                .foregroundColor(Theme.mutedForeground)
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(Theme.card)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Theme.border, lineWidth: 1)
        )
        .cornerRadius(14)
    }
}
