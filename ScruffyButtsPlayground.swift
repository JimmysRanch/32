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
}

struct DashboardCard: Identifiable {
    let id = UUID()
    let title: String
    let value: String
    let caption: String
    let trend: String
}

struct Appointment: Identifiable {
    let id = UUID()
    let time: String
    let pet: String
    let service: String
    let groomer: String
    let status: String
}

struct ContentView: View {
    private let cards: [DashboardCard] = [
        DashboardCard(title: "Today\u{2019}s Appointments", value: "18", caption: "3 remaining", trend: "+12%"),
        DashboardCard(title: "Active Clients", value: "142", caption: "+4 this week", trend: "+6%"),
        DashboardCard(title: "Pets in Care", value: "27", caption: "8 checkouts", trend: "+2%"),
        DashboardCard(title: "Revenue (MTD)", value: "$24.8k", caption: "Goal 72%", trend: "+9%"),
        DashboardCard(title: "Groomer Utilization", value: "86%", caption: "4 groomers active", trend: "+3%"),
        DashboardCard(title: "Retail Sales", value: "$3.2k", caption: "Top: Shampoos", trend: "+5%"),
        DashboardCard(title: "Inventory Alerts", value: "6", caption: "2 critical", trend: "Low"),
        DashboardCard(title: "Upcoming Reviews", value: "11", caption: "This week", trend: "New"),
        DashboardCard(title: "Pending Payments", value: "4", caption: "$520 outstanding", trend: "Due"),
        DashboardCard(title: "Staff on Shift", value: "7", caption: "2 trainees", trend: "On"),
        DashboardCard(title: "Average Ticket", value: "$78", caption: "Last 30 days", trend: "+4%")
    ]

    private let appointments: [Appointment] = [
        Appointment(time: "09:00", pet: "Bella (Golden)", service: "Full Groom", groomer: "Maya", status: "Checked In"),
        Appointment(time: "10:30", pet: "Dexter (Poodle)", service: "Bath & Trim", groomer: "Aria", status: "In Progress"),
        Appointment(time: "12:00", pet: "Loki (Husky)", service: "De-shed", groomer: "Jules", status: "Ready"),
        Appointment(time: "13:30", pet: "Coco (Shih Tzu)", service: "Puppy Intro", groomer: "Maya", status: "Pending"),
        Appointment(time: "15:00", pet: "Rex (Shepherd)", service: "Nail & Trim", groomer: "Aria", status: "Confirmed")
    ]

    var body: some View {
        ZStack {
            Theme.background
                .ignoresSafeArea()

            VStack(spacing: 12) {
                TopNav()
                ScrollView {
                    VStack(spacing: 12) {
                        DashboardHeader()
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 3), spacing: 12) {
                            ForEach(cards) { card in
                                StatCard(card: card)
                            }
                        }

                        HStack(alignment: .top, spacing: 12) {
                            AppointmentList(appointments: appointments)
                            VStack(spacing: 12) {
                                QuickActions()
                                RevenueSnapshot()
                            }
                            .frame(maxWidth: 320)
                        }
                    }
                    .padding(16)
                }
            }
        }
        .font(.custom("Inter", size: 14))
        .foregroundColor(Theme.foreground)
    }
}

struct TopNav: View {
    var body: some View {
        HStack(spacing: 16) {
            HStack(spacing: 10) {
                Circle()
                    .fill(Theme.primary)
                    .frame(width: 28, height: 28)
                    .overlay(Text("SB").font(.custom("Inter", size: 12)).bold().foregroundColor(Theme.primaryForeground))
                VStack(alignment: .leading, spacing: 2) {
                    Text("Scruffy Butts")
                        .font(.custom("Inter", size: 16).weight(.semibold))
                    Text("Dog Grooming Management")
                        .font(.custom("Inter", size: 12))
                        .foregroundColor(Theme.mutedForeground)
                }
            }
            Spacer()
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Theme.mutedForeground)
                Text("Search clients, pets, appointments")
                    .foregroundColor(Theme.mutedForeground)
                    .font(.custom("Inter", size: 12))
                Spacer()
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Theme.muted)
            .cornerRadius(12)

            HStack(spacing: 12) {
                Pill(text: "Notifications", accent: Theme.secondary)
                Circle()
                    .fill(Theme.secondary)
                    .frame(width: 34, height: 34)
                    .overlay(Text("AM").font(.custom("Inter", size: 12).weight(.semibold)))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Theme.card)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Theme.border, lineWidth: 1)
        )
    }
}

struct DashboardHeader: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("Dashboard")
                    .font(.custom("Inter", size: 24).weight(.bold))
                Text("Monday, Nov 18 \u{2022} 18 appointments, 7 groomers on shift")
                    .foregroundColor(Theme.mutedForeground)
                    .font(.custom("Inter", size: 13))
            }
            Spacer()
            Button(action: {}) {
                Text("New Appointment")
                    .font(.custom("Inter", size: 14).weight(.medium))
                    .foregroundColor(Theme.primaryForeground)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Theme.primary)
                    .cornerRadius(12)
            }
            .buttonStyle(.plain)
        }
    }
}

