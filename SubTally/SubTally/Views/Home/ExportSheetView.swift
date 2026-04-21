import SwiftUI

struct ExportSheetView: View {
    let subscriptions: [Subscription]
    @Environment(\.dismiss) private var dismiss
    @State private var exportedURL: URL?
    @State private var showingShareSheet = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Image(systemName: "square.and.arrow.up")
                    .font(.system(size: 48))
                    .foregroundStyle(Color.accentColor)

                Text("Export Subscriptions")
                    .font(.title2.weight(.bold))

                Text("Export your subscription data as a CSV file that can be opened in Numbers, Excel, or Google Sheets.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Export includes:")
                        .font(.subheadline.weight(.medium))
                    Text("• Subscription name & category")
                    Text("• Amount & billing cycle")
                    Text("• Next billing date")
                    Text("• Monthly equivalent")
                    Text("• Active/trial status")
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

                Spacer()

                Button {
                    exportedURL = ExportManager.exportToCSV(subscriptions: subscriptions)
                    if exportedURL != nil {
                        showingShareSheet = true
                    }
                } label: {
                    Text("Export CSV")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundStyle(.white)
                        .cornerRadius(14)
                }
                .padding(.horizontal)
            }
            .padding()
            .navigationTitle("Export")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
            .sheet(isPresented: $showingShareSheet) {
                if let url = exportedURL {
                    ShareSheet(items: [url])
                }
            }
        }
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
