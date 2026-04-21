import Foundation

enum SubscriptionCategory: String, Codable, CaseIterable {
    case streaming = "Streaming"
    case music = "Music"
    case productivity = "Productivity"
    case gaming = "Gaming"
    case fitness = "Fitness"
    case news = "News"
    case cloud = "Cloud Storage"
    case utility = "Utilities"
    case education = "Education"
    case food = "Food & Delivery"
    case other = "Other"

    var icon: String {
        switch self {
        case .streaming: return "tv.fill"
        case .music: return "music.note"
        case .productivity: return "laptopcomputer"
        case .gaming: return "gamecontroller.fill"
        case .fitness: return "figure.run"
        case .news: return "newspaper.fill"
        case .cloud: return "cloud.fill"
        case .utility: return "bolt.fill"
        case .education: return "book.fill"
        case .food: return "fork.knife"
        case .other: return "square.grid.2x2.fill"
        }
    }

    var colorHex: String {
        switch self {
        case .streaming: return "#E50914"
        case .music: return "#1DB954"
        case .productivity: return "#0078D4"
        case .gaming: return "#107C10"
        case .fitness: return "#FC3C44"
        case .news: return "#FF6600"
        case .cloud: return "#00A1F1"
        case .utility: return "#FFB900"
        case .education: return "#7B68EE"
        case .food: return "#FF6347"
        case .other: return "#8E8E93"
        }
    }
}
