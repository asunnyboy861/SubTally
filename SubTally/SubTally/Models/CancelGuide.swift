import Foundation

struct CancelStep: Identifiable, Codable {
    let id: UUID
    let order: Int
    let instruction: String

    init(order: Int, instruction: String) {
        self.id = UUID()
        self.order = order
        self.instruction = instruction
    }
}

enum CancelDifficulty: String, Codable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    case veryHard = "Very Hard"
}

struct CancelGuide: Identifiable, Codable {
    let id: UUID
    let serviceName: String
    let serviceIcon: String
    let category: SubscriptionCategory
    let website: String?
    let phoneNumber: String?
    let steps: [CancelStep]
    let difficulty: CancelDifficulty
    let estimatedTime: String
    let tips: [String]

    init(serviceName: String, serviceIcon: String, category: SubscriptionCategory,
         website: String? = nil, phoneNumber: String? = nil,
         steps: [CancelStep], difficulty: CancelDifficulty,
         estimatedTime: String, tips: [String] = []) {
        self.id = UUID()
        self.serviceName = serviceName
        self.serviceIcon = serviceIcon
        self.category = category
        self.website = website
        self.phoneNumber = phoneNumber
        self.steps = steps
        self.difficulty = difficulty
        self.estimatedTime = estimatedTime
        self.tips = tips
    }
}
