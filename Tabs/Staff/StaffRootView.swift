import SwiftUI

struct StaffRootView: View {
    @State private var selectedTab: StaffSubTab = .staffList
    @State private var showProfile = false

    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Staff")
                        .font(.custom("Inter", size: 24).weight(.bold))
                    Text("Manage team members and performance")
                        .font(.custom("Inter", size: 12))
                        .foregroundColor(Theme.mutedForeground)
                }
                Spacer()
                Button(action: {}) {
                    HStack(spacing: 6) {
                        Image(systemName: "plus")
                            .font(.system(size: 12, weight: .bold))
                        Text("Add Staff Member")
                            .font(.custom("Inter", size: 12).weight(.semibold))
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(Theme.primary)
                    .foregroundColor(Theme.primaryForeground)
                    .cornerRadius(10)
                }
            }

            HStack(spacing: 10) {
                ForEach(StaffSubTab.allCases) { tab in
                    let isActive = tab == selectedTab
                    Button(action: {
                        selectedTab = tab
                        if tab != .staffList {
                            showProfile = false
                        }
                    }) {
                        Text(tab.rawValue)
                            .font(.custom("Inter", size: 12).weight(.semibold))
                            .foregroundColor(isActive ? Theme.primaryForeground : Theme.foreground)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(isActive ? Theme.primary : Theme.muted)
                            .cornerRadius(999)
                    }
                    .buttonStyle(.plain)
                }
                Spacer()
            }

            switch selectedTab {
            case .staffList:
                if showProfile {
                    StaffProfileView()
                } else {
                    StaffListView(onSelectProfile: {
                        showProfile = true
                    })
                }
            case .schedule:
                ComingSoonView(title: "Staff Schedule")
            case .payroll:
                ComingSoonView(title: "Staff Payroll")
            case .performance:
                ComingSoonView(title: "Staff Performance")
            }
        }
    }
}
