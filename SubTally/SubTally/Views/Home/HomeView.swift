import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(filter: #Predicate<Subscription> { $0.isActive },
           sort: \Subscription.nextBillingDate) private var subscriptions: [Subscription]
    @StateObject private var viewModel = SubscriptionListViewModel()
    @StateObject private var purchaseManager = PurchaseManager()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    summaryCard
                    upcomingSection
                    categoryFilterSection
                    subscriptionList
                }
                .padding(.horizontal)
                .padding(.bottom, 80)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("SubTally")
            .searchable(text: $viewModel.searchText, prompt: "Search subscriptions")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if viewModel.canAddMore(purchaseManager: purchaseManager) {
                            viewModel.showingAddSheet = true
                        } else {
                            viewModel.showingPaywall = true
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        Button { viewModel.showingExportSheet = true } label: {
                            Label("Export CSV", systemImage: "square.and.arrow.up")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
            .sheet(isPresented: $viewModel.showingAddSheet) {
                SubscriptionFormView(mode: .add)
            }
            .sheet(isPresented: $viewModel.showingPaywall) {
                PaywallView(purchaseManager: purchaseManager)
            }
            .sheet(isPresented: $viewModel.showingExportSheet) {
                ExportSheetView(subscriptions: subscriptions)
            }
            .onChange(of: subscriptions) { _, newValue in
                viewModel.updateSubscriptions(from: newValue)
                WidgetDataUpdater.update(subscriptions: newValue)
            }
        }
    }

    private var summaryCard: some View {
        VStack(spacing: 12) {
            Text("Monthly Total")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Text(viewModel.totalMonthly.asCurrency)
                .font(.system(size: 42, weight: .bold, design: .rounded))
                .foregroundStyle(.primary)

            HStack(spacing: 24) {
                VStack(spacing: 4) {
                    Text("Yearly")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(viewModel.totalYearly.asCurrency)
                        .font(.headline)
                        .foregroundStyle(.primary)
                }
                Divider().frame(height: 30)
                VStack(spacing: 4) {
                    Text("Active")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("\(viewModel.activeSubscriptions.count)")
                        .font(.headline)
                        .foregroundStyle(.primary)
                }
                if !viewModel.trialSubscriptions.isEmpty {
                    Divider().frame(height: 30)
                    VStack(spacing: 4) {
                        Text("Trials")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text("\(viewModel.trialSubscriptions.count)")
                            .font(.headline)
                            .foregroundStyle(.orange)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(24)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.04), radius: 8, x: 0, y: 2)
    }

    private var upcomingSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Upcoming This Week")
                .font(.headline)

            if viewModel.upcomingThisWeek.isEmpty {
                HStack {
                    Spacer()
                    VStack(spacing: 8) {
                        Image(systemName: "calendar.badge.checkmark")
                            .font(.title2)
                            .foregroundStyle(.green)
                        Text("No upcoming payments")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
            } else {
                ForEach(viewModel.upcomingThisWeek) { subscription in
                    NavigationLink(value: subscription) {
                        UpcomingRowView(subscription: subscription)
                    }
                }
            }
        }
    }

    private var categoryFilterSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                CategoryFilterChip(
                    category: nil,
                    isSelected: viewModel.selectedCategory == nil
                ) {
                    viewModel.selectedCategory = nil
                }

                ForEach(SubscriptionCategory.allCases, id: \.self) { category in
                    CategoryFilterChip(
                        category: category,
                        isSelected: viewModel.selectedCategory == category
                    ) {
                        viewModel.selectedCategory = category
                    }
                }
            }
        }
    }

    private var subscriptionList: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("All Subscriptions")
                .font(.headline)

            if viewModel.filteredSubscriptions.isEmpty {
                emptyStateView
            } else {
                ForEach(viewModel.filteredSubscriptions) { subscription in
                    NavigationLink(value: subscription) {
                        SubscriptionRowView(subscription: subscription)
                    }
                }
            }
        }
    }

    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "tray")
                .font(.system(size: 48))
                .foregroundStyle(.secondary)
            Text("No subscriptions yet")
                .font(.title3)
                .foregroundStyle(.secondary)
            Text("Tap + to add your first subscription")
                .font(.subheadline)
                .foregroundStyle(.tertiary)
        }
        .frame(maxWidth: .infinity)
        .padding(40)
    }
}

struct CategoryFilterChip: View {
    let category: SubscriptionCategory?
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                if let category {
                    Image(systemName: category.icon)
                } else {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                }
                Text(category?.rawValue ?? "All")
                    .font(.subheadline)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(isSelected ? Color.accentColor : Color(.systemBackground))
            .foregroundStyle(isSelected ? .white : .primary)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(isSelected ? Color.accentColor : Color(.systemGray4), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

struct UpcomingRowView: View {
    let subscription: Subscription

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: subscription.icon)
                .font(.title3)
                .foregroundStyle(Color(hex: subscription.colorHex))
                .frame(width: 36, height: 36)
                .background(Color(hex: subscription.colorHex).opacity(0.15))
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 2) {
                Text(subscription.name)
                    .font(.subheadline.weight(.medium))
                Text(subscription.nextBillingDate.formattedMonthDay)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Text(subscription.amount.asCurrency)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(Color(hex: subscription.colorHex))
        }
        .padding(12)
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
}

struct SubscriptionRowView: View {
    let subscription: Subscription

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: subscription.icon)
                .font(.title3)
                .foregroundStyle(Color(hex: subscription.colorHex))
                .frame(width: 40, height: 40)
                .background(Color(hex: subscription.colorHex).opacity(0.15))
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 6) {
                    Text(subscription.name)
                        .font(.body.weight(.medium))
                    if subscription.isTrial {
                        Text("TRIAL")
                            .font(.caption2.weight(.bold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.orange)
                            .cornerRadius(4)
                    }
                }
                Text("\(subscription.billingCycle.displayName) · \(subscription.category.rawValue)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 2) {
                Text(subscription.amount.asCurrency)
                    .font(.body.weight(.semibold))
                Text(subscription.nextBillingDate.formattedMonthDay)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(12)
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
}
