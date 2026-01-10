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
    static let success = OKLCHColor(l: 0.74, c: 0.18, h: 145).toColor()
    static let warning = OKLCHColor(l: 0.72, c: 0.18, h: 70).toColor()
}

enum StaffScreen: String, CaseIterable {
    case list = "Staff List"
    case profile = "Staff Profile"
}

struct TabItem: Identifiable {
    let id = UUID()
    let title: String
    let isActive: Bool
}

struct StaffMember: Identifiable {
    let id = UUID()
    let name: String
    let role: String
    let status: String
    let email: String
    let phone: String
    let tags: [String]
    let rate: String
    let appointments: String
    let hired: String
    let statusTint: Color
}

struct StaffMetric: Identifiable {
    let id = UUID()
    let title: String
    let value: String
    let subtitle: String?
}

struct AppointmentRow: Identifiable {
    let id = UUID()
    let clientName: String
    let petName: String
    let status: String
    let statusTint: Color
    let service: String
    let date: String
    let time: String
    let duration: String
    let rating: String?
    let amount: String?
}

struct ContentView: View {
    @State private var screen: StaffScreen = .list

    private let tabs: [TabItem] = [
        TabItem(title: "Dashboard", isActive: false),
        TabItem(title: "Appointments", isActive: false),
        TabItem(title: "Messages", isActive: false),
        TabItem(title: "Clients", isActive: false),
        TabItem(title: "Staff", isActive: true),
        TabItem(title: "POS", isActive: false),
        TabItem(title: "Inventory", isActive: false),
        TabItem(title: "Finances", isActive: false),
        TabItem(title: "Reports", isActive: false),
        TabItem(title: "Settings", isActive: false)
    ]

    var body: some View {
        ZStack {
            Theme.background
                .ignoresSafeArea()

            VStack(spacing: 0) {
                TopNav(tabs: tabs)
                Picker("Screen", selection: $screen) {
                    ForEach(StaffScreen.allCases, id: \.self) { item in
                        Text(item.rawValue)
                            .tag(item)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 8)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        if screen == .list {
                            StaffListView()
                        } else {
                            StaffProfileView()
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

struct SectionHeader: View {
    let title: String

    var body: some View {
        Text(title.uppercased())
            .font(.custom("Inter", size: 11).weight(.semibold))
            .foregroundColor(Theme.mutedForeground)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct PillBadge: View {
    let text: String
    let tint: Color
    let textColor: Color

    init(text: String, tint: Color, textColor: Color = Theme.primaryForeground) {
        self.text = text
        self.tint = tint
        self.textColor = textColor
    }

    var body: some View {
        Text(text)
            .font(.custom("Inter", size: 11).weight(.semibold))
            .foregroundColor(textColor)
            .padding(.vertical, 4)
            .padding(.horizontal, 10)
            .background(tint)
            .cornerRadius(999)
    }
}

struct OutlinePill: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.custom("Inter", size: 11).weight(.medium))
            .foregroundColor(Theme.mutedForeground)
            .padding(.vertical, 4)
            .padding(.horizontal, 10)
            .background(
                RoundedRectangle(cornerRadius: 999)
                    .stroke(Theme.border, lineWidth: 1)
            )
    }
}

struct CardContainer<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            content
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(Theme.card)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Theme.border, lineWidth: 1)
        )
        .cornerRadius(14)
    }
}

struct StaffListView: View {
    private let listTabs = ["Staff List", "Schedule", "Payroll", "Performance"]

    private let staffMembers: [StaffMember] = [
        StaffMember(name: "Sarah Johnson", role: "Senior Groomer", status: "Active", email: "sarah.j@pawhub.com", phone: "(555) 123-4567", tags: ["Large Breeds", "Show Cuts", "Hand Stripping"], rate: "$35/hr", appointments: "324", hired: "Mar 15, 2022", statusTint: Theme.primary),
        StaffMember(name: "Mike Torres", role: "Groomer", status: "Active", email: "mike.t@pawhub.com", phone: "(555) 234-5678", tags: ["Anxious Dogs", "Creative Styling", "Nail Care"], rate: "$28/hr", appointments: "256", hired: "Aug 20, 2022", statusTint: Theme.primary),
        StaffMember(name: "Emma Roberts", role: "Spa Specialist", status: "Active", email: "emma.r@pawhub.com", phone: "(555) 345-6789", tags: ["Spa Treatments", "Small Breeds", "Facials"], rate: "$32/hr", appointments: "198", hired: "Jan 10, 2023", statusTint: Theme.primary),
        StaffMember(name: "Carlos Martinez", role: "Bather", status: "Active", email: "carlos.m@pawhub.com", phone: "(555) 456-7890", tags: ["De-shedding", "Quick Service", "Puppy Care"], rate: "$22/hr", appointments: "412", hired: "May 5, 2023", statusTint: Theme.primary),
        StaffMember(name: "Lisa Chen", role: "Groomer", status: "On Leave", email: "lisa.c@pawhub.com", phone: "(555) 567-8901", tags: ["Poodle Cuts", "Color & Styling", "Competition Prep"], rate: "$30/hr", appointments: "187", hired: "Nov 12, 2023", statusTint: Theme.secondary)
    ]

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
                ForEach(listTabs, id: \.self) { tab in
                    let isActive = tab == "Staff List"
                    Text(tab)
                        .font(.custom("Inter", size: 12).weight(.semibold))
                        .foregroundColor(isActive ? Theme.primaryForeground : Theme.foreground)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(isActive ? Theme.primary : Theme.muted)
                        .cornerRadius(999)
                }
                Spacer()
            }

