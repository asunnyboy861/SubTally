import SwiftUI
import SwiftData

@main
struct SubTallyApp: App {
    @StateObject private var purchaseManager = PurchaseManager()
    @StateObject private var calendarManager = CalendarManager()
    @StateObject private var notificationManager = NotificationManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(purchaseManager)
                .environmentObject(calendarManager)
                .environmentObject(notificationManager)
                .onAppear {
                    notificationManager.checkAuthorization()
                    calendarManager.checkAuthorization()
                }
        }
        .modelContainer(for: Subscription.self)
    }
}
