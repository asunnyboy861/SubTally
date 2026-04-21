import WidgetKit
import SwiftUI

struct SubscriptionEntry: TimelineEntry {
    let date: Date
    let totalMonthly: String
    let totalYearly: String
    let activeCount: Int
    let nextPayment: String?
    let nextPaymentDate: String?
    let nextPaymentAmount: String?
}

struct SubTallyWidget: Widget {
    let kind: String = "SubTallyWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: SubTallyProvider()) { entry in
            SubTallyWidgetEntryView(entry: entry)
                .containerBackground(for: .widget) {
                    Color(.systemBackground)
                }
        }
        .configurationDisplayName("SubTally")
        .description("Track your subscriptions at a glance.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct SubTallyProvider: TimelineProvider {
    func placeholder(in context: Context) -> SubscriptionEntry {
        SubscriptionEntry(
            date: Date(),
            totalMonthly: "$0.00",
            totalYearly: "$0.00",
            activeCount: 0,
            nextPayment: nil,
            nextPaymentDate: nil,
            nextPaymentAmount: nil
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (SubscriptionEntry) -> Void) {
        let entry = loadEntry()
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SubscriptionEntry>) -> Void) {
        let entry = loadEntry()
        let nextUpdate = Calendar.current.date(byAdding: .hour, value: 4, to: Date()) ?? Date()
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }

    private func loadEntry() -> SubscriptionEntry {
        let defaults = UserDefaults(suiteName: "group.com.zzoutuo.SubTally")
        let totalMonthly = defaults?.string(forKey: "widget_totalMonthly") ?? "$0.00"
        let totalYearly = defaults?.string(forKey: "widget_totalYearly") ?? "$0.00"
        let activeCount = defaults?.integer(forKey: "widget_activeCount") ?? 0
        let nextPayment = defaults?.string(forKey: "widget_nextPayment")
        let nextPaymentDate = defaults?.string(forKey: "widget_nextPaymentDate")
        let nextPaymentAmount = defaults?.string(forKey: "widget_nextPaymentAmount")

        return SubscriptionEntry(
            date: Date(),
            totalMonthly: totalMonthly,
            totalYearly: totalYearly,
            activeCount: activeCount,
            nextPayment: nextPayment,
            nextPaymentDate: nextPaymentDate,
            nextPaymentAmount: nextPaymentAmount
        )
    }
}

struct SubTallyWidgetEntryView: View {
    let entry: SubscriptionEntry

    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .systemSmall:
            SmallWidgetView(entry: entry)
        case .systemMedium:
            MediumWidgetView(entry: entry)
        default:
            SmallWidgetView(entry: entry)
        }
    }
}

struct SmallWidgetView: View {
    let entry: SubscriptionEntry

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Image(systemName: "dollarsign.circle.fill")
                    .foregroundStyle(.green)
                Text("SubTally")
                    .font(.caption.weight(.semibold))
                Spacer()
            }

            Text(entry.totalMonthly)
                .font(.system(size: 28, weight: .bold, design: .rounded))

            Text("/month")
                .font(.caption2)
                .foregroundStyle(.secondary)

            if let next = entry.nextPayment, let date = entry.nextPaymentDate {
                HStack(spacing: 4) {
                    Image(systemName: "calendar")
                        .font(.caption2)
                    Text("\(next) · \(date)")
                        .font(.caption2)
                        .lineLimit(1)
                }
                .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct MediumWidgetView: View {
    let entry: SubscriptionEntry

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "dollarsign.circle.fill")
                        .foregroundStyle(.green)
                    Text("SubTally")
                        .font(.caption.weight(.semibold))
                }

                Text(entry.totalMonthly)
                    .font(.system(size: 28, weight: .bold, design: .rounded))

                Text("/month")
                    .font(.caption2)
                    .foregroundStyle(.secondary)

                Text("\(entry.activeCount) active")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 8) {
                if let next = entry.nextPayment,
                   let date = entry.nextPaymentDate,
                   let amount = entry.nextPaymentAmount {
                    Text("Next Payment")
                        .font(.caption2.weight(.medium))
                        .foregroundStyle(.secondary)

                    Text(next)
                        .font(.caption.weight(.semibold))
                        .lineLimit(1)

                    Text(amount)
                        .font(.subheadline.weight(.bold))

                    Text(date)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                } else {
                    Text("No upcoming")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Text("\(entry.totalYearly)/yr")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
    }
}

struct SubTallyWidgetBundle: WidgetBundle {
    var body: some Widget {
        SubTallyWidget()
    }
}
