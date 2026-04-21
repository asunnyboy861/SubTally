import Foundation

enum BillingCycle: String, Codable, CaseIterable {
    case weekly = "Weekly"
    case monthly = "Monthly"
    case quarterly = "Quarterly"
    case yearly = "Yearly"
    case custom = "Custom"

    var displayName: String { rawValue }

    var shortName: String {
        switch self {
        case .weekly: return "wk"
        case .monthly: return "mo"
        case .quarterly: return "qtr"
        case .yearly: return "yr"
        case .custom: return "custom"
        }
    }
}
