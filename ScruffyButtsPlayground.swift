import SwiftUI

struct OKLCHColor {
    let l: Double
    let c: Double
    let h: Double

    func toColor() -> Color {
        let hr = h * Double.pi / 180.0
        let a = c * cos(hr)
        let bAxis = c * sin(hr)

        let l_ = l + 0.3963377774 * a + 0.2158037573 * bAxis
        let m_ = l - 0.1055613458 * a - 0.0638541728 * bAxis
        let s_ = l - 0.0894841775 * a - 1.2914855480 * bAxis

        let l3 = l_ * l_ * l_
        let m3 = m_ * m_ * m_
        let s3 = s_ * s_ * s_

        let rLinear = 4.0767416621 * l3 - 3.3077115913 * m3 + 0.2309699292 * s3
        let gLinear = -1.2684380046 * l3 + 2.6097574011 * m3 - 0.3413193965 * s3
        let bLinear = -0.0041960863 * l3 - 0.7034186147 * m3 + 1.7076147010 * s3

        func compand(_ value: Double) -> Double {
            if value <= 0.0031308 {
                return 12.92 * value
            }
            return 1.055 * pow(value, 1.0 / 2.4) - 0.055
        }

        let r = max(0, min(1, compand(rLinear)))
        let g = max(0, min(1, compand(gLinear)))
        let b = max(0, min(1, compand(bLinear)))

        return Color(red: r, green: g, blue: b)
    }
}

enum Theme {
    static let background = OKLCHColor(l: 0.18, c: 0.04, h: 250).toColor()
    static let foreground = OKLCHColor(l: 0.98, c: 0.0, h: 0).toColor()
    static let card = OKLCHColor(l: 0.22, c: 0.04, h: 250).toColor()
    static let primary = OKLCHColor(l: 0.75, c: 0.15, h: 195).toColor()
    static let primaryForeground = OKLCHColor(l: 0.18, c: 0.04, h: 250).toColor()
    static let secondary = OKLCHColor(l: 0.30, c: 0.05, h: 250).toColor()
    static let muted = OKLCHColor(l: 0.25, c: 0.04, h: 250).toColor()
    static let mutedForeground = OKLCHColor(l: 0.65, c: 0.02, h: 250).toColor()
    static let border = OKLCHColor(l: 0.35, c: 0.05, h: 250).toColor()
    static let destructive = OKLCHColor(l: 0.55, c: 0.22, h: 25).toColor()
    static let success = OKLCHColor(l: 0.74, c: 0.18, h: 145).toColor()
    static let warning = OKLCHColor(l: 0.72, c: 0.18, h: 70).toColor()
    static let alert = OKLCHColor(l: 0.72, c: 0.14, h: 30).toColor()
    static let magenta = OKLCHColor(l: 0.68, c: 0.22, h: 320).toColor()
}

struct TabItem: Identifiable {
    let id = UUID()
    let title: String
    let isActive: Bool
}

struct AppointmentSummaryItem: Identifiable {
    let id = UUID()
    let label: String
    let value: String
    let color: Color
}

struct IssueItem: Identifiable {
    let id = UUID()
    let label: String
    let count: String
    let tint: Color
}

struct ActivityItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let time: String
    let icon: String
    let iconTint: Color
}

struct GroomerWorkload: Identifiable {
    let id = UUID()
    let name: String
    let appointments: String
    let minutes: String
    let progress: Double
    let tint: Color
}

struct GroomerAverage: Identifiable {
    let id = UUID()
    let name: String
    let dogsPerDay: String
    let revenue: String
    let tint: Color
}

struct ExpenseItem: Identifiable {
    let id = UUID()
    let title: String
    let amount: String
    let percent: String
    let tint: Color
}

struct BookedMetric: Identifiable {
    let id = UUID()
    let label: String
    let value: String
    let progress: Double
}

struct ClientMetric: Identifiable {
    let id = UUID()
    let title: String
    let value: String
}

struct ContentView: View {
    private let tabs: [TabItem] = [
        TabItem(title: "Dashboard", isActive: true),
        TabItem(title: "Appointments", isActive: false),
        TabItem(title: "Messages", isActive: false),
        TabItem(title: "Clients", isActive: false),
        TabItem(title: "Staff", isActive: false),
        TabItem(title: "POS", isActive: false),
        TabItem(title: "Inventory", isActive: false),
        TabItem(title: "Finances", isActive: false),
        TabItem(title: "Reports", isActive: false),
        TabItem(title: "Settings", isActive: false)
    ]

