import SwiftUI

struct FinancesRootView: View {
    @State private var selectedTab: FinancesSubTab = .dashboard

    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 10) {
                ForEach(FinancesSubTab.allCases) { tab in
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
            case .dashboard:
                FinancesDashboardView()
            case .expenses:
                ExpensesView()
            case .payments:
                PaymentsView()
            case .payroll:
                PayrollView()
            case .taxes:
                TaxesView()
            }
        }
    }
}