            VStack(spacing: 14) {
                ForEach(staffMembers) { staff in
                    CardContainer {
                        HStack(alignment: .top, spacing: 16) {
                            VStack(alignment: .leading, spacing: 10) {
                                HStack(spacing: 10) {
                                    Text(staff.name)
                                        .font(.custom("Inter", size: 16).weight(.semibold))
                                    OutlinePill(text: staff.role)
                                    PillBadge(text: staff.status, tint: staff.statusTint)
                                }
                                HStack(spacing: 14) {
                                    Label(staff.email, systemImage: "envelope")
                                    Label(staff.phone, systemImage: "phone")
                                }
                                .font(.custom("Inter", size: 11))
                                .foregroundColor(Theme.mutedForeground)

                                HStack(spacing: 8) {
                                    ForEach(staff.tags, id: \.self) { tag in
                                        OutlinePill(text: tag)
                                    }
                                }
                            }

                            Spacer()

                            HStack(spacing: 26) {
                                StaffStatBlock(title: "Rate", value: staff.rate)
                                StaffStatBlock(title: "Appointments", value: staff.appointments)
                                StaffStatBlock(title: "Hired", value: staff.hired)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct StaffStatBlock: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .trailing, spacing: 4) {
            Text(title.uppercased())
                .font(.custom("Inter", size: 10).weight(.semibold))
                .foregroundColor(Theme.mutedForeground)
            Text(value)
                .font(.custom("Inter", size: 12).weight(.semibold))
        }
        .frame(minWidth: 70, alignment: .trailing)
    }
}

struct StaffProfileView: View {
    private let summaryMetrics: [StaffMetric] = [
        StaffMetric(title: "Total Appts", value: "324", subtitle: "Completion Rate 98%"),
        StaffMetric(title: "Revenue", value: "$45,280", subtitle: "Avg Tip $28"),
        StaffMetric(title: "Avg Rating", value: "4.9", subtitle: "Hourly Rate $35/hr"),
        StaffMetric(title: "No-shows", value: "3", subtitle: "Cancels 8"),
        StaffMetric(title: "Late", value: "2", subtitle: nil)
    ]

    private let upcomingAppointments: [AppointmentRow] = [
        AppointmentRow(clientName: "George Moodys", petName: "Trying", status: "Confirmed", statusTint: Theme.primary, service: "Full Groom Package", date: "Jan 28, 2025", time: "9:00 AM", duration: "2h", rating: nil, amount: nil),
        AppointmentRow(clientName: "Sarah Johnson", petName: "Bella", status: "Confirmed", statusTint: Theme.primary, service: "Bath & Brush", date: "Jan 28, 2025", time: "11:30 AM", duration: "1h", rating: nil, amount: nil),
        AppointmentRow(clientName: "Michael Chen", petName: "Charlie", status: "Pending", statusTint: Theme.muted, service: "Nail Trim", date: "Jan 28, 2025", time: "2:00 PM", duration: "30m", rating: nil, amount: nil)
    ]

    private let recentAppointments: [AppointmentRow] = [
        AppointmentRow(clientName: "George Moodys", petName: "Trying", status: "5", statusTint: Theme.warning, service: "Full Groom Package", date: "Jan 15, 2025", time: "9:00 AM", duration: "", rating: "Client very happy with the cut!", amount: "$85 + $45 tip"),
        AppointmentRow(clientName: "Emily Rodriguez", petName: "Rocky", status: "5", statusTint: Theme.warning, service: "Bath & Brush", date: "Jan 14, 2025", time: "1:30 PM", duration: "", rating: "Rocky was well-behaved today.", amount: "$55 + $20 tip"),
        AppointmentRow(clientName: "David Thompson", petName: "Coco", status: "5", statusTint: Theme.warning, service: "Luxury Spa Package", date: "Jan 12, 2025", time: "10:00 AM", duration: "", rating: "Perfect spa day!", amount: "$120 + $35 tip")
    ]

    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .center, spacing: 12) {
                Image(systemName: "chevron.left")
                    .foregroundColor(Theme.mutedForeground)
                VStack(alignment: .leading, spacing: 4) {
                    Text("Sarah Johnson")
                        .font(.custom("Inter", size: 22).weight(.bold))
                    HStack(spacing: 8) {
                        Text("Senior Groomer")
                            .font(.custom("Inter", size: 12).weight(.semibold))
                            .foregroundColor(Theme.mutedForeground)
                        Text("•")
                            .foregroundColor(Theme.mutedForeground)
                        Text("Since Mar 15, 2022")
                            .font(.custom("Inter", size: 12))
                            .foregroundColor(Theme.mutedForeground)
                        PillBadge(text: "Active", tint: Theme.primary)
                    }
                }
                Spacer()
                Button(action: {}) {
                    Text("Contact")
                        .font(.custom("Inter", size: 12).weight(.semibold))
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(Theme.muted)
                        .cornerRadius(10)
                }
                Button(action: {}) {
                    Image(systemName: "pencil")
                        .font(.system(size: 12, weight: .semibold))
                        .padding(8)
                        .background(Theme.muted)
                        .cornerRadius(8)
                }
            }

            HStack(spacing: 10) {
                ForEach(["Overview", "Payroll", "Schedule", "History"], id: \.self) { tab in
                    let isActive = tab == "Overview"
                    Text(tab)
                        .font(.custom("Inter", size: 12).weight(.semibold))
                        .foregroundColor(isActive ? Theme.primaryForeground : Theme.foreground)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 14)
                        .background(isActive ? Theme.primary : Theme.muted)
                        .cornerRadius(8)
                }
                Spacer()
            }

            HStack(spacing: 12) {
                ForEach(summaryMetrics) { metric in
                    CardContainer {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(metric.title.uppercased())
                                .font(.custom("Inter", size: 10).weight(.semibold))
                                .foregroundColor(Theme.mutedForeground)
                            Text(metric.value)
                                .font(.custom("Inter", size: 18).weight(.bold))
                            if let subtitle = metric.subtitle {
                                Text(subtitle)
                                    .font(.custom("Inter", size: 11))
                                    .foregroundColor(Theme.mutedForeground)
                            }
                        }
                    }
                }
            }

