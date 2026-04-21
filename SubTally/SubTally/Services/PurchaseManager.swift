import StoreKit
import SwiftUI

@MainActor
final class PurchaseManager: ObservableObject {
    @Published private(set) var isPro = false
    @Published private(set) var product: Product?
    @Published private(set) var isLoading = false
    @Published var errorMessage: String?

    private let productID = AppConstants.proProductId
    private var transactionListener: Task<Void, Never>?

    init() {
        transactionListener = listenForTransactions()
        Task {
            await loadProduct()
            await updatePurchaseStatus()
        }
    }

    deinit {
        transactionListener?.cancel()
    }

    func loadProduct() async {
        do {
            let storeProducts = try await Product.products(for: [productID])
            product = storeProducts.first
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func purchase() async -> Bool {
        guard let product else { return false }

        isLoading = true
        defer { isLoading = false }

        do {
            let result = try await product.purchase()

            switch result {
            case .success(let verification):
                let transaction = try checkVerified(verification)
                isPro = true
                await transaction.finish()
                return true
            case .userCancelled:
                return false
            case .pending:
                return false
            @unknown default:
                return false
            }
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }

    func restorePurchases() async {
        isLoading = true
        defer { isLoading = false }

        do {
            try await AppStore.sync()
            await updatePurchaseStatus()
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    private func listenForTransactions() -> Task<Void, Never> {
        Task.detached { [weak self] in
            for await result in StoreKit.Transaction.updates {
                guard let self else { return }
                let transaction: StoreKit.Transaction
                switch result {
                case .verified(let safe):
                    transaction = safe
                case .unverified:
                    continue
                }
                await self.updatePurchaseStatus()
                await transaction.finish()
            }
        }
    }

    private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreError.failedVerification
        case .verified(let safe):
            return safe
        }
    }

    private func updatePurchaseStatus() async {
        for await result in StoreKit.Transaction.currentEntitlements {
            if let transaction = try? checkVerified(result) {
                if transaction.productID == productID {
                    isPro = true
                    return
                }
            }
        }
    }

    var canAddSubscription: Bool {
        isPro
    }

    func isWithinFreeLimit(count: Int) -> Bool {
        count < AppConstants.freeSubscriptionLimit
    }
}

enum StoreError: Error {
    case failedVerification
}
