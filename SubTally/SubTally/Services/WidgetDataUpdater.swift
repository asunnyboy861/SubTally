import WidgetKit
import Foundation

struct WidgetDataUpdater {
    static func update(subscriptions: [Subscription]) {
        let defaults = UserDefaults(suiteName: AppConstants.groupContainerId)
        let active = subscriptions.filter { $0.isActive }
        let totalMonthly = active.reduce(Decimal(0)) { $0 + $1.monthlyEquivalent }
        let totalYearly = active.reduce(Decimal(0)) { $0 + $1.yearlyEquivalent }

        defaults?.set(totalMonthly.asCurrency, forKey: "widget_totalMonthly")
        defaults?.set(totalYearly.asCurrency, forKey: "widget_totalYearly")
        defaults?.set(active.count, forKey: "widget_activeCount")

        let upcoming = active
            .filter { $0.nextBillingDate >= Date() }
            .sorted { $0.nextBillingDate < $1.nextBillingDate }

        if let next = upcoming.first {
            defaults?.set(next.name, forKey: "widget_nextPayment")
            defaults?.set(next.nextBillingDate.formattedMonthDay, forKey: "widget_nextPaymentDate")
            defaults?.set(next.amount.asCurrency, forKey: "widget_nextPaymentAmount")
        } else {
            defaults?.set(nil, forKey: "widget_nextPayment")
            defaults?.set(nil, forKey: "widget_nextPaymentDate")
            defaults?.set(nil, forKey: "widget_nextPaymentAmount")
        }

        WidgetCenter.shared.reloadAllTimelines()
    }
}
