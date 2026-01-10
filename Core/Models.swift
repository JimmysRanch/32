import SwiftUI

enum AppTab: String, CaseIterable, Identifiable {
    case dashboard = "Dashboard"
    case appointments = "Appointments"
    case messages = "Messages"
    case clients = "Clients"
    case staff = "Staff"
    case pos = "POS"
    case inventory = "Inventory"
    case finances = "Finances"
    case reports = "Reports"
    case settings = "Settings"

    var id: String { rawValue }
}

enum StaffSubTab: String, CaseIterable, Identifiable {
    case staffList = "Staff List"
    case schedule = "Schedule"
    case payroll = "Payroll"
    case performance = "Performance"

    var id: String { rawValue }
}

enum StaffProfileTab: String, CaseIterable, Identifiable {
    case overview = "Overview"
    case payroll = "Payroll"
    case schedule = "Schedule"
    case history = "History"

    var id: String { rawValue }
}

enum FinancesSubTab: String, CaseIterable, Identifiable {
    case dashboard = "Dashboard"
    case expenses = "Expenses"
    case payments = "Payments"
    case payroll = "Payroll"
    case taxes = "Taxes"

    var id: String { rawValue }
}

enum SettingsSubTab: String, CaseIterable, Identifiable {
    case staff = "Staff"
    case business = "Business"
    case services = "Services"
    case notifications = "Notifications"
    case pos = "POS"

    var id: String { rawValue }
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
