import SwiftUI

struct StaffProfileView: View {
    @State private var selectedTab: StaffProfileTab = .overview

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
                        .font(.custom("Inter", size: 24).weight(.bold))
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
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Theme.border, lineWidth: 1)
                )
                Button(action: {}) {
                    Image(systemName: "pencil")
                        .font(.system(size: 12, weight: .semibold))
                        .padding(8)
                        .background(Theme.muted)
                        .cornerRadius(8)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Theme.border, lineWidth: 1)
                )
            }

            HStack(spacing: 10) {
                ForEach(StaffProfileTab.allCases) { tab in
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
                            .cornerRadius(999)
                    }
                    .buttonStyle(.plain)
                }
                Spacer()
            }

            if selectedTab == .overview {
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
            } else {
                ComingSoonView(title: "Staff Profile \(selectedTab.rawValue)")
            }
        }
    }
}
