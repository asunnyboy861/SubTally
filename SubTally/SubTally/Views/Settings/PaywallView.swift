import SwiftUI
import StoreKit

struct PaywallView: View {
    @ObservedObject var purchaseManager: PurchaseManager
    @Environment(\.dismiss) private var dismiss
    
    @State private var showSuccessAlert = false
    @State private var showRestoreSuccessAlert = false
    @State private var showNoPurchasesAlert = false
    @State private var showErrorAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {
                    headerSection
                    featuresSection
                    purchaseSection
                    restoreButton
                    termsSection
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("SubTally Pro")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Close") { dismiss() }
                }
            }
            .alert("Purchase Successful", isPresented: $showSuccessAlert) {
                Button("OK") { dismiss() }
            } message: {
                Text("Thank you for upgrading to SubTally Pro! You now have unlimited access to all features.")
            }
            .alert("Purchases Restored", isPresented: $showRestoreSuccessAlert) {
                Button("OK") { dismiss() }
            } message: {
                Text("Your SubTally Pro purchase has been successfully restored.")
            }
            .alert("No Purchases Found", isPresented: $showNoPurchasesAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("No previous purchases were found for this Apple ID.")
            }
            .alert("Error", isPresented: $showErrorAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
        }
    }

    private var headerSection: some View {
        VStack(spacing: 12) {
            Image(systemName: "crown.fill")
                .font(.system(size: 48))
                .foregroundStyle(.yellow)

            Text("Unlock Unlimited Tracking")
                .font(.title2.weight(.bold))

            Text("Track more than \(AppConstants.freeSubscriptionLimit) subscriptions and unlock all features")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(.top, 20)
    }

    private var featuresSection: some View {
        VStack(spacing: 16) {
            FeatureRow(icon: "infinity", title: "Unlimited Subscriptions", description: "No limit on tracked subscriptions")
            FeatureRow(icon: "calendar.badge.plus", title: "Calendar Sync", description: "Sync billing dates to your calendar")
            FeatureRow(icon: "bell.badge", title: "Smart Reminders", description: "Never miss a payment")
            FeatureRow(icon: "square.and.arrow.up", title: "Data Export", description: "Export your data anytime")
            FeatureRow(icon: "xmark.circle", title: "Cancel Guides", description: "Step-by-step cancellation instructions")
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(16)
    }
    
    @ViewBuilder
    private var purchaseSection: some View {
        if purchaseManager.product == nil {
            loadingButton
        } else {
            purchaseButton
        }
    }
    
    private var loadingButton: some View {
        HStack(spacing: 8) {
            ProgressView()
                .progressViewStyle(.circular)
            Text("Loading...")
                .font(.subheadline)
        }
        .foregroundStyle(.secondary)
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray5))
        .cornerRadius(14)
    }

    private var purchaseButton: some View {
        Button {
            Task {
                await handlePurchase()
            }
        } label: {
            if purchaseManager.isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .cornerRadius(14)
            } else {
                Text("Unlock Pro — \(purchaseManager.product?.displayPrice ?? "")")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundStyle(.white)
                    .cornerRadius(14)
            }
        }
        .disabled(purchaseManager.isLoading)
    }

    private var restoreButton: some View {
        Button {
            Task {
                await handleRestore()
            }
        } label: {
            if purchaseManager.isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
            } else {
                Text("Restore Purchases")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .disabled(purchaseManager.isLoading)
    }

    private var termsSection: some View {
        VStack(spacing: 8) {
            Text("One-time purchase. No recurring charges.")
                .font(.caption)
                .foregroundStyle(.secondary)
            HStack(spacing: 4) {
                Link("Privacy Policy", destination: URL(string: AppConstants.privacyPolicyURL)!)
                Text("·")
                Link("Terms of Use", destination: URL(string: AppConstants.termsOfUseURL)!)
            }
            .font(.caption)
        }
    }
    
    private func handlePurchase() async {
        let result = await purchaseManager.purchase()
        
        await MainActor.run {
            switch result {
            case .success:
                showSuccessAlert = true
            case .failed(let error):
                alertMessage = error.localizedDescription
                showErrorAlert = true
            case .cancelled, .pending:
                break
            }
        }
    }
    
    private func handleRestore() async {
        let result = await purchaseManager.restorePurchases()
        
        await MainActor.run {
            switch result {
            case .success:
                showRestoreSuccessAlert = true
            case .noPurchasesFound:
                showNoPurchasesAlert = true
            case .failed(let error):
                alertMessage = error.localizedDescription
                showErrorAlert = true
            }
        }
    }
}

struct FeatureRow: View {
    let icon: String
    let title: String
    let description: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(Color.accentColor)
                .frame(width: 36)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline.weight(.medium))
                Text(description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