    private let appointmentSummary: [AppointmentSummaryItem] = [
        AppointmentSummaryItem(label: "Scheduled", value: "18", color: Theme.primary),
        AppointmentSummaryItem(label: "Completed", value: "12", color: Theme.success),
        AppointmentSummaryItem(label: "Canceled", value: "2", color: Theme.destructive),
        AppointmentSummaryItem(label: "No-Shows", value: "1", color: Theme.warning),
        AppointmentSummaryItem(label: "Late", value: "3", color: Theme.alert)
    ]

    private let issues: [IssueItem] = [
        IssueItem(label: "Late arrivals", count: "3", tint: Theme.alert),
        IssueItem(label: "No-shows", count: "1", tint: Theme.warning),
        IssueItem(label: "Canceled", count: "2", tint: Theme.destructive)
    ]

    private let activities: [ActivityItem] = [
        ActivityItem(title: "New appointment booked for Max", subtitle: "John Smith", time: "2 minutes ago", icon: "calendar", iconTint: Theme.primary),
        ActivityItem(title: "Appointment canceled for Luna", subtitle: "Sarah Williams", time: "15 minutes ago", icon: "xmark.circle", iconTint: Theme.destructive),
        ActivityItem(title: "New appointment booked for Charlie", subtitle: "Mike Johnson", time: "1 hour ago", icon: "calendar", iconTint: Theme.primary),
        ActivityItem(title: "Service price updated: Full Groom", subtitle: "Pricing", time: "3 hours ago", icon: "dollarsign.circle", iconTint: Theme.warning)
    ]

    private let workloads: [GroomerWorkload] = [
        GroomerWorkload(name: "Sarah Johnson", appointments: "8 appointments", minutes: "456/480 min", progress: 0.95, tint: Theme.magenta),
        GroomerWorkload(name: "Mike Chen", appointments: "6 appointments", minutes: "374/480 min", progress: 0.78, tint: Theme.primary),
        GroomerWorkload(name: "Emily Rodriguez", appointments: "7 appointments", minutes: "422/480 min", progress: 0.88, tint: Theme.success)
    ]

    private let averages: [GroomerAverage] = [
        GroomerAverage(name: "Sarah Johnson", dogsPerDay: "8", revenue: "$646", tint: Theme.magenta),
        GroomerAverage(name: "Mike Chen", dogsPerDay: "6", revenue: "$398", tint: Theme.primary),
        GroomerAverage(name: "Emily Rodriguez", dogsPerDay: "7", revenue: "$524", tint: Theme.success)
    ]

    private let expenses: [ExpenseItem] = [
        ExpenseItem(title: "Payroll", amount: "$4,200", percent: "42.0%", tint: Theme.primary),
        ExpenseItem(title: "Rent", amount: "$2,500", percent: "25.0%", tint: Theme.magenta),
        ExpenseItem(title: "Supplies", amount: "$1,850", percent: "18.5%", tint: Theme.success),
        ExpenseItem(title: "Marketing", amount: "$800", percent: "8.0%", tint: Theme.destructive),
        ExpenseItem(title: "Utilities", amount: "$650", percent: "6.5%", tint: Theme.warning)
    ]

    private let bookedMetrics: [BookedMetric] = [
        BookedMetric(label: "Day", value: "82%", progress: 0.82),
        BookedMetric(label: "Week", value: "78%", progress: 0.78),
        BookedMetric(label: "Month", value: "73%", progress: 0.73)
    ]

    private let clientMetrics: [ClientMetric] = [
        ClientMetric(title: "Total Clients", value: "156"),
        ClientMetric(title: "New This Month", value: "12"),
        ClientMetric(title: "Repeat Rate", value: "78%"),
        ClientMetric(title: "Avg Rebooking", value: "28")
    ]

