import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var subscriptions: [Subscription]
    @StateObject private var viewModel = SettingsViewModel()
    @StateObject private var purchaseManager = PurchaseManager()
    @StateObject private var biometricAuth = BiometricAuthManager()
    @StateObject private var calendarManager = CalendarManager()
    @State private var showingDeleteAlert = false
    @State private var showingPaywall = false

    var body: some View {
        NavigationStack {
            Form {
                proSection
                securitySection
                defaultsSection
                dataSection
                aboutSection
                supportSection
            }
            .navigationTitle("Settings")
        }
    }

    private var proSection: some View {
        Section {
            if purchaseManager.isPro {
                HStack {
                    Image(systemName: "crown.fill")
                        .foregroundStyle(.yellow)
                    Text("SubTally Pro")
                        .font(.headline)
                    Spacer()
                    Text("Active")
                        .font(.subheadline)
                        .foregroundStyle(.green)
                }
            } else {
                Button {
                    showingPaywall = true
                } label: {
                    HStack {
                        Image(systemName: "crown")
                            .foregroundStyle(.yellow)
                        Text("Upgrade to Pro")
                            .font(.headline)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        } header: {
            Text("Subscription")
        }
        .sheet(isPresented: $showingPaywall) {
            PaywallView(purchaseManager: purchaseManager)
        }
    }

    private var securitySection: some View {
        Section {
            if biometricAuth.isBiometricAvailable {
                Toggle(biometricAuth.biometricType == .faceID ? "Require Face ID" : "Require Touch ID",
                       isOn: $viewModel.biometricLockEnabled)
            }
        } header: {
            Text("Security")
        }
    }

    private var defaultsSection: some View {
        Section {
            Stepper("Remind \(viewModel.defaultRemindDaysBefore) days before",
                    value: $viewModel.defaultRemindDaysBefore, in: 1...30)
        } header: {
            Text("Defaults")
        }
    }

    private var dataSection: some View {
        Section {
            NavigationLink {
                CancelGuidesListView()
            } label: {
                Label("Cancel Guides", systemImage: "xmark.circle")
            }

            Button {
                if let url = ExportManager.exportToCSV(subscriptions: subscriptions) {
                    let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let rootVC = windowScene.windows.first?.rootViewController {
                        rootVC.present(activityVC, animated: true)
                    }
                }
            } label: {
                Label("Export Data (CSV)", systemImage: "square.and.arrow.up")
            }

            Button("Delete All Data", role: .destructive) {
                showingDeleteAlert = true
            }
        } header: {
            Text("Data")
        }
        .alert("Delete All Data?", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                deleteAllData()
            }
        } message: {
            Text("This will permanently remove all subscriptions and related data.")
        }
    }

    private var aboutSection: some View {
        Section {
            HStack {
                Text("Version")
                Spacer()
                Text(viewModel.versionString)
                    .foregroundStyle(.secondary)
            }

            Link(destination: URL(string: AppConstants.privacyPolicyURL)!) {
                Label("Privacy Policy", systemImage: "hand.raised")
            }

            Link(destination: URL(string: AppConstants.termsOfUseURL)!) {
                Label("Terms of Use", systemImage: "doc.text")
            }
        } header: {
            Text("About")
        }
    }

    private var supportSection: some View {
        Section {
            Link(destination: URL(string: "mailto:\(AppConstants.contactEmail)")!) {
                Label("Contact Support", systemImage: "envelope")
            }

            Link(destination: URL(string: AppConstants.supportURL)!) {
                Label("Support Page", systemImage: "questionmark.circle")
            }
        } header: {
            Text("Support")
        }
    }

    private func deleteAllData() {
        for sub in subscriptions {
            modelContext.delete(sub)
        }
    }
}

struct CancelGuidesListView: View {
    let guides = CancelGuideData.allGuides

    @State private var searchText = ""
    @State private var selectedCategory: SubscriptionCategory?

    var filteredGuides: [CancelGuide] {
        var result = guides
        if !searchText.isEmpty {
            result = result.filter { $0.serviceName.localizedCaseInsensitiveContains(searchText) }
        }
        if let category = selectedCategory {
            result = result.filter { $0.category == category }
        }
        return result
    }

    var body: some View {
        List {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    CategoryFilterChip(category: nil, isSelected: selectedCategory == nil) {
                        selectedCategory = nil
                    }
                    ForEach(SubscriptionCategory.allCases, id: \.self) { category in
                        CategoryFilterChip(category: category, isSelected: selectedCategory == category) {
                            selectedCategory = category
                        }
                    }
                }
                .padding(.vertical, 4)
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))

            ForEach(filteredGuides) { guide in
                NavigationLink {
                    CancelGuideDetailView(guide: guide)
                } label: {
                    HStack(spacing: 12) {
                        Image(systemName: guide.serviceIcon)
                            .foregroundStyle(Color(hex: guide.category.colorHex))
                            .frame(width: 36, height: 36)
                            .background(Color(hex: guide.category.colorHex).opacity(0.15))
                            .cornerRadius(10)

                        VStack(alignment: .leading, spacing: 2) {
                            Text(guide.serviceName)
                                .font(.subheadline.weight(.medium))
                            Text("\(guide.steps.count) steps · \(guide.estimatedTime)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }

                        Spacer()

                        Text(guide.difficulty.rawValue)
                            .font(.caption2.weight(.bold))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(difficultyBackground(guide.difficulty))
                            .foregroundStyle(difficultyForeground(guide.difficulty))
                            .cornerRadius(6)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search services")
        .navigationTitle("Cancel Guides")
    }

    private func difficultyBackground(_ difficulty: CancelDifficulty) -> Color {
        switch difficulty {
        case .easy: return .green.opacity(0.15)
        case .medium: return .orange.opacity(0.15)
        case .hard: return .red.opacity(0.15)
        case .veryHard: return .purple.opacity(0.15)
        }
    }

    private func difficultyForeground(_ difficulty: CancelDifficulty) -> Color {
        switch difficulty {
        case .easy: return .green
        case .medium: return .orange
        case .hard: return .red
        case .veryHard: return .purple
        }
    }
}
