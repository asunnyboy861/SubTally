import Foundation
import SwiftData

final class ExportManager {
    static func exportToCSV(subscriptions: [Subscription]) -> URL? {
        var csv = "Name,Category,Amount,Currency,Billing Cycle,Next Billing Date,Monthly Equivalent,Active,Trial\n"

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium

        for sub in subscriptions {
            let row = [
                "\"\(sub.name)\"",
                sub.category.rawValue,
                sub.amount.asCurrency,
                sub.currency,
                sub.billingCycle.displayName,
                dateFormatter.string(from: sub.nextBillingDate),
                sub.monthlyEquivalent.asCurrency,
                sub.isActive ? "Yes" : "No",
                sub.isTrial ? "Yes" : "No"
            ].joined(separator: ",")
            csv += row + "\n"
        }

        let tempDir = FileManager.default.temporaryDirectory
        let fileName = "SubTally_Export_\(Date().formatted(.dateTime.year().month().day())).csv"
        let fileURL = tempDir.appendingPathComponent(fileName)

        do {
            try csv.write(to: fileURL, atomically: true, encoding: .utf8)
            return fileURL
        } catch {
            return nil
        }
    }
}
