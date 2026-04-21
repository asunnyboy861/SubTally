import SwiftUI
import SwiftData

@MainActor
final class CalendarViewModel: ObservableObject {
    @Published var selectedDate = Date()
    @Published var displayedMonth = Date()

    var subscriptionsForSelectedDate: [Subscription] {
        let calendar = Calendar.current
        return allSubscriptions.filter { sub in
            calendar.isDate(sub.nextBillingDate, inSameDayAs: selectedDate)
        }
    }

    var subscriptionsForMonth: [Subscription] {
        let calendar = Calendar.current
        return allSubscriptions.filter { sub in
            calendar.isDate(sub.nextBillingDate, equalTo: displayedMonth, toGranularity: .month)
        }
    }

    var billingDatesInMonth: Set<DateComponents> {
        let calendar = Calendar.current
        return Set(subscriptionsForMonth.map {
            calendar.dateComponents([.year, .month, .day], from: $0.nextBillingDate)
        })
    }

    var totalForMonth: Decimal {
        subscriptionsForMonth.reduce(0) { $0 + $1.monthlyEquivalent }
    }

    var daysWithPayments: [Int] {
        let calendar = Calendar.current
        return subscriptionsForMonth.compactMap {
            calendar.component(.day, from: $0.nextBillingDate)
        }
    }

    private var allSubscriptions: [Subscription] = []

    func updateSubscriptions(from models: [Subscription]) {
        allSubscriptions = models.filter { $0.isActive }
    }

    func selectToday() {
        selectedDate = Date()
        displayedMonth = Date()
    }
}
