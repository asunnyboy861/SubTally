import SwiftData
import Foundation

@Model
final class Subscription {
    @Attribute(.unique) var id: UUID
    var name: String
    var icon: String
    var customIconData: Data?
    var amount: Decimal
    var currency: String
    var billingCycle: BillingCycle
    var customCycleDays: Int?
    var nextBillingDate: Date
    var firstBillingDate: Date
    var category: SubscriptionCategory
    var colorHex: String
    var notes: String
    var isTrial: Bool
    var trialEndDate: Date?
    var isActive: Bool
    var cancelledDate: Date?
    var createdAt: Date
    var updatedAt: Date

    var remindDaysBefore: Int
    var remindOnDay: Bool
    var reminderEnabled: Bool

    var calendarEventId: String?
    var syncToCalendar: Bool

    var monthlyEquivalent: Decimal {
        switch billingCycle {
        case .weekly: return amount * 52 / 12
        case .monthly: return amount
        case .quarterly: return amount / 3
        case .yearly: return amount / 12
        case .custom:
            let days = Decimal(customCycleDays ?? 30)
            guard days > 0 else { return amount }
            return amount * (365 / days) / 12
        }
    }

    var yearlyEquivalent: Decimal {
        monthlyEquivalent * 12
    }

    init(name: String, amount: Decimal, billingCycle: BillingCycle,
         nextBillingDate: Date, category: SubscriptionCategory) {
        self.id = UUID()
        self.name = name
        self.amount = amount
        self.currency = "USD"
        self.billingCycle = billingCycle
        self.nextBillingDate = nextBillingDate
        self.firstBillingDate = nextBillingDate
        self.category = category
        self.colorHex = category.colorHex
        self.notes = ""
        self.isTrial = false
        self.isActive = true
        self.createdAt = Date()
        self.updatedAt = Date()
        self.remindDaysBefore = 3
        self.remindOnDay = true
        self.reminderEnabled = true
        self.syncToCalendar = false
        self.icon = category.icon
    }
}
