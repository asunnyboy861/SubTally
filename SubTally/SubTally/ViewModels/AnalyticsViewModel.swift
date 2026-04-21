import SwiftUI
import SwiftData

@MainActor
final class AnalyticsViewModel: ObservableObject {
    @Published var selectedPeriod: TimePeriod = .monthly

    enum TimePeriod: String, CaseIterable {
        case weekly = "Weekly"
        case monthly = "Monthly"
        case yearly = "Yearly"
    }

    var totalForPeriod: Decimal {
        switch selectedPeriod {
        case .weekly: return weeklyTotal
        case .monthly: return monthlyTotal
        case .yearly: return yearlyTotal
        }
    }

    var weeklyTotal: Decimal {
        activeSubscriptions.reduce(0) { $0 + ($1.monthlyEquivalent * 12 / 52) }
    }

    var monthlyTotal: Decimal {
        activeSubscriptions.reduce(0) { $0 + $1.monthlyEquivalent }
    }

    var yearlyTotal: Decimal {
        activeSubscriptions.reduce(0) { $0 + $1.yearlyEquivalent }
    }

    var categoryData: [(SubscriptionCategory, Decimal, Double)] {
        let total = monthlyTotal
        return categoryBreakdown.map { category, amount in
            let percentage = total > 0 ? (amount / total * 100).doubleValue : 0
            return (category, amount, percentage)
        }
    }

    var categoryBreakdown: [(SubscriptionCategory, Decimal)] {
        let grouped = Dictionary(grouping: activeSubscriptions) { $0.category }
        return grouped.map { ($0.key, $0.value.reduce(0) { $0 + $1.monthlyEquivalent }) }
            .sorted { $0.1 > $1.1 }
    }

    var billingCycleBreakdown: [(BillingCycle, Int, Decimal)] {
        let grouped = Dictionary(grouping: activeSubscriptions) { $0.billingCycle }
        return BillingCycle.allCases.compactMap { cycle in
            guard let subs = grouped[cycle], !subs.isEmpty else { return nil }
            let total = subs.reduce(0) { $0 + $1.monthlyEquivalent }
            return (cycle, subs.count, total)
        }.sorted { $0.2 > $1.2 }
    }

    var upcomingPayments: [(String, Decimal, Date)] {
        activeSubscriptions
            .sorted { $0.nextBillingDate < $1.nextBillingDate }
            .prefix(5)
            .map { ($0.name, $0.amount, $0.nextBillingDate) }
    }

    private var activeSubscriptions: [Subscription] = []

    func updateSubscriptions(from models: [Subscription]) {
        activeSubscriptions = models.filter { $0.isActive }
    }
}
