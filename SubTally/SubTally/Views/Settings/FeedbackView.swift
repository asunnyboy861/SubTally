import SwiftUI
import MessageUI

struct FeedbackView: View {
    @State private var result: Result<MFMailComposeResult, Error>?
    @State private var isShowingMailView = false
    @State private var isShowingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "envelope.fill")
                .font(.system(size: 48))
                .foregroundStyle(Color.accentColor)

            Text("We'd love to hear from you!")
                .font(.title2.weight(.bold))

            Text("Have a question, suggestion, or found a bug? Send us an email and we'll get back to you as soon as possible.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button {
                if MFMailComposeViewController.canSendMail() {
                    isShowingMailView = true
                } else {
                    alertMessage = "Please set up Mail on your device to send feedback."
                    isShowingAlert = true
                }
            } label: {
                Text("Send Feedback")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundStyle(.white)
                    .cornerRadius(14)
            }
            .padding(.horizontal)

            Button {
                if let url = URL(string: "mailto:\(AppConstants.contactEmail)?subject=SubTally%20Feedback") {
                    UIApplication.shared.open(url)
                }
            } label: {
                Text("Open in Mail App")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Feedback")
        .sheet(isPresented: $isShowingMailView) {
            MailView(result: $result)
        }
        .alert("Feedback", isPresented: $isShowingAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(alertMessage)
        }
    }
}

struct MailView: UIViewControllerRepresentable {
    @Binding var result: Result<MFMailComposeResult, Error>?

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        vc.setToRecipients([AppConstants.contactEmail])
        vc.setSubject("SubTally Feedback")
        return vc
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        let parent: MailView

        init(_ parent: MailView) { self.parent = parent }

        func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult, error: Error?) {
            if let error {
                parent.result = .failure(error)
            } else {
                parent.result = .success(result)
            }
            controller.dismiss(animated: true)
        }
    }
}
