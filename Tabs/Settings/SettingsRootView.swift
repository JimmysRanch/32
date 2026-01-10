import SwiftUI

struct SettingsRootView: View {
    @State private var selectedTab: SettingsSubTab = .staff

    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 10) {
                ForEach(SettingsSubTab.allCases) { tab in
                    let isActive = tab == selectedTab
                    Button(action: {
                        selectedTab = tab
                    }) {
                        Text(tab.rawValue)
                            .font(.custom("Inter", size: 12).weight(.semibold))
                            .foregroundColor(isActive ? Theme.primaryForeground : Theme.foreground)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 14)
                            .background(isActive ? Theme.primary : Theme.muted)
                            .cornerRadius(8)
                    }
                    .buttonStyle(.plain)
                }
                Spacer()
            }

            switch selectedTab {
            case .staff:
                SettingsStaffView()
            case .business:
                SettingsBusinessView()
            case .services:
                SettingsServicesView()
            case .notifications:
                SettingsNotificationsView()
            case .pos:
                SettingsPOSView()
            }
        }
    }
}
