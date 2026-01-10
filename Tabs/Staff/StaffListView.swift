import SwiftUI

struct StaffListView: View {
    let onSelectProfile: () -> Void

    private let staffMembers: [StaffMember] = [
        StaffMember(name: "Sarah Johnson", role: "Senior Groomer", status: "Active", email: "sarah.j@pawhub.com", phone: "(555) 123-4567", tags: ["Large Breeds", "Show Cuts", "Hand Stripping"], rate: "$35/hr", appointments: "324", hired: "Mar 15, 2022", statusTint: Theme.primary),
        StaffMember(name: "Mike Torres", role: "Groomer", status: "Active", email: "mike.t@pawhub.com", phone: "(555) 234-5678", tags: ["Anxious Dogs", "Creative Styling", "Nail Care"], rate: "$28/hr", appointments: "256", hired: "Aug 20, 2022", statusTint: Theme.primary),
        StaffMember(name: "Emma Roberts", role: "Spa Specialist", status: "Active", email: "emma.r@pawhub.com", phone: "(555) 345-6789", tags: ["Spa Treatments", "Small Breeds", "Facials"], rate: "$32/hr", appointments: "198", hired: "Jan 10, 2023", statusTint: Theme.primary),
        StaffMember(name: "Carlos Martinez", role: "Bather", status: "Active", email: "carlos.m@pawhub.com", phone: "(555) 456-7890", tags: ["De-shedding", "Quick Service", "Puppy Care"], rate: "$22/hr", appointments: "412", hired: "May 5, 2023", statusTint: Theme.primary),
        StaffMember(name: "Lisa Chen", role: "Groomer", status: "On Leave", email: "lisa.c@pawhub.com", phone: "(555) 567-8901", tags: ["Poodle Cuts", "Color & Styling", "Competition Prep"], rate: "$30/hr", appointments: "187", hired: "Nov 12, 2023", statusTint: Theme.secondary)
    ]

    var body: some View {
        VStack(spacing: 14) {
            ForEach(staffMembers) { staff in
                Button(action: onSelectProfile) {
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
                                    Text(staff.email)
                                    Text(staff.phone)
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
                .buttonStyle(.plain)
            }
        }
    }
}
