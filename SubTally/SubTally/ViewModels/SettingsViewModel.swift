import SwiftUI
import SwiftData

@MainActor
final class SettingsViewModel: ObservableObject {
    @Published var biometricLockEnabled = false
    @Published var defaultRemindDaysBefore = 3
    @Published var defaultCurrency = "USD"
    @Published var showingAbout = false
    @Published var showingPaywall = false

    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"

    var versionString: String {
        "Version \(appVersion) (\(buildNumber))"
    }
}
