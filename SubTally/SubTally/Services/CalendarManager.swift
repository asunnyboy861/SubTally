import EventKit
import SwiftUI

@MainActor
final class CalendarManager: ObservableObject {
    @Published var isAuthorized = false
    @Published var errorMessage: String?

    private let eventStore = EKEventStore()
    private var subTallyCalendar: EKCalendar?

    func requestAccess() async -> Bool {
        do {
            let granted = try await eventStore.requestFullAccessToEvents()
            isAuthorized = granted
            if granted {
                _ = await getOrCreateSubTallyCalendar()
            }
            return granted
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }

    func checkAuthorization() {
        let status = EKEventStore.authorizationStatus(for: .event)
        isAuthorized = status == .fullAccess
    }

    private func getOrCreateSubTallyCalendar() async -> EKCalendar? {
        let calendars = eventStore.calendars(for: .event)
        if let existing = calendars.first(where: { $0.title == AppConstants.calendarName }) {
            subTallyCalendar = existing
            return existing
        }

        let newCalendar = EKCalendar(for: .event, eventStore: eventStore)
        newCalendar.title = AppConstants.calendarName
        newCalendar.cgColor = UIColor(red: 0.04, green: 0.53, blue: 0.33, alpha: 1.0).cgColor

        if let iCloudSource = eventStore.sources.first(where: { $0.sourceType == .calDAV && $0.title.contains("iCloud") }) {
            newCalendar.source = iCloudSource
        } else if let localSource = eventStore.sources.first(where: { $0.sourceType == .local }) {
            newCalendar.source = localSource
        }

        do {
            try eventStore.saveCalendar(newCalendar, commit: true)
            subTallyCalendar = newCalendar
            return newCalendar
        } catch {
            errorMessage = error.localizedDescription
            return nil
        }
    }

    func createReminderEvents(for subscription: Subscription) async -> String? {
        guard subscription.syncToCalendar, isAuthorized else { return nil }

        var calendar = subTallyCalendar
        if calendar == nil {
            calendar = await getOrCreateSubTallyCalendar()
        }
        guard let calendar else { return nil }

        let reminderDays = [subscription.remindDaysBefore, 1, 0]
        var primaryEventId: String?

        for (index, daysBefore) in reminderDays.enumerated() {
            guard daysBefore >= 0 else { continue }

            let event = EKEvent(eventStore: eventStore)
            let billingDate = subscription.nextBillingDate

            guard let reminderDate = Calendar.current.date(
                byAdding: .day, value: -daysBefore, to: billingDate
            ) else { continue }

            event.title = daysBefore == 0
                ? "\(subscription.name) - \(subscription.amount.asCurrency) TODAY"
                : "\(subscription.name) - \(subscription.amount.asCurrency) in \(daysBefore) day\(daysBefore > 1 ? "s" : "")"

            event.startDate = reminderDate
            event.endDate = reminderDate.addingTimeInterval(3600)
            event.calendar = calendar
            event.notes = "SubTally reminder: \(subscription.name) \(subscription.billingCycle.displayName) payment"

            let alarm = EKAlarm(absoluteDate: reminderDate)
            event.addAlarm(alarm)

            do {
                try eventStore.save(event, span: .thisEvent)
                if index == 0 { primaryEventId = event.eventIdentifier }
            } catch {
                errorMessage = error.localizedDescription
            }
        }

        return primaryEventId
    }

    func updateReminderEvents(for subscription: Subscription) async {
        if let eventId = subscription.calendarEventId {
            removeReminderEvents(eventId: eventId)
        }
        let newEventId = await createReminderEvents(for: subscription)
        subscription.calendarEventId = newEventId
    }

    func removeReminderEvents(eventId: String) {
        if let event = eventStore.event(withIdentifier: eventId) {
            try? eventStore.remove(event, span: .thisEvent)
        }
    }

    func removeAllEvents(for subscriptions: [Subscription]) {
        for sub in subscriptions {
            if let eventId = sub.calendarEventId {
                removeReminderEvents(eventId: eventId)
            }
        }
    }
}
