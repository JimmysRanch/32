import SwiftUI

struct TopNav: View {
    @Binding var selectedTab: AppTab

    var body: some View {
        HStack(spacing: 24) {
            ForEach(AppTab.allCases) { tab in
                Button(action: {
                    selectedTab = tab
                }) {
                    VStack(spacing: 6) {
                        Text(tab.rawValue)
                            .font(.custom("Inter", size: 13).weight(selectedTab == tab ? .semibold : .regular))
                            .foregroundColor(selectedTab == tab ? Theme.primary : Theme.mutedForeground)
                        Rectangle()
                            .fill(selectedTab == tab ? Theme.primary : Color.clear)
                            .frame(height: 2)
                    }
                }
                .buttonStyle(.plain)
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 14)
        .padding(.bottom, 8)
        .background(Theme.background)
        .overlay(
            Rectangle()
                .fill(Theme.border)
                .frame(height: 1),
            alignment: .bottom
        )
    }
}
