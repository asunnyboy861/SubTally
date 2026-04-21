import LocalAuthentication
import SwiftUI

@MainActor
final class BiometricAuthManager: ObservableObject {
    @Published var isAuthenticated = false
    @Published var isBiometricAvailable = false
    @Published var errorMessage: String?

    func checkBiometricAvailability() {
        let context = LAContext()
        var error: NSError?
        isBiometricAvailable = context.canEvaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics, error: &error
        )
    }

    func authenticate() async -> Bool {
        let context = LAContext()
        var error: NSError?

        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            if let error {
                errorMessage = error.localizedDescription
            }
            return false
        }

        do {
            let success = try await context.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                localizedReason: "Authenticate to access SubTally"
            )
            isAuthenticated = success
            return success
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }

    var biometricType: LABiometryType {
        let context = LAContext()
        _ = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        return context.biometryType
    }
}
