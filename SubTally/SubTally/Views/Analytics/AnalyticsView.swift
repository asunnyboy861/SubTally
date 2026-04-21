import SwiftUI
import SwiftData

struct AnalyticsView: View {
    @Query(filter: #Predicate<Subscription> { $0.isActive },
           sort: \Subscription.nextBillingDate) private var subscriptions: [Subscription]
    @StateObject private var viewModel = AnalyticsViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    periodPicker
                    totalCard
                    categoryBreakdownCard
                    billingCycleCard
                    upcomingPaymentsCard
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Analytics")
            .onChange(of: subscriptions) { _, newValue in
                viewModel.updateSubscriptions(from: newValue)
            }
        }
    }

    private var periodPicker: some View {
        Picker("Period", selection: $viewModel.selectedPeriod) {
            ForEach(AnalyticsViewModel.TimePeriod.allCases, id: \.self) { period in
                Text(period.rawValue).tag(period)
            }
        }
        .pickerStyle(.segmented)
    }

    private var totalCard: some View {
        VStack(spacing: 8) {
            Text(viewModel.selectedPeriod.rawValue + " Total")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Text(viewModel.totalForPeriod.asCurrency)
                .font(.system(size: 40, weight: .bold, design: .rounded))
        }
        .frame(maxWidth: .infinity)
        .padding(24)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.04), radius: 8, x: 0, y: 2)
    }

    private var categoryBreakdownCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("By Category")
                .font(.headline)

            if viewModel.categoryData.isEmpty {
                Text("No data")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            } else {
                let maxAmount = viewModel.categoryData.map(\.1).max() ?? 1

                ForEach(viewModel.categoryData, id: \.0) { category, amount, percentage in
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Label(category.rawValue, systemImage: category.icon)
                                .font(.subheadline)
                            Spacer()
                            Text(amount.asCurrency)
                                .font(.subheadline.weight(.medium))
                            Text("(\(Int(percentage))%)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }

                        GeometryReader { geo in
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color(hex: category.colorHex))
                                .frame(width: geo.size.width * (amount / maxAmount).doubleValue, height: 8)
                        }
                        .frame(height: 8)
                    }
                }
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }

    private var billingCycleCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("By Billing Cycle")
                .font(.headline)

            if viewModel.billingCycleBreakdown.isEmpty {
                Text("No data")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            } else {
                ForEach(viewModel.billingCycleBreakdown, id: \.0) { cycle, count, total in
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(cycle.displayName)
                                .font(.subheadline.weight(.medium))
                            Text("\(count) subscription\(count > 1 ? "s" : "")")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Text(total.asCurrency + "/mo")
                            .font(.subheadline.weight(.medium))
                    }
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }

    private var upcomingPaymentsCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Upcoming Payments")
                .font(.headline)

            if viewModel.upcomingPayments.isEmpty {
                Text("No upcoming payments")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            } else {
                ForEach(viewModel.upcomingPayments, id: \.0) { name, amount, date in
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(name)
                                .font(.subheadline.weight(.medium))
                            Text(date.formattedMonthDay)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Text(amount.asCurrency)
                            .font(.subheadline.weight(.semibold))
                    }
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
}
