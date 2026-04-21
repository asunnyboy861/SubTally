import Foundation

struct CancelGuideData {
    static let allGuides: [CancelGuide] = [
        CancelGuide(
            serviceName: "Netflix",
            serviceIcon: "tv.fill",
            category: .streaming,
            website: "https://netflix.com",
            steps: [
                CancelStep(order: 1, instruction: "Go to netflix.com and sign in"),
                CancelStep(order: 2, instruction: "Click your profile icon in the top right"),
                CancelStep(order: 3, instruction: "Select 'Account' from the dropdown menu"),
                CancelStep(order: 4, instruction: "Click 'Cancel Membership' under Membership & Billing"),
                CancelStep(order: 5, instruction: "Click 'Finish Cancellation' to confirm")
            ],
            difficulty: .easy,
            estimatedTime: "1-2 min",
            tips: ["You can continue watching until the end of your billing period"]
        ),
        CancelGuide(
            serviceName: "Spotify",
            serviceIcon: "music.note",
            category: .music,
            website: "https://spotify.com",
            steps: [
                CancelStep(order: 1, instruction: "Go to spotify.com and log in"),
                CancelStep(order: 2, instruction: "Click 'Profile' then 'Account'"),
                CancelStep(order: 3, instruction: "Scroll down to 'Your Plan'"),
                CancelStep(order: 4, instruction: "Click 'Change Plan'"),
                CancelStep(order: 5, instruction: "Scroll down and select 'Cancel Premium'"),
                CancelStep(order: 6, instruction: "Click 'Yes, Cancel' to confirm")
            ],
            difficulty: .easy,
            estimatedTime: "1-2 min",
            tips: ["You'll keep Premium benefits until your next billing date"]
        ),
        CancelGuide(
            serviceName: "Disney+",
            serviceIcon: "tv.fill",
            category: .streaming,
            website: "https://disneyplus.com",
            steps: [
                CancelStep(order: 1, instruction: "Go to disneyplus.com and log in"),
                CancelStep(order: 2, instruction: "Click your profile icon"),
                CancelStep(order: 3, instruction: "Select 'Account'"),
                CancelStep(order: 4, instruction: "Click 'Cancel Subscription'"),
                CancelStep(order: 5, instruction: "Confirm cancellation")
            ],
            difficulty: .easy,
            estimatedTime: "1-2 min"
        ),
        CancelGuide(
            serviceName: "Amazon Prime",
            serviceIcon: "box.fill",
            category: .streaming,
            website: "https://amazon.com",
            steps: [
                CancelStep(order: 1, instruction: "Go to amazon.com and log in"),
                CancelStep(order: 2, instruction: "Go to 'Account & Lists' > 'Membership & Subscriptions'"),
                CancelStep(order: 3, instruction: "Find 'Prime Membership' and click 'Manage Membership'"),
                CancelStep(order: 4, instruction: "Click 'End Membership'"),
                CancelStep(order: 5, instruction: "Confirm by clicking 'Continue to Cancel'"),
                CancelStep(order: 6, instruction: "Click 'Cancel Membership' on the final page")
            ],
            difficulty: .medium,
            estimatedTime: "3-5 min",
            tips: ["Amazon makes it intentionally difficult. Stay persistent through the confirmation pages"]
        ),
        CancelGuide(
            serviceName: "Hulu",
            serviceIcon: "tv.fill",
            category: .streaming,
            website: "https://hulu.com",
            steps: [
                CancelStep(order: 1, instruction: "Go to hulu.com and log in"),
                CancelStep(order: 2, instruction: "Click your name in the top right"),
                CancelStep(order: 3, instruction: "Select 'Account'"),
                CancelStep(order: 4, instruction: "Scroll to 'Your Subscription'"),
                CancelStep(order: 5, instruction: "Click 'Cancel' next to your plan"),
                CancelStep(order: 6, instruction: "Confirm cancellation")
            ],
            difficulty: .easy,
            estimatedTime: "1-2 min"
        ),
        CancelGuide(
            serviceName: "Apple Music",
            serviceIcon: "music.note",
            category: .music,
            website: "https://apple.com/apple-music",
            steps: [
                CancelStep(order: 1, instruction: "Open Settings on your iPhone"),
                CancelStep(order: 2, instruction: "Tap your name at the top"),
                CancelStep(order: 3, instruction: "Tap 'Subscriptions'"),
                CancelStep(order: 4, instruction: "Find and tap 'Apple Music'"),
                CancelStep(order: 5, instruction: "Tap 'Cancel Subscription'"),
                CancelStep(order: 6, instruction: "Confirm cancellation")
            ],
            difficulty: .easy,
            estimatedTime: "1-2 min"
        ),
        CancelGuide(
            serviceName: "YouTube Premium",
            serviceIcon: "play.rectangle.fill",
            category: .streaming,
            website: "https://youtube.com",
            steps: [
                CancelStep(order: 1, instruction: "Go to youtube.com and sign in"),
                CancelStep(order: 2, instruction: "Click your profile picture"),
                CancelStep(order: 3, instruction: "Click 'Purchases and memberships'"),
                CancelStep(order: 4, instruction: "Find 'YouTube Premium' and click 'Manage'"),
                CancelStep(order: 5, instruction: "Click 'Deactivate'"),
                CancelStep(order: 6, instruction: "Click 'Continue to cancel' and confirm")
            ],
            difficulty: .easy,
            estimatedTime: "2-3 min"
        ),
        CancelGuide(
            serviceName: "iCloud+",
            serviceIcon: "cloud.fill",
            category: .cloud,
            website: "https://icloud.com",
            steps: [
                CancelStep(order: 1, instruction: "Open Settings on your iPhone"),
                CancelStep(order: 2, instruction: "Tap your name at the top"),
                CancelStep(order: 3, instruction: "Tap 'iCloud'"),
                CancelStep(order: 4, instruction: "Tap 'Manage Account Storage'"),
                CancelStep(order: 5, instruction: "Tap 'Change Storage Plan'"),
                CancelStep(order: 6, instruction: "Tap 'Downgrade Options' and select the free plan")
            ],
            difficulty: .easy,
            estimatedTime: "1-2 min",
            tips: ["Your data beyond 5GB may be deleted after downgrading"]
        ),
        CancelGuide(
            serviceName: "HBO Max",
            serviceIcon: "tv.fill",
            category: .streaming,
            website: "https://max.com",
            steps: [
                CancelStep(order: 1, instruction: "Go to max.com and sign in"),
                CancelStep(order: 2, instruction: "Click your profile icon"),
                CancelStep(order: 3, instruction: "Select 'Settings'"),
                CancelStep(order: 4, instruction: "Click 'Subscription'"),
                CancelStep(order: 5, instruction: "Click 'Cancel Subscription'"),
                CancelStep(order: 6, instruction: "Confirm cancellation")
            ],
            difficulty: .easy,
            estimatedTime: "1-2 min"
        ),
        CancelGuide(
            serviceName: "Adobe Creative Cloud",
            serviceIcon: "paintbrush.fill",
            category: .productivity,
            website: "https://account.adobe.com",
            steps: [
                CancelStep(order: 1, instruction: "Go to account.adobe.com and sign in"),
                CancelStep(order: 2, instruction: "Navigate to 'Plans'"),
                CancelStep(order: 3, instruction: "Click 'Manage Plan'"),
                CancelStep(order: 4, instruction: "Click 'Cancel Plan'"),
                CancelStep(order: 5, instruction: "Select a reason for cancellation"),
                CancelStep(order: 6, instruction: "Confirm cancellation")
            ],
            difficulty: .medium,
            estimatedTime: "3-5 min",
            tips: ["Adobe may charge an early termination fee for annual plans"]
        ),
        CancelGuide(
            serviceName: "Microsoft 365",
            serviceIcon: "laptopcomputer",
            category: .productivity,
            website: "https://account.microsoft.com",
            steps: [
                CancelStep(order: 1, instruction: "Go to account.microsoft.com and sign in"),
                CancelStep(order: 2, instruction: "Click 'Subscriptions'"),
                CancelStep(order: 3, instruction: "Find 'Microsoft 365' and click 'Manage'"),
                CancelStep(order: 4, instruction: "Click 'Cancel' or 'Turn off recurring billing'"),
                CancelStep(order: 5, instruction: "Confirm your choice")
            ],
            difficulty: .easy,
            estimatedTime: "2-3 min"
        ),
        CancelGuide(
            serviceName: "PlayStation Plus",
            serviceIcon: "gamecontroller.fill",
            category: .gaming,
            website: "https://playstation.com",
            steps: [
                CancelStep(order: 1, instruction: "Go to playstation.com and sign in"),
                CancelStep(order: 2, instruction: "Go to 'Settings' > 'Account Management'"),
                CancelStep(order: 3, instruction: "Click 'Account Information'"),
                CancelStep(order: 4, instruction: "Click 'PlayStation Subscriptions'"),
                CancelStep(order: 5, instruction: "Select 'Turn Off Auto-Renew'"),
                CancelStep(order: 6, instruction: "Confirm your choice")
            ],
            difficulty: .easy,
            estimatedTime: "2-3 min"
        ),
        CancelGuide(
            serviceName: "Xbox Game Pass",
            serviceIcon: "gamecontroller.fill",
            category: .gaming,
            website: "https://xbox.com",
            steps: [
                CancelStep(order: 1, instruction: "Go to xbox.com and sign in"),
                CancelStep(order: 2, instruction: "Click your profile > 'Subscriptions'"),
                CancelStep(order: 3, instruction: "Find 'Xbox Game Pass'"),
                CancelStep(order: 4, instruction: "Click 'Manage'"),
                CancelStep(order: 5, instruction: "Click 'Cancel subscription'"),
                CancelStep(order: 6, instruction: "Confirm cancellation")
            ],
            difficulty: .easy,
            estimatedTime: "2-3 min"
        ),
        CancelGuide(
            serviceName: "Peloton",
            serviceIcon: "figure.run",
            category: .fitness,
            website: "https://members.onepeloton.com",
            steps: [
                CancelStep(order: 1, instruction: "Go to members.onepeloton.com and log in"),
                CancelStep(order: 2, instruction: "Click your name > 'Settings'"),
                CancelStep(order: 3, instruction: "Click 'Subscription'"),
                CancelStep(order: 4, instruction: "Click 'Cancel Subscription'"),
                CancelStep(order: 5, instruction: "Follow the prompts to confirm")
            ],
            difficulty: .medium,
            estimatedTime: "3-5 min"
        ),
        CancelGuide(
            serviceName: "New York Times",
            serviceIcon: "newspaper.fill",
            category: .news,
            website: "https://nytimes.com",
            steps: [
                CancelStep(order: 1, instruction: "Go to nytimes.com and log in"),
                CancelStep(order: 2, instruction: "Click your name > 'Account'"),
                CancelStep(order: 3, instruction: "Scroll to 'Subscriptions'"),
                CancelStep(order: 4, instruction: "Click 'Cancel' next to your subscription"),
                CancelStep(order: 5, instruction: "Confirm cancellation")
            ],
            difficulty: .medium,
            estimatedTime: "3-5 min",
            tips: ["NYT may offer a discount to stay. You can accept or decline."]
        ),
        CancelGuide(
            serviceName: "DoorDash DashPass",
            serviceIcon: "fork.knife",
            category: .food,
            website: "https://doordash.com",
            steps: [
                CancelStep(order: 1, instruction: "Open the DoorDash app"),
                CancelStep(order: 2, instruction: "Tap your profile icon"),
                CancelStep(order: 3, instruction: "Tap 'Manage DashPass'"),
                CancelStep(order: 4, instruction: "Tap 'End Subscription'"),
                CancelStep(order: 5, instruction: "Confirm cancellation")
            ],
            difficulty: .easy,
            estimatedTime: "1-2 min"
        ),
        CancelGuide(
            serviceName: "Audible",
            serviceIcon: "headphones",
            category: .other,
            website: "https://audible.com",
            steps: [
                CancelStep(order: 1, instruction: "Go to audible.com and log in"),
                CancelStep(order: 2, instruction: "Click your name > 'Account Details'"),
                CancelStep(order: 3, instruction: "Click 'Cancel membership' at the bottom"),
                CancelStep(order: 4, instruction: "Follow the prompts to confirm"),
                CancelStep(order: 5, instruction: "Use any remaining credits before they expire")
            ],
            difficulty: .medium,
            estimatedTime: "3-5 min",
            tips: ["Use all your credits before cancelling - they expire with your membership"]
        ),
        CancelGuide(
            serviceName: "Crunchyroll",
            serviceIcon: "tv.fill",
            category: .streaming,
            website: "https://crunchyroll.com",
            steps: [
                CancelStep(order: 1, instruction: "Go to crunchyroll.com and log in"),
                CancelStep(order: 2, instruction: "Click your profile > 'Settings'"),
                CancelStep(order: 3, instruction: "Click 'Subscription'"),
                CancelStep(order: 4, instruction: "Click 'Cancel Subscription'"),
                CancelStep(order: 5, instruction: "Confirm cancellation")
            ],
            difficulty: .easy,
            estimatedTime: "1-2 min"
        ),
        CancelGuide(
            serviceName: "LinkedIn Premium",
            serviceIcon: "person.fill",
            category: .productivity,
            website: "https://linkedin.com",
            steps: [
                CancelStep(order: 1, instruction: "Go to linkedin.com and log in"),
                CancelStep(order: 2, instruction: "Click 'Me' icon at the top"),
                CancelStep(order: 3, instruction: "Click 'Settings & Privacy'"),
                CancelStep(order: 4, instruction: "Click 'Premium Subscription Settings'"),
                CancelStep(order: 5, instruction: "Click 'Cancel subscription'"),
                CancelStep(order: 6, instruction: "Confirm cancellation")
            ],
            difficulty: .easy,
            estimatedTime: "2-3 min"
        ),
        CancelGuide(
            serviceName: "Grammarly",
            serviceIcon: "textformat.abc",
            category: .productivity,
            website: "https://grammarly.com",
            steps: [
                CancelStep(order: 1, instruction: "Go to grammarly.com and log in"),
                CancelStep(order: 2, instruction: "Click 'Account' > 'Subscription'"),
                CancelStep(order: 3, instruction: "Click 'Cancel Subscription'"),
                CancelStep(order: 4, instruction: "Follow the prompts to confirm")
            ],
            difficulty: .easy,
            estimatedTime: "1-2 min"
        ),
        CancelGuide(
            serviceName: "Dropbox",
            serviceIcon: "cloud.fill",
            category: .cloud,
            website: "https://dropbox.com",
            steps: [
                CancelStep(order: 1, instruction: "Go to dropbox.com and log in"),
                CancelStep(order: 2, instruction: "Click your avatar > 'Settings'"),
                CancelStep(order: 3, instruction: "Click 'Plan'"),
                CancelStep(order: 4, instruction: "Click 'Cancel plan'"),
                CancelStep(order: 5, instruction: "Follow the prompts to confirm")
            ],
            difficulty: .easy,
            estimatedTime: "2-3 min"
        ),
        CancelGuide(
            serviceName: "Paramount+",
            serviceIcon: "tv.fill",
            category: .streaming,
            website: "https://paramountplus.com",
            steps: [
                CancelStep(order: 1, instruction: "Go to paramountplus.com and log in"),
                CancelStep(order: 2, instruction: "Click your name > 'Account'"),
                CancelStep(order: 3, instruction: "Click 'Cancel Subscription'"),
                CancelStep(order: 4, instruction: "Confirm cancellation")
            ],
            difficulty: .easy,
            estimatedTime: "1-2 min"
        ),
        CancelGuide(
            serviceName: "Peacock",
            serviceIcon: "tv.fill",
            category: .streaming,
            website: "https://peacocktv.com",
            steps: [
                CancelStep(order: 1, instruction: "Go to peacocktv.com and log in"),
                CancelStep(order: 2, instruction: "Click your profile > 'Account'"),
                CancelStep(order: 3, instruction: "Click 'Change or Cancel Plan'"),
                CancelStep(order: 4, instruction: "Select 'Peacock Free' to downgrade"),
                CancelStep(order: 5, instruction: "Confirm the change")
            ],
            difficulty: .easy,
            estimatedTime: "1-2 min"
        ),
        CancelGuide(
            serviceName: "ESPN+",
            serviceIcon: "sportscourt.fill",
            category: .streaming,
            website: "https://espn.com",
            steps: [
                CancelStep(order: 1, instruction: "Go to plus.espn.com and log in"),
                CancelStep(order: 2, instruction: "Click your profile > 'Account'"),
                CancelStep(order: 3, instruction: "Click 'Manage Subscription'"),
                CancelStep(order: 4, instruction: "Click 'Cancel Subscription'"),
                CancelStep(order: 5, instruction: "Confirm cancellation")
            ],
            difficulty: .easy,
            estimatedTime: "2-3 min"
        ),
        CancelGuide(
            serviceName: "Slack",
            serviceIcon: "message.fill",
            category: .productivity,
            website: "https://slack.com",
            steps: [
                CancelStep(order: 1, instruction: "Go to slack.com and log in"),
                CancelStep(order: 2, instruction: "Click your workspace name > 'Settings'"),
                CancelStep(order: 3, instruction: "Click 'Billing'"),
                CancelStep(order: 4, instruction: "Click 'Downgrade to Free'"),
                CancelStep(order: 5, instruction: "Confirm the downgrade")
            ],
            difficulty: .medium,
            estimatedTime: "3-5 min"
        ),
        CancelGuide(
            serviceName: "Notion",
            serviceIcon: "note.text",
            category: .productivity,
            website: "https://notion.so",
            steps: [
                CancelStep(order: 1, instruction: "Go to notion.so and log in"),
                CancelStep(order: 2, instruction: "Click 'Settings & Members'"),
                CancelStep(order: 3, instruction: "Click 'Billing'"),
                CancelStep(order: 4, instruction: "Click 'Downgrade' to the free plan"),
                CancelStep(order: 5, instruction: "Confirm the change")
            ],
            difficulty: .easy,
            estimatedTime: "2-3 min"
        ),
        CancelGuide(
            serviceName: "Canva",
            serviceIcon: "paintpalette.fill",
            category: .productivity,
            website: "https://canva.com",
            steps: [
                CancelStep(order: 1, instruction: "Go to canva.com and log in"),
                CancelStep(order: 2, instruction: "Click your profile > 'Account settings'"),
                CancelStep(order: 3, instruction: "Click 'Billing & Plans'"),
                CancelStep(order: 4, instruction: "Click 'Cancel subscription'"),
                CancelStep(order: 5, instruction: "Confirm cancellation")
            ],
            difficulty: .easy,
            estimatedTime: "1-2 min"
        ),
        CancelGuide(
            serviceName: "Spotify Family",
            serviceIcon: "person.2.fill",
            category: .music,
            website: "https://spotify.com",
            steps: [
                CancelStep(order: 1, instruction: "Go to spotify.com and log in"),
                CancelStep(order: 2, instruction: "Click 'Profile' then 'Account'"),
                CancelStep(order: 3, instruction: "Scroll down to 'Your Plan'"),
                CancelStep(order: 4, instruction: "Click 'Change Plan'"),
                CancelStep(order: 5, instruction: "Select 'Cancel Premium'"),
                CancelStep(order: 6, instruction: "All family members will lose Premium access")
            ],
            difficulty: .medium,
            estimatedTime: "2-3 min",
            tips: ["All family members will be notified and lose Premium access"]
        ),
        CancelGuide(
            serviceName: "Apple TV+",
            serviceIcon: "tv.fill",
            category: .streaming,
            website: "https://tv.apple.com",
            steps: [
                CancelStep(order: 1, instruction: "Open Settings on your iPhone"),
                CancelStep(order: 2, instruction: "Tap your name at the top"),
                CancelStep(order: 3, instruction: "Tap 'Subscriptions'"),
                CancelStep(order: 4, instruction: "Find and tap 'Apple TV+'"),
                CancelStep(order: 5, instruction: "Tap 'Cancel Subscription'"),
                CancelStep(order: 6, instruction: "Confirm cancellation")
            ],
            difficulty: .easy,
            estimatedTime: "1-2 min"
        ),
        CancelGuide(
            serviceName: "Gym Membership",
            serviceIcon: "figure.run",
            category: .fitness,
            phoneNumber: "Varies by location",
            steps: [
                CancelStep(order: 1, instruction: "Check your contract for cancellation terms"),
                CancelStep(order: 2, instruction: "Visit your gym in person or call"),
                CancelStep(order: 3, instruction: "Submit a written cancellation request"),
                CancelStep(order: 4, instruction: "Get confirmation in writing"),
                CancelStep(order: 5, instruction: "Check your bank statement to confirm cancellation")
            ],
            difficulty: .veryHard,
            estimatedTime: "5-30 min",
            tips: ["Many gyms require 30-day written notice. Send via certified mail for proof."]
        ),
        CancelGuide(
            serviceName: "Kindle Unlimited",
            serviceIcon: "book.fill",
            category: .education,
            website: "https://amazon.com",
            steps: [
                CancelStep(order: 1, instruction: "Go to amazon.com and log in"),
                CancelStep(order: 2, instruction: "Go to 'Account & Lists' > 'Membership & Subscriptions'"),
                CancelStep(order: 3, instruction: "Find 'Kindle Unlimited' and click 'Manage'"),
                CancelStep(order: 4, instruction: "Click 'Cancel Kindle Unlimited Membership'"),
                CancelStep(order: 5, instruction: "Confirm cancellation")
            ],
            difficulty: .easy,
            estimatedTime: "1-2 min",
            tips: ["You keep access until the end of your current billing period"]
        ),
        CancelGuide(
            serviceName: "Uber One",
            serviceIcon: "car.fill",
            category: .food,
            website: "https://uber.com",
            steps: [
                CancelStep(order: 1, instruction: "Open the Uber app"),
                CancelStep(order: 2, instruction: "Tap 'Account' > 'Uber One'"),
                CancelStep(order: 3, instruction: "Tap 'Manage membership'"),
                CancelStep(order: 4, instruction: "Tap 'End membership'"),
                CancelStep(order: 5, instruction: "Confirm cancellation")
            ],
            difficulty: .easy,
            estimatedTime: "1-2 min"
        )
    ]

    static func guide(for serviceName: String) -> CancelGuide? {
        allGuides.first { $0.serviceName.lowercased() == serviceName.lowercased() }
    }

    static func guides(for category: SubscriptionCategory) -> [CancelGuide] {
        allGuides.filter { $0.category == category }
    }
}