    var body: some View {
        GeometryReader { geometry in
            let spacing: CGFloat = 10
            let horizontalPadding: CGFloat = 12
            let verticalPadding: CGFloat = 12
            let topNavHeight: CGFloat = 44
            let availableHeight = geometry.size.height - topNavHeight - (verticalPadding * 2) - (spacing * 2)
            let rowHeight = max(120, availableHeight / 3)

            ZStack {
                Theme.background
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    TopNav(tabs: tabs)
                        .frame(height: topNavHeight)

                    Grid(horizontalSpacing: spacing, verticalSpacing: spacing) {
                        GridRow {
                            AppointmentSummaryCard(items: appointmentSummary, progress: 12, total: 18)
                                .frame(height: rowHeight)
                            BookedRingCard(progress: 0.82)
                                .frame(height: rowHeight)
                            ExpectedRevenueCard()
                                .frame(height: rowHeight)
                            IssuesCard(items: issues)
                                .frame(height: rowHeight)
                        }
                        GridRow {
                            RecentActivityCard(items: activities)
                                .gridCellColumns(2)
                                .frame(height: rowHeight)
                            GroomerWorkloadCard(workloads: workloads)
                                .frame(height: rowHeight)
                            GroomerAverageCard(averages: averages)
                                .frame(height: rowHeight)
                        }
                        GridRow {
                            ExpensesCard(items: expenses)
                                .frame(height: rowHeight)
                            CompletedAppointmentsCard()
                                .frame(height: rowHeight)
                            BookedCapacityCard(items: bookedMetrics)
                                .frame(height: rowHeight)
                            ClientsCard(items: clientMetrics)
                                .frame(height: rowHeight)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal, horizontalPadding)
                    .padding(.vertical, verticalPadding)
                    .background(Theme.background)
                    .gridCellUnsizedAxes(.horizontal)
                    .environment(\.layoutDirection, .leftToRight)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .font(.custom("Inter", size: 14))
        .foregroundColor(Theme.foreground)
    }
}

struct TopNav: View {
    let tabs: [TabItem]

    var body: some View {
        HStack(spacing: 24) {
            ForEach(tabs) { tab in
                VStack(spacing: 6) {
                    Text(tab.title)
                        .font(.custom("Inter", size: 13).weight(tab.isActive ? .semibold : .regular))
                        .foregroundColor(tab.isActive ? Theme.primary : Theme.mutedForeground)
                    Rectangle()
                        .fill(tab.isActive ? Theme.primary : Color.clear)
                        .frame(height: 2)
                }
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

struct DashboardCardContainer<Content: View>: View {
    let title: String
    let isUppercase: Bool
    let content: Content

    init(title: String, isUppercase: Bool = false, @ViewBuilder content: () -> Content) {
        self.title = title
        self.isUppercase = isUppercase
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(isUppercase ? title.uppercased() : title)
                .font(.custom("Inter", size: isUppercase ? 11 : 14).weight(.semibold))
                .foregroundColor(isUppercase ? Theme.mutedForeground : Theme.foreground)
            content
        }
        .padding(12)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Theme.card)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Theme.border, lineWidth: 1)
        )
        .cornerRadius(12)
        .clipped()
    }
}

struct AppointmentSummaryCard: View {
    let items: [AppointmentSummaryItem]
    let progress: Int
    let total: Int

    var body: some View {
        DashboardCardContainer(title: "Appointments Today", isUppercase: true) {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(items) { item in
                    HStack(spacing: 8) {
                        Circle()
                            .fill(item.color)
                            .frame(width: 6, height: 6)
                        Text(item.label)
                            .font(.custom("Inter", size: 12))
                            .foregroundColor(Theme.mutedForeground)
                        Spacer()
                        Text(item.value)
                            .font(.custom("Inter", size: 12).weight(.semibold))
                    }
                }
                Text("Day Progress")
                    .font(.custom("Inter", size: 11))
                    .foregroundColor(Theme.mutedForeground)
                ProgressBar(progress: Double(progress) / Double(total), tint: Theme.primary)
                HStack {
                    Spacer()
                    Text("\(progress) / \(total)")
                        .font(.custom("Inter", size: 11))
                        .foregroundColor(Theme.mutedForeground)
                }
            }
            .frame(maxHeight: .infinity, alignment: .topLeading)
        }
    }
}

struct BookedRingCard: View {
    let progress: Double

    var body: some View {
        DashboardCardContainer(title: "Booked", isUppercase: true) {
            GeometryReader { geometry in
                let ringSize = min(geometry.size.width, geometry.size.height) * 0.6
                VStack(alignment: .center, spacing: 6) {
                RingProgress(progress: progress, size: max(80, ringSize))
                    Text("Today")
                        .font(.custom("Inter", size: 12))
                        .foregroundColor(Theme.mutedForeground)
                    Text("Target 90%")
                        .font(.custom("Inter", size: 11))
                        .foregroundColor(Theme.mutedForeground)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxHeight: .infinity)
        }
    }
}

struct RingProgress: View {
    let progress: Double
    let size: CGFloat

    var body: some View {
        ZStack {
            Circle()
                .stroke(Theme.muted, lineWidth: max(6, size * 0.08))
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [Theme.success, Theme.primary, Theme.warning]),
                        center: .center
                    ),
                    style: StrokeStyle(lineWidth: max(6, size * 0.08), lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
            Text("\(Int(progress * 100))%")
                .font(.custom("Inter", size: max(16, size * 0.25)).weight(.bold))
        }
        .frame(width: size, height: size)
    }
}

struct ExpectedRevenueCard: View {
    var body: some View {
        DashboardCardContainer(title: "Expected Revenue", isUppercase: true) {
            VStack(alignment: .leading, spacing: 12) {
                Text("$1450")
                    .font(.custom("Inter", size: 22).weight(.bold))
                Text("Total Revenue Today")
                    .font(.custom("Inter", size: 12))
                    .foregroundColor(Theme.mutedForeground)
                DividerLine()
                HStack {
                    Text("Profit After Commissions")
                        .font(.custom("Inter", size: 12))
                        .foregroundColor(Theme.mutedForeground)
                    Spacer()
                    Text("$1160")
                        .font(.custom("Inter", size: 12).weight(.semibold))
                        .foregroundColor(Theme.success)
                }
                HStack {
                    Text("Tips (excluded)")
                        .font(.custom("Inter", size: 12))
                        .foregroundColor(Theme.mutedForeground)
                    Spacer()
                    Text("$145")
                        .font(.custom("Inter", size: 12).weight(.semibold))
                }
                HStack {
                    Text("Commission estimate")
                        .font(.custom("Inter", size: 12))
                        .foregroundColor(Theme.mutedForeground)
                    Spacer()
                    Text("$290")
                        .font(.custom("Inter", size: 12).weight(.semibold))
                }
            }
            .frame(maxHeight: .infinity, alignment: .topLeading)
        }
    }
}

struct IssuesCard: View {
    let items: [IssueItem]

    var body: some View {
        DashboardCardContainer(title: "Issues", isUppercase: true) {
            VStack(spacing: 10) {
                ForEach(items) { item in
                    HStack {
                        Circle()
                            .fill(item.tint)
                            .frame(width: 8, height: 8)
                        Text(item.label)
                            .font(.custom("Inter", size: 12))
                        Spacer()
                        Text(item.count)
                            .font(.custom("Inter", size: 12).weight(.semibold))
                    }
                    .padding(10)
                    .background(item.tint.opacity(0.15))
                    .cornerRadius(10)
                }
            }
            .frame(maxHeight: .infinity, alignment: .topLeading)
        }
    }
}

struct RecentActivityCard: View {
    let items: [ActivityItem]

    var body: some View {
        DashboardCardContainer(title: "Recent Activity") {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 8) {
                    ForEach(items) { item in
                        HStack(spacing: 10) {
                            Image(systemName: item.icon)
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(item.iconTint)
                                .frame(width: 24, height: 24)
                                .background(Theme.muted)
                                .cornerRadius(6)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.title)
                                    .font(.custom("Inter", size: 12).weight(.semibold))
                                Text(item.subtitle)
                                    .font(.custom("Inter", size: 11))
                                    .foregroundColor(Theme.mutedForeground)
                            }
                            Spacer()
                            Text(item.time)
                                .font(.custom("Inter", size: 11))
                                .foregroundColor(Theme.mutedForeground)
                        }
                        .padding(8)
                        .background(Theme.muted.opacity(0.6))
                        .cornerRadius(10)
                    }
                }
            }
            .frame(maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity)
    }
}

