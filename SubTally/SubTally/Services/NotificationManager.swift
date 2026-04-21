import UserNotifications
import SwiftUI

@MainActor
final class NotificationManager: ObservableObject {
    @Published var isAuthorized = false
    @Published var errorMessage: String?

    private let center = UNUserNotificationCenter.current()

    func requestAuthorization() async -> Bool {
        do {
            let granted = try await center.requestAuthorization(options: [.alert, .sound, .badge])
            isAuthorized = granted
            return granted
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }

    func checkAuthorization() {
        center.getNotificationSettings { settings in
            Task { @MainActor in
                self.isAuthorized = settings.authorizationStatus == .authorized
            }
        }
    }

    func scheduleReminder(for subscription: Subscription) {
        guard subscription.reminderEnabled else { return }

        let reminderDays = [subscription.remindDaysBefore, 1, 0]

        for daysBefore in reminderDays {
            guard daysBefore >= 0 else { continue }

            let triggerDate = Calendar.current.date(
                byAdding: .day, value: -daysBefore, to: subscription.nextBillingDate
            ) ?? subscription.nextBillingDate

            let content = UNMutableNotificationContent()
            if daysBefore == 0 {
                content.title = "Payment Today"
                content.body = "\(subscription.name) charges \(subscription.amount.asCurrency) today"
            } else {
                content.title = "Upcoming Payment"
                content.body = "\(subscription.name) charges \(subscription.amount.asCurrency) in \(daysBefore) day\(daysBefore > 1 ? "s" : "")"
            }
            content.sound = .default
            content.userInfo = ["subscriptionId": subscription.id.uuidString]

            let dateComponents = Calendar.current.dateComponents(
                [.year, .month, .day, .hour, .minute],
                from: triggerDate
            )
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

            let identifier = "\(subscription.id.uuidString)-\(daysBefore)"
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

            center.add(request) { error in
                if let error {
                    Task { @MainActor in
                        self.errorMessage = error.localizedDescription
                    }
                }
            }
        }
    }

    func cancelReminder(for subscription: Subscription) {
        let identifiers = [
            "\(subscription.id.uuidString)-\(subscription.remindDaysBefore)",
            "\(subscription.id.uuidString)-1",
            "\(subscription.id.uuidString)-0"
        ]
        center.removePendingNotificationRequests(withIdentifiers: identifiers)
    }

    func rescheduleReminder(for subscription: Subscription) {
        cancelReminder(for: subscription)
        scheduleReminder(for: subscription)
    }

    func scheduleAllReminders(for subscriptions: [Subscription]) {
        center.removeAllPendingNotificationRequests()
        for sub in subscriptions where sub.isActive && sub.reminderEnabled {
            scheduleReminder(for: sub)
        }
    }
}
