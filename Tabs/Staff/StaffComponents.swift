import SwiftUI

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
                    .fill(Theme.background.opacity(0.6))
            )
            .overlay(
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

struct StaffStatBlock: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .trailing, spacing: 4) {
            Text(title.uppercased())
                .font(.custom("Inter", size: 10).weight(.semibold))
                .foregroundColor(Theme.mutedForeground)
            Text(value)
                .font(.custom("Inter", size: 13).weight(.semibold))
        }
        .frame(minWidth: 70, alignment: .trailing)
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
