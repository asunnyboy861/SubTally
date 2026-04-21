import SwiftUI
import SwiftData

struct SubscriptionDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Bindable var subscription: Subscription
    @StateObject private var calendarManager = CalendarManager()
    @StateObject private var notificationManager = NotificationManager()
    @State private var showingEditSheet = false
    @State private var showingCancelGuide = false
    @State private var showingDeleteAlert = false
    @State private var cancelGuide: CancelGuide?

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                headerCard
                detailsCard
                billingInfoCard
                reminderCard
                actionsCard
            }
            .padding()
            .padding(.bottom, 40)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(subscription.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button {
                    showingEditSheet = true
                } label: {
                    Text("Edit")
                }
                Menu {
                    Button {
                        findCancelGuide()
                        showingCancelGuide = true
                    } label: {
                        Label("How to Cancel", systemImage: "xmark.circle")
                    }
                    Button(role: .destructive) {
                        showingDeleteAlert = true
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
        .sheet(isPresented: $showingEditSheet) {
            SubscriptionFormView(mode: .edit(subscription))
        }
        .sheet(isPresented: $showingCancelGuide) {
            if let guide = cancelGuide {
                CancelGuideDetailView(guide: guide)
            }
        }
        .alert("Delete Subscription?", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                deleteSubscription()
            }
        } message: {
            Text("This action cannot be undone.")
        }
    }

    private var headerCard: some View {
        VStack(spacing: 12) {
            Image(systemName: subscription.icon)
                .font(.system(size: 40))
                .foregroundStyle(Color(hex: subscription.colorHex))
                .frame(width: 72, height: 72)
                .background(Color(hex: subscription.colorHex).opacity(0.15))
                .cornerRadius(18)

            Text(subscription.name)
                .font(.title2.weight(.bold))

            HStack(spacing: 6) {
                Text(subscription.category.rawValue)
                if subscription.isTrial {
                    Text("·")
                    Text("TRIAL")
                        .font(.caption2.weight(.bold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.orange)
                        .cornerRadius(4)
                }
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)

            Text(subscription.amount.asCurrency + "/\(subscription.billingCycle.shortName)")
                .font(.title3.weight(.semibold))
                .foregroundStyle(Color(hex: subscription.colorHex))
        }
        .frame(maxWidth: .infinity)
        .padding(24)
        .background(Color(.systemBackground))
        .cornerRadius(16)
    }

    private var detailsCard: some View {
        VStack(spacing: 16) {
            DetailRow(icon: "calendar", title: "Next Billing", value: subscription.nextBillingDate.formattedShort)
            DetailRow(icon: "creditcard", title: "Monthly Equivalent", value: subscription.monthlyEquivalent.asCurrency)
            DetailRow(icon: "calendar.badge.clock", title: "Yearly Equivalent", value: subscription.yearlyEquivalent.asCurrency)
            if !subscription.notes.isEmpty {
                DetailRow(icon: "note.text", title: "Notes", value: subscription.notes)
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }

    private var billingInfoCard: some View {
        VStack(spacing: 16) {
            DetailRow(icon: "repeat", title: "Billing Cycle", value: subscription.billingCycle.displayName)
            if subscription.billingCycle == .custom, let days = subscription.customCycleDays {
                DetailRow(icon: "number", title: "Custom Cycle", value: "Every \(days) days")
            }
            DetailRow(icon: "dollarsign.circle", title: "Currency", value: subscription.currency)
            if let trialEnd = subscription.trialEndDate, subscription.isTrial {
                DetailRow(icon: "hourglass", title: "Trial Ends", value: trialEnd.formattedShort)
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }

    private var reminderCard: some View {
        VStack(spacing: 16) {
            DetailRow(icon: "bell", title: "Reminders", value: subscription.reminderEnabled ? "On" : "Off")
            if subscription.reminderEnabled {
                DetailRow(icon: "bell.badge", title: "Remind Before", value: "\(subscription.remindDaysBefore) days")
            }
            DetailRow(icon: "calendar.badge.plus", title: "Calendar Sync", value: subscription.syncToCalendar ? "On" : "Off")
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }

    private var actionsCard: some View {
        VStack(spacing: 12) {
            Button {
                subscription.isActive = false
                subscription.cancelledDate = Date()
                notificationManager.cancelReminder(for: subscription)
                if let eventId = subscription.calendarEventId {
                    calendarManager.removeReminderEvents(eventId: eventId)
                }
                dismiss()
            } label: {
                Label("Mark as Cancelled", systemImage: "xmark.circle")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red.opacity(0.1))
                    .foregroundStyle(.red)
                    .cornerRadius(12)
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }

    private func findCancelGuide() {
        cancelGuide = CancelGuideData.guide(for: subscription.name)
            ?? CancelGuideData.guides(for: subscription.category).first
    }

    private func deleteSubscription() {
        notificationManager.cancelReminder(for: subscription)
        if let eventId = subscription.calendarEventId {
            calendarManager.removeReminderEvents(eventId: eventId)
        }
        modelContext.delete(subscription)
        dismiss()
    }
}

struct DetailRow: View {
    let icon: String
    let title: String
    let value: String

    var body: some View {
        HStack {
            Label(title, systemImage: icon)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .font(.subheadline.weight(.medium))
        }
    }
}
