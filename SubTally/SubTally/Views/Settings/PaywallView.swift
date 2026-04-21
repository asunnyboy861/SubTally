import SwiftUI
import StoreKit

struct PaywallView: View {
    @ObservedObject var purchaseManager: PurchaseManager
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {
                    headerSection
                    featuresSection
                    purchaseButton
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

    private var purchaseButton: some View {
        Button {
            Task {
                if await purchaseManager.purchase() {
                    dismiss()
                }
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
                if let product = purchaseManager.product {
                    Text("Buy Once — \(product.displayPrice)")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundStyle(.white)
                        .cornerRadius(14)
                } else {
                    Text("Buy Once")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundStyle(.white)
                        .cornerRadius(14)
                }
            }
        }
        .disabled(purchaseManager.isLoading)
    }

    private var restoreButton: some View {
        Button {
            Task {
                await purchaseManager.restorePurchases()
            }
        } label: {
            Text("Restore Purchases")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
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
