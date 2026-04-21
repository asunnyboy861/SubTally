import SwiftUI

struct CancelGuideDetailView: View {
    let guide: CancelGuide
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    headerSection
                    difficultySection
                    stepsSection
                    if !guide.tips.isEmpty {
                        tipsSection
                    }
                    if guide.website != nil || guide.phoneNumber != nil {
                        contactSection
                    }
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Cancel Guide")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }

    private var headerSection: some View {
        VStack(spacing: 12) {
            Image(systemName: guide.serviceIcon)
                .font(.system(size: 36))
                .foregroundStyle(Color(hex: guide.category.colorHex))
                .frame(width: 64, height: 64)
                .background(Color(hex: guide.category.colorHex).opacity(0.15))
                .cornerRadius(16)

            Text(guide.serviceName)
                .font(.title2.weight(.bold))

            Text("Estimated time: \(guide.estimatedTime)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(24)
        .background(Color(.systemBackground))
        .cornerRadius(16)
    }

    private var difficultySection: some View {
        HStack {
            Text("Difficulty")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Spacer()
            HStack(spacing: 4) {
                ForEach(0..<4, id: \.self) { index in
                    Image(systemName: "circle.fill")
                        .font(.caption)
                        .foregroundStyle(difficultyColor(for: index))
                }
            }
            Text(guide.difficulty.rawValue)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(difficultyTextColor)
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }

    private func difficultyColor(for index: Int) -> Color {
        let level: Int = switch guide.difficulty {
        case .easy: 1
        case .medium: 2
        case .hard: 3
        case .veryHard: 4
        }
        return index < level ? difficultyTextColor : Color(.systemGray5)
    }

    private var difficultyTextColor: Color {
        switch guide.difficulty {
        case .easy: return .green
        case .medium: return .orange
        case .hard: return .red
        case .veryHard: return .purple
        }
    }

    private var stepsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Steps to Cancel")
                .font(.headline)

            ForEach(guide.steps.sorted { $0.order < $1.order }) { step in
                HStack(alignment: .top, spacing: 12) {
                    Text("\(step.order)")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(.white)
                        .frame(width: 24, height: 24)
                        .background(Color.accentColor)
                        .cornerRadius(12)

                    Text(step.instruction)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(12)
                .background(Color(.systemBackground))
                .cornerRadius(10)
            }
        }
    }

    private var tipsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Tips")
                .font(.headline)

            ForEach(guide.tips, id: \.self) { tip in
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: "lightbulb.fill")
                        .foregroundStyle(.yellow)
                    Text(tip)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(12)
                .background(Color(.systemBackground))
                .cornerRadius(10)
            }
        }
    }

    private var contactSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Contact")
                .font(.headline)

            if let website = guide.website {
                if let url = URL(string: website) {
                    Link(destination: url) {
                        Label(website, systemImage: "globe")
                            .font(.subheadline)
                    }
                }
            }

            if let phone = guide.phoneNumber {
                if let url = URL(string: "tel:\(phone)") {
                    Link(destination: url) {
                        Label(phone, systemImage: "phone")
                            .font(.subheadline)
                    }
                }
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
}