struct StatCard: View {
    let card: DashboardCard

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(card.title)
                    .font(.custom("Inter", size: 14).weight(.semibold))
                Spacer()
                Pill(text: card.trend, accent: Theme.secondary)
            }
            Text(card.value)
                .font(.custom("Inter", size: 24).weight(.bold))
            Text(card.caption)
                .font(.custom("Inter", size: 12))
                .foregroundColor(Theme.mutedForeground)
        }
        .padding(16)
        .frame(maxWidth: .infinity, minHeight: 120, alignment: .leading)
        .background(Theme.card)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Theme.border, lineWidth: 1)
        )
        .cornerRadius(12)
    }
}

struct AppointmentList: View {
    let appointments: [Appointment]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Today\u{2019}s Appointments")
                    .font(.custom("Inter", size: 18).weight(.semibold))
                Spacer()
                Pill(text: "View All", accent: Theme.secondary)
            }
            ForEach(appointments) { appointment in
                AppointmentRow(appointment: appointment)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Theme.card)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Theme.border, lineWidth: 1)
        )
        .cornerRadius(12)
    }
}

struct AppointmentRow: View {
    let appointment: Appointment

    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(appointment.time)
                    .font(.custom("Inter", size: 14).weight(.semibold))
                Text(appointment.service)
                    .font(.custom("Inter", size: 12))
                    .foregroundColor(Theme.mutedForeground)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(appointment.pet)
                    .font(.custom("Inter", size: 14).weight(.medium))
                Text("Groomer: \(appointment.groomer)")
                    .font(.custom("Inter", size: 12))
                    .foregroundColor(Theme.mutedForeground)
            }
            Spacer()
            Pill(text: appointment.status, accent: statusColor(appointment.status))
        }
        .padding(12)
        .background(Theme.muted)
        .cornerRadius(12)
    }

    private func statusColor(_ status: String) -> Color {
        switch status {
        case "Ready":
            return Theme.primary
        case "In Progress":
            return Theme.secondary
        case "Checked In":
            return Theme.primary
        case "Pending":
            return Theme.destructive
        default:
            return Theme.secondary
        }
    }
}

struct QuickActions: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Quick Actions")
                .font(.custom("Inter", size: 18).weight(.semibold))
            VStack(spacing: 10) {
                ActionRow(title: "Check In Walk-in", subtitle: "Open appointment form", accent: Theme.primary)
                ActionRow(title: "New Client", subtitle: "Add pet profile", accent: Theme.secondary)
                ActionRow(title: "Open POS", subtitle: "Process retail sale", accent: Theme.secondary)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Theme.card)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Theme.border, lineWidth: 1)
        )
        .cornerRadius(12)
    }
}

struct ActionRow: View {
    let title: String
    let subtitle: String
    let accent: Color

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(accent)
                .frame(width: 32, height: 32)
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.custom("Inter", size: 14).weight(.semibold))
                Text(subtitle)
                    .font(.custom("Inter", size: 12))
                    .foregroundColor(Theme.mutedForeground)
            }
            Spacer()
        }
        .padding(12)
        .background(Theme.muted)
        .cornerRadius(12)
    }
}

struct RevenueSnapshot: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Revenue Snapshot")
                    .font(.custom("Inter", size: 18).weight(.semibold))
                Spacer()
                Pill(text: "This Month", accent: Theme.secondary)
            }
            VStack(alignment: .leading, spacing: 12) {
                Text("$24,812")
                    .font(.custom("Inter", size: 24).weight(.bold))
                Text("Up 9% from last month")
                    .font(.custom("Inter", size: 12))
                    .foregroundColor(Theme.mutedForeground)
                ProgressBar(progress: 0.72)
                HStack {
                    Text("Goal 72%")
                        .font(.custom("Inter", size: 12))
                        .foregroundColor(Theme.mutedForeground)
                    Spacer()
                    Text("$34,500")
                        .font(.custom("Inter", size: 12).weight(.semibold))
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Theme.card)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Theme.border, lineWidth: 1)
        )
        .cornerRadius(12)
    }
}

struct ProgressBar: View {
    let progress: Double

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Theme.muted)
                RoundedRectangle(cornerRadius: 6)
                    .fill(Theme.primary)
                    .frame(width: geometry.size.width * progress)
            }
        }
        .frame(height: 8)
    }
}

struct Pill: View {
    let text: String
    let accent: Color

    var body: some View {
        Text(text)
            .font(.custom("Inter", size: 11).weight(.medium))
            .foregroundColor(Theme.primaryForeground)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(accent)
            .cornerRadius(999)
    }
}
