import SwiftUI
import SwiftData

@MainActor
final class SubscriptionListViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var selectedCategory: SubscriptionCategory?
    @Published var showingAddSheet = false
    @Published var showingPaywall = false
    @Published var showingExportSheet = false

    var filteredSubscriptions: [Subscription] {
        var result = subscriptions.filter { $0.isActive }

        if !searchText.isEmpty {
            result = result.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.category.rawValue.localizedCaseInsensitiveContains(searchText)
            }
        }

        if let category = selectedCategory {
            result = result.filter { $0.category == category }
        }

        return result.sorted { $0.nextBillingDate < $1.nextBillingDate }
    }

    var activeSubscriptions: [Subscription] {
        subscriptions.filter { $0.isActive }
    }

    var totalMonthly: Decimal {
        activeSubscriptions.reduce(0) { $0 + $1.monthlyEquivalent }
    }

    var totalYearly: Decimal {
        activeSubscriptions.reduce(0) { $0 + $1.yearlyEquivalent }
    }

    var upcomingThisWeek: [Subscription] {
        let now = Date()
        let weekFromNow = now.adding(days: 7)
        return activeSubscriptions.filter {
            $0.nextBillingDate >= now && $0.nextBillingDate <= weekFromNow
        }.sorted { $0.nextBillingDate < $1.nextBillingDate }
    }

    var trialSubscriptions: [Subscription] {
        activeSubscriptions.filter { $0.isTrial }
    }

    var categoryBreakdown: [(SubscriptionCategory, Decimal)] {
        let grouped = Dictionary(grouping: activeSubscriptions) { $0.category }
        return grouped.map { ($0.key, $0.value.reduce(0) { $0 + $1.monthlyEquivalent }) }
            .sorted { $0.1 > $1.1 }
    }

    private var subscriptions: [Subscription] = []

    func updateSubscriptions(from models: [Subscription]) {
        subscriptions = models
    }

    func canAddMore(purchaseManager: PurchaseManager) -> Bool {
        purchaseManager.isPro || purchaseManager.isWithinFreeLimit(count: activeSubscriptions.count)
    }
}
