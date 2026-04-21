import SwiftUI
import SwiftData

struct CalendarView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(filter: #Predicate<Subscription> { $0.isActive },
           sort: \Subscription.nextBillingDate) private var subscriptions: [Subscription]
    @StateObject private var viewModel = CalendarViewModel()

    private let calendar = Calendar.current
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    private let weekdaySymbols = Calendar.current.shortWeekdaySymbols

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    monthNavigation
                    calendarGrid
                    monthSummary
                    daySubscriptionsList
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Calendar")
            .onChange(of: subscriptions) { _, newValue in
                viewModel.updateSubscriptions(from: newValue)
            }
        }
    }

    private var monthNavigation: some View {
        HStack {
            Button {
                withAnimation { viewModel.displayedMonth = calendar.date(byAdding: .month, value: -1, to: viewModel.displayedMonth) ?? viewModel.displayedMonth }
            } label: {
                Image(systemName: "chevron.left")
            }

            Spacer()

            Text(viewModel.displayedMonth.formatted(.dateTime.year().month(.wide)))
                .font(.title3.weight(.semibold))

            Spacer()

            Button {
                withAnimation { viewModel.displayedMonth = calendar.date(byAdding: .month, value: 1, to: viewModel.displayedMonth) ?? viewModel.displayedMonth }
            } label: {
                Image(systemName: "chevron.right")
            }

            Button("Today") {
                viewModel.selectToday()
            }
            .font(.subheadline)
        }
        .padding(.horizontal, 4)
    }

    private var calendarGrid: some View {
        VStack(spacing: 8) {
            HStack(spacing: 4) {
                ForEach(weekdaySymbols, id: \.self) { symbol in
                    Text(symbol)
                        .font(.caption.weight(.medium))
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity)
                }
            }

            LazyVGrid(columns: columns, spacing: 4) {
                let daysInMonth = numberOfDaysInMonth(viewModel.displayedMonth)
                let firstWeekday = calendar.component(.weekday, from: viewModel.displayedMonth.startOfMonth) - 1

                ForEach(0..<(firstWeekday + daysInMonth), id: \.self) { index in
                    if index < firstWeekday {
                        Color.clear.frame(height: 44)
                    } else {
                        let day = index - firstWeekday + 1
                        let date = calendar.date(byAdding: .day, value: day - 1, to: viewModel.displayedMonth.startOfMonth) ?? Date()
                        let hasPayment = viewModel.daysWithPayments.contains(day)
                        let isToday = calendar.isDateInToday(date)
                        let isSelected = calendar.isDate(date, inSameDayAs: viewModel.selectedDate)

                        Button {
                            viewModel.selectedDate = date
                        } label: {
                            ZStack {
                                if isSelected {
                                    Circle()
                                        .fill(Color.accentColor)
                                        .frame(width: 36, height: 36)
                                } else if isToday {
                                    Circle()
                                        .stroke(Color.accentColor, lineWidth: 2)
                                        .frame(width: 36, height: 36)
                                }

                                Text("\(day)")
                                    .font(.subheadline.weight(isSelected ? .bold : .regular))
                                    .foregroundStyle(isSelected ? .white : .primary)

                                if hasPayment {
                                    Circle()
                                        .fill(isSelected ? .white : Color.accentColor)
                                        .frame(width: 5, height: 5)
                                        .offset(y: 14)
                                }
                            }
                            .frame(height: 44)
                        }
                    }
                }
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(16)
    }

    private var monthSummary: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Monthly Total")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(viewModel.totalForMonth.asCurrency)
                    .font(.title2.weight(.bold))
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                Text("Payments")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text("\(viewModel.subscriptionsForMonth.count)")
                    .font(.title2.weight(.bold))
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }

    private var daySubscriptionsList: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(viewModel.selectedDate.formatted(.dateTime.month().day().year()))
                .font(.headline)

            let daySubs = viewModel.subscriptionsForSelectedDate
            if daySubs.isEmpty {
                HStack {
                    Spacer()
                    VStack(spacing: 8) {
                        Image(systemName: "checkmark.circle")
                            .font(.title2)
                            .foregroundStyle(.green)
                        Text("No payments due")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
            } else {
                ForEach(daySubs) { subscription in
                    NavigationLink(value: subscription) {
                        HStack(spacing: 12) {
                            Image(systemName: subscription.icon)
                                .foregroundStyle(Color(hex: subscription.colorHex))
                                .frame(width: 36, height: 36)
                                .background(Color(hex: subscription.colorHex).opacity(0.15))
                                .cornerRadius(10)

                            VStack(alignment: .leading, spacing: 2) {
                                Text(subscription.name)
                                    .font(.subheadline.weight(.medium))
                                Text(subscription.billingCycle.displayName)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }

                            Spacer()

                            Text(subscription.amount.asCurrency)
                                .font(.subheadline.weight(.semibold))
                        }
                        .padding(12)
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                    }
                }
            }
        }
    }

    private func numberOfDaysInMonth(_ date: Date) -> Int {
        guard let range = calendar.range(of: .day, in: .month, for: date) else { return 30 }
        return range.count
    }
}
