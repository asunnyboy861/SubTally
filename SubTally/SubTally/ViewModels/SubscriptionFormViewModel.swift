import SwiftUI
import SwiftData

@MainActor
final class SubscriptionFormViewModel: ObservableObject {
    @Published var name = ""
    @Published var amount: Decimal = 9.99
    @Published var billingCycle: BillingCycle = .monthly
    @Published var customCycleDays: Int = 30
    @Published var nextBillingDate = Date().adding(months: 1)
    @Published var category: SubscriptionCategory = .streaming
    @Published var notes = ""
    @Published var isTrial = false
    @Published var trialEndDate = Date().adding(days: 14)
    @Published var reminderEnabled = true
    @Published var remindDaysBefore = 3
    @Published var syncToCalendar = false

    var isFormValid: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty && amount > 0
    }

    func createSubscription() -> Subscription {
        let subscription = Subscription(
            name: name.trimmingCharacters(in: .whitespaces),
            amount: amount,
            billingCycle: billingCycle,
            nextBillingDate: nextBillingDate,
            category: category
        )
        subscription.customCycleDays = billingCycle == .custom ? customCycleDays : nil
        subscription.notes = notes
        subscription.isTrial = isTrial
        subscription.trialEndDate = isTrial ? trialEndDate : nil
        subscription.reminderEnabled = reminderEnabled
        subscription.remindDaysBefore = remindDaysBefore
        subscription.syncToCalendar = syncToCalendar
        return subscription
    }

    func populate(from subscription: Subscription) {
        name = subscription.name
        amount = subscription.amount
        billingCycle = subscription.billingCycle
        customCycleDays = subscription.customCycleDays ?? 30
        nextBillingDate = subscription.nextBillingDate
        category = subscription.category
        notes = subscription.notes
        isTrial = subscription.isTrial
        trialEndDate = subscription.trialEndDate ?? Date().adding(days: 14)
        reminderEnabled = subscription.reminderEnabled
        remindDaysBefore = subscription.remindDaysBefore
        syncToCalendar = subscription.syncToCalendar
    }

    func applyChanges(to subscription: Subscription) {
        subscription.name = name.trimmingCharacters(in: .whitespaces)
        subscription.amount = amount
        subscription.billingCycle = billingCycle
        subscription.customCycleDays = billingCycle == .custom ? customCycleDays : nil
        subscription.nextBillingDate = nextBillingDate
        subscription.category = category
        subscription.notes = notes
        subscription.isTrial = isTrial
        subscription.trialEndDate = isTrial ? trialEndDate : nil
        subscription.reminderEnabled = reminderEnabled
        subscription.remindDaysBefore = remindDaysBefore
        subscription.syncToCalendar = syncToCalendar
        subscription.updatedAt = Date()
    }
}
