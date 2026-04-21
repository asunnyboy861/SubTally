import SwiftUI
import SwiftData

struct SubscriptionFormView: View {
    enum Mode {
        case add
        case edit(Subscription)
    }

    let mode: Mode
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = SubscriptionFormViewModel()
    @StateObject private var calendarManager = CalendarManager()
    @StateObject private var notificationManager = NotificationManager()

    @State private var showingCalendarPermission = false

    var body: some View {
        NavigationStack {
            Form {
                basicInfoSection
                billingSection
                categorySection
                trialSection
                reminderSection
                calendarSection
                notesSection
            }
            .navigationTitle(isEditing ? "Edit Subscription" : "Add Subscription")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(isEditing ? "Save" : "Add") {
                        saveSubscription()
                    }
                    .fontWeight(.semibold)
                    .disabled(!viewModel.isFormValid)
                }
            }
            .onAppear {
                if case .edit(let subscription) = mode {
                    viewModel.populate(from: subscription)
                }
                calendarManager.checkAuthorization()
                notificationManager.checkAuthorization()
            }
        }
    }

    private var isEditing: Bool {
        if case .edit = mode { return true }
        return false
    }

    private var basicInfoSection: some View {
        Section {
            TextField("Subscription Name", text: $viewModel.name)
        } header: {
            Text("Name")
        }
    }

    private var billingSection: some View {
        Section {
            HStack {
                Text("$")
                    .foregroundStyle(.secondary)
                TextField("Amount", value: $viewModel.amount, format: .number)
                    .keyboardType(.decimalPad)
            }

            Picker("Billing Cycle", selection: $viewModel.billingCycle) {
                ForEach(BillingCycle.allCases, id: \.self) { cycle in
                    Text(cycle.displayName).tag(cycle)
                }
            }

            if viewModel.billingCycle == .custom {
                Stepper("Every \(viewModel.customCycleDays) days", value: $viewModel.customCycleDays, in: 1...365)
            }

            DatePicker("Next Billing Date", selection: $viewModel.nextBillingDate, displayedComponents: .date)
        } header: {
            Text("Billing")
        }
    }

    private var categorySection: some View {
        Section {
            Picker("Category", selection: $viewModel.category) {
                ForEach(SubscriptionCategory.allCases, id: \.self) { cat in
                    Label(cat.rawValue, systemImage: cat.icon).tag(cat)
                }
            }
            .pickerStyle(.menu)
        } header: {
            Text("Category")
        }
    }

    private var trialSection: some View {
        Section {
            Toggle("Free Trial", isOn: $viewModel.isTrial)
            if viewModel.isTrial {
                DatePicker("Trial Ends", selection: $viewModel.trialEndDate, displayedComponents: .date)
            }
        } header: {
            Text("Trial")
        }
    }

    private var reminderSection: some View {
        Section {
            Toggle("Enable Reminders", isOn: $viewModel.reminderEnabled)
            if viewModel.reminderEnabled {
                Stepper("Remind \(viewModel.remindDaysBefore) days before", value: $viewModel.remindDaysBefore, in: 1...30)
            }
        } header: {
            Text("Reminders")
        }
    }

    private var calendarSection: some View {
        Section {
            Toggle("Sync to Calendar", isOn: $viewModel.syncToCalendar)
            if viewModel.syncToCalendar && !calendarManager.isAuthorized {
                Button("Grant Calendar Access") {
                    Task {
                        _ = await calendarManager.requestAccess()
                    }
                }
                .foregroundStyle(.blue)
            }
        } header: {
            Text("Calendar")
        }
    }

    private var notesSection: some View {
        Section {
            TextField("Notes (optional)", text: $viewModel.notes, axis: .vertical)
                .lineLimit(3...6)
        } header: {
            Text("Notes")
        }
    }

    private func saveSubscription() {
        switch mode {
        case .add:
            let subscription = viewModel.createSubscription()
            modelContext.insert(subscription)
            if subscription.reminderEnabled {
                notificationManager.scheduleReminder(for: subscription)
            }
            if subscription.syncToCalendar {
                Task {
                    let eventId = await calendarManager.createReminderEvents(for: subscription)
                    subscription.calendarEventId = eventId
                }
            }
        case .edit(let subscription):
            viewModel.applyChanges(to: subscription)
            notificationManager.rescheduleReminder(for: subscription)
            if subscription.syncToCalendar {
                Task {
                    await calendarManager.updateReminderEvents(for: subscription)
                }
            }
        }
        dismiss()
    }
}