struct GroomerWorkloadCard: View {
    let workloads: [GroomerWorkload]

    var body: some View {
        DashboardCardContainer(title: "Groomers Workload") {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(workloads) { workload in
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text(workload.name)
                                .font(.custom("Inter", size: 12).weight(.semibold))
                            Spacer()
                            Text("\(Int(workload.progress * 100))%")
                                .font(.custom("Inter", size: 12).weight(.semibold))
                                .foregroundColor(workload.tint)
                        }
                        Text("\(workload.appointments) • \(workload.minutes)")
                            .font(.custom("Inter", size: 11))
                            .foregroundColor(Theme.mutedForeground)
                        ProgressBar(progress: workload.progress, tint: workload.tint)
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .topLeading)
        }
    }
}

struct GroomerAverageCard: View {
    let averages: [GroomerAverage]

    var body: some View {
        DashboardCardContainer(title: "Groomer Avg") {
            VStack(alignment: .leading, spacing: 12) {
                Text("Daily Metrics")
                    .font(.custom("Inter", size: 12))
                    .foregroundColor(Theme.mutedForeground)
                ForEach(averages) { average in
                    HStack {
                        Circle()
                            .fill(average.tint)
                            .frame(width: 6, height: 6)
                        Text(average.name)
                            .font(.custom("Inter", size: 12).weight(.semibold))
                        Spacer()
                        VStack(alignment: .trailing, spacing: 2) {
                            Text(average.dogsPerDay)
                                .font(.custom("Inter", size: 12).weight(.semibold))
                            Text("dogs/day")
                                .font(.custom("Inter", size: 10))
                                .foregroundColor(Theme.mutedForeground)
                        }
                        VStack(alignment: .trailing, spacing: 2) {
                            Text(average.revenue)
                                .font(.custom("Inter", size: 12).weight(.semibold))
                                .foregroundColor(Theme.primary)
                            Text("revenue/day")
                                .font(.custom("Inter", size: 10))
                                .foregroundColor(Theme.mutedForeground)
                        }
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .topLeading)
        }
    }
}

struct ExpensesCard: View {
    let items: [ExpenseItem]

    var body: some View {
        DashboardCardContainer(title: "Expenses") {
            Text("January 2026")
                .font(.custom("Inter", size: 11))
                .foregroundColor(Theme.mutedForeground)
            VStack(spacing: 10) {
                ForEach(items) { item in
                    HStack {
                        Circle()
                            .fill(item.tint)
                            .frame(width: 6, height: 6)
                        Text(item.title)
                            .font(.custom("Inter", size: 12))
                        Spacer()
                        Text(item.amount)
                            .font(.custom("Inter", size: 12).weight(.semibold))
                        Text(item.percent)
                            .font(.custom("Inter", size: 11))
                            .foregroundColor(Theme.mutedForeground)
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .topLeading)
        }
    }
}

struct CompletedAppointmentsCard: View {
    var body: some View {
        DashboardCardContainer(title: "Completed Appointments") {
            Text("Appointment History")
                .font(.custom("Inter", size: 11))
                .foregroundColor(Theme.mutedForeground)
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    MetricBlock(title: "Day", value: "12")
                    Spacer()
                    MetricBlock(title: "Week", value: "68")
                }
                HStack {
                    MetricBlock(title: "Month", value: "285")
                    Spacer()
                    MetricBlock(title: "Lifetime", value: "3,842", accent: Theme.primary)
                }
            }
            .frame(maxHeight: .infinity, alignment: .topLeading)
        }
    }
}

struct BookedCapacityCard: View {
    let items: [BookedMetric]

    var body: some View {
        DashboardCardContainer(title: "Booked %") {
            Text("Store Capacity")
                .font(.custom("Inter", size: 11))
                .foregroundColor(Theme.mutedForeground)
            VStack(spacing: 12) {
                ForEach(items) { item in
                    HStack {
                        Text(item.label)
                            .font(.custom("Inter", size: 12))
                            .foregroundColor(Theme.mutedForeground)
                        Spacer()
                        Text(item.value)
                            .font(.custom("Inter", size: 12).weight(.semibold))
                    }
                    ProgressBar(progress: item.progress, tint: Theme.primary)
                }
            }
            .frame(maxHeight: .infinity, alignment: .topLeading)
        }
    }
}

struct ClientsCard: View {
    let items: [ClientMetric]

    var body: some View {
        DashboardCardContainer(title: "Clients") {
            Text("Client Metrics")
                .font(.custom("Inter", size: 11))
                .foregroundColor(Theme.mutedForeground)
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(items) { item in
                    MetricBlock(title: item.title, value: item.value)
                }
            }
            .frame(maxHeight: .infinity, alignment: .topLeading)
        }
    }
}

struct MetricBlock: View {
    let title: String
    let value: String
    var accent: Color = Theme.foreground

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.custom("Inter", size: 11))
                .foregroundColor(Theme.mutedForeground)
            Text(value)
                .font(.custom("Inter", size: 18).weight(.bold))
                .foregroundColor(accent)
        }
    }
}

struct ProgressBar: View {
    let progress: Double
    let tint: Color

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Theme.muted)
                RoundedRectangle(cornerRadius: 6)
                    .fill(tint)
                    .frame(width: geometry.size.width * progress)
            }
        }
        .frame(height: 8)
    }
}

struct DividerLine: View {
    var body: some View {
        Rectangle()
            .fill(Theme.border)
            .frame(height: 1)
    }
}