            SectionHeader(title: "Upcoming Appointments")
            VStack(spacing: 12) {
                ForEach(upcomingAppointments) { appointment in
                    AppointmentCard(appointment: appointment, showsRating: false)
                }
            }

            SectionHeader(title: "Recent Appointments")
            VStack(spacing: 12) {
                ForEach(recentAppointments) { appointment in
                    AppointmentCard(appointment: appointment, showsRating: true)
                }
            }
        }
    }
}

struct AppointmentCard: View {
    let appointment: AppointmentRow
    let showsRating: Bool

    var body: some View {
        CardContainer {
            HStack(alignment: .top, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 8) {
                        Text(appointment.clientName)
                            .font(.custom("Inter", size: 14).weight(.semibold))
                        OutlinePill(text: appointment.petName)
                        if showsRating {
                            HStack(spacing: 4) {
                                Text(appointment.status)
                                    .font(.custom("Inter", size: 12).weight(.semibold))
                                Image(systemName: "star.fill")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(Theme.warning)
                            }
                        } else {
                            PillBadge(text: appointment.status, tint: appointment.statusTint, textColor: Theme.primaryForeground)
                        }
                    }

                    Text(appointment.service)
                        .font(.custom("Inter", size: 12))
                        .foregroundColor(Theme.mutedForeground)

                    if let rating = appointment.rating {
                        Text("\"\(rating)\"")
                            .font(.custom("Inter", size: 11))
                            .foregroundColor(Theme.mutedForeground)
                    }
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 6) {
                    Text(appointment.date)
                        .font(.custom("Inter", size: 12).weight(.semibold))
                    Text("\(appointment.time) • \(appointment.duration)")
                        .font(.custom("Inter", size: 11))
                        .foregroundColor(Theme.mutedForeground)
                    if let amount = appointment.amount {
                        Text(amount)
                            .font(.custom("Inter", size: 12).weight(.semibold))
                            .foregroundColor(Theme.primary)
                    }
                }
            }
        }
    }
}
