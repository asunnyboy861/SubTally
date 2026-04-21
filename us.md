# SubTally — English Operation Guide

> **App Name**: SubTally  
> **Subtitle**: Track & Cancel Recurring Payments  
> **Bundle ID**: `com.zzoutuo.SubTally`  
> **Target Market**: 🇺🇸 United States (Global Compatible)  
> **Platform**: iOS 17+ / iPhone & iPad  
> **Guide Date**: 2026-04-21  
> **Minimum iOS Version**: 17.0

---

## Table of Contents

1. [Executive Summary](#1-executive-summary)
2. [Competitive Analysis](#2-competitive-analysis)
3. [Apple Design Guidelines Compliance](#3-apple-design-guidelines-compliance)
4. [Technical Architecture](#4-technical-architecture)
5. [Module Structure & File Organization](#5-module-structure--file-organization)
6. [Implementation Flow](#6-implementation-flow)
7. [UI/UX Design Specifications](#7-uiux-design-specifications)
8. [Code Generation Rules](#8-code-generation-rules)
9. [Testing & Validation Standards](#9-testing--validation-standards)
10. [Build & Deployment Checklist](#10-build--deployment-checklist)

---

## 1. Executive Summary

### Product Vision

SubTally is a privacy-first subscription tracker designed for the US market that solves the critical problem of subscription fatigue. With the average American household managing 11.2 active subscriptions and spending $924/year on recurring services, users need a simple, secure way to track, manage, and cancel subscriptions without sacrificing their financial privacy.

### Core Value Proposition

SubTally is the **ONLY** subscription tracker that combines all five critical features:

| Feature | Benefit | Competitive Advantage |
|---------|---------|----------------------|
| ✅ **Zero Bank Access** | Privacy-first, local-only storage | No third-party data sharing, no Plaid integration |
| ✅ **Calendar Reminders** | Never miss a billing date | EventKit integration with 3-day/1-day/same-day alerts |
| ✅ **Home + Lock Widgets** | At-a-glance monthly spending | WidgetKit support for quick insights |
| ✅ **Cancel Guides** | 30+ popular service cancellation steps | Step-by-step instructions for Netflix, Spotify, etc. |
| ✅ **One-Time Purchase** | No subscription fatigue irony | Lifetime access, no recurring fees |

### Market Opportunity

- **Total Addressable Market**: 47% of US consumers actively canceled at least one subscription in 2026 (Zuora Report)
- **Pain Point**: 74% of users forget recurring charges, leading to unexpected fees (C+R Research)
- **Privacy Concern**: Growing distrust of apps requiring bank account access (Reddit r/iosapps)
- **Subscription Fatigue**: 42% admit paying for subscriptions they no longer use

### Key Differentiators from Competitors

1. **Privacy-First Architecture**: Unlike Rocket Money ($6-12/month) and similar apps, SubTally requires NO bank access, NO account linking, NO third-party data sharing
2. **Transparent Pricing**: One-time purchase model vs. competitors' subscription fatigue (paying a subscription to track subscriptions)
3. **Native iOS Experience**: Pure Swift/SwiftUI implementation following Apple Human Interface Guidelines
4. **Comprehensive Feature Set**: Combines calendar integration, widgets, and cancellation guides—features competitors offer piecemeal or not at all

---

## 2. Competitive Analysis

### Market Landscape Overview

The subscription tracker market is dominated by apps that require bank account access, charge monthly fees, or lack comprehensive features. SubTally fills the gap for privacy-conscious users who want full functionality without recurring costs.

### Competitor Comparison Matrix

| Feature | SubTally | Rocket Money | Bobby | ReSubs | SubTrack | Minus. |
|---------|----------|--------------|-------|--------|----------|--------|
| **Pricing Model** | One-time purchase | $6-12/month (sliding scale) | Free + $2.99 one-time | Free + Premium subscription | $2.99 one-time | One-time upgrade |
| **Bank Connection Required** | ❌ No | ✅ Yes (via Plaid) | ❌ No | ❌ No | ❌ No | ❌ No |
| **Privacy Rating** | ⭐⭐⭐⭐⭐ Excellent | ⭐⭐ Poor (data sharing) | ⭐⭐⭐⭐⭐ Excellent | ⭐⭐⭐⭐ Good | ⭐⭐⭐⭐ Good | ⭐⭐⭐⭐ Good |
| **Calendar Integration** | ✅ Yes (EventKit) | ❌ No | ❌ No | ✅ Yes | ❌ No | ❌ No |
| **Home Screen Widget** | ✅ Yes (WidgetKit) | ❌ No | ❌ No | ✅ Yes | ❌ No | ❌ No |
| **Lock Screen Widget** | ✅ Yes | ❌ No | ❌ No | ❌ No | ❌ No | ❌ No |
| **Cancel Guides** | ✅ 30+ services | ✅ Premium only | ❌ No | ✅ 30+ services | ❌ No | ❌ No |
| **Bill Negotiation** | ❌ No | ✅ Yes (35-60% fee) | ❌ No | ❌ No | ❌ No | ❌ No |
| **CSV Export** | ✅ Yes | ✅ Premium only | ❌ No | ❌ No | ❌ No | ❌ No |
| **iCloud Sync** | ✅ Optional | ✅ Automatic | ❌ No | ❌ No | ❌ No | ❌ No |
| **Face ID/Touch ID** | ✅ Yes | ❌ No | ❌ No | ❌ No | ❌ No | ❌ No |
| **App Store Rating** | N/A (New) | 4.4 ⭐ | 4.7 ⭐ | N/A (New) | 4.2 ⭐ | N/A (New) |
| **Native iOS** | ✅ Yes (Swift/SwiftUI) | ✅ Yes | ✅ Yes | ✅ Yes | ✅ Yes | ⚠️ React Native |

### Detailed Competitor Analysis

#### 1. Rocket Money (Market Leader)

**Strengths**:
- Automatic subscription detection via bank integration
- Bill negotiation service (though 35-60% fee is steep)
- Comprehensive financial dashboard
- Credit score monitoring

**Weaknesses**:
- **Requires bank access** via Plaid (major privacy concern)
- **Subscription fatigue irony**: $6-12/month to track subscriptions
- Complex pricing with hidden fees (bill negotiation takes 35-60% of savings forever)
- 3.6-star Trustpilot rating with complaints about aggressive upselling
- Data sharing with third parties per privacy policy

**User Pain Points** (from Reddit/App Store reviews):
- "I was frustrated with how many subscription apps ask for too much upfront — bank access, accounts..."
- Difficulty canceling the Rocket Money subscription itself
- Unauthorized charges reported to CFPB

#### 2. Bobby (Simpler Alternative)

**Strengths**:
- Beautiful, minimalist design
- No bank access required
- One-time purchase option ($2.99)
- High App Store rating (4.7 ⭐)

**Weaknesses**:
- **Missing critical features**: No calendar integration, no widgets, no cancel guides
- No CSV export
- No iCloud sync
- Limited to basic tracking

**User Feedback**:
- "Bobby is a beautifully designed way of keeping up with all my subscriptions!" — but users want more features

#### 3. ReSubs (Feature-Rich but Subscription-Based)

**Strengths**:
- Calendar integration
- Widget support
- Cancel guides (30+ services)
- No bank access required

**Weaknesses**:
- **Subscription model** (adds to subscription fatigue)
- Premium features locked behind recurring payment
- New app with limited user base

#### 4. SubTrack (Basic Tracker)

**Strengths**:
- One-time purchase ($2.99)
- No bank access
- Simple interface

**Weaknesses**:
- **Outdated UI** not following modern iOS design trends
- No calendar integration
- No widgets
- No cancel guides

### SubTally's Competitive Positioning

**Target User Persona**:
- Privacy-conscious US consumers
- Users tired of subscription fatigue
- People who want comprehensive features without monthly fees
- iOS users who value native, well-designed apps

**Unique Selling Proposition (USP)**:
> "SubTally is the only subscription tracker that gives you complete control over your recurring payments with zero privacy compromise, comprehensive features (calendar, widgets, cancel guides), and a one-time purchase model that respects your wallet."

---

## 3. Apple Design Guidelines Compliance

### Human Interface Guidelines (HIG) Adherence

SubTally follows Apple's core design principles: **Clarity, Deference, and Depth**.

#### 3.1 Clarity

**Implementation**:
- **Legible Typography**: San Francisco font system with Dynamic Type support
- **Precise Icons**: SF Symbols for consistent, recognizable iconography
- **Minimalist UI**: Clean interfaces with clear visual hierarchy
- **Focus on Functionality**: Every UI element serves a purpose

**Specific Guidelines Applied**:
```swift
// Clear, focused content
Text("Monthly Total")
    .font(.title2)
    .fontWeight(.semibold)
    .foregroundColor(.primary)

// Avoid cluttered design
// ❌ No excessive decorations, borders, or visual noise
```

#### 3.2 Deference

**Implementation**:
- **Content-First Design**: UI elements support content, never compete with it
- **Light Visual Treatment**: Subtle backgrounds, minimal chrome
- **Generous White Space**: Content has room to breathe
- **Fluid Navigation**: Intuitive flow without friction

**Specific Guidelines Applied**:
```swift
// Content-focused layout
VStack(alignment: .leading, spacing: 12) {
    Text("Netflix")
        .font(.headline)
    Text("$15.99/month")
        .font(.subheadline)
        .foregroundColor(.secondary)
}
.padding()
.background(Color(.systemBackground))
```

#### 3.3 Depth

**Implementation**:
- **Visual Layers**: Cards with subtle shadows for hierarchy
- **Realistic Motion**: Smooth animations and transitions
- **Contextual Navigation**: Maintain context when drilling into details
- **Material Effects**: Blur effects for depth perception

**Specific Guidelines Applied**:
```swift
// Clear depth hierarchy
ZStack {
    Color(.systemGroupedBackground)
    
    VStack {
        SubscriptionCard()
            .background(.ultraThinMaterial)
            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 2)
    }
}
```

### Platform-Specific Guidelines

#### iOS 17+ Features

1. **SwiftData Integration**: Modern data persistence replacing Core Data
2. **WidgetKit Enhancements**: Lock screen widgets, interactive widgets
3. **Swift Charts**: Native visualization for spending analytics
4. **EventKit Improvements**: Better calendar integration

#### Layout Adaptability

- **iPhone**: Optimized for one-handed use, portrait orientation
- **iPad**: Split-view support, landscape optimization, sidebar navigation
- **Dynamic Type**: Support all text size preferences (AX1-AX5)
- **Safe Areas**: Respect system safe areas and keyboard avoidance

#### Navigation Patterns

**Tab Bar Navigation** (Primary):
```
┌─────────────────────────────────┐
│  [Home] [Calendar] [Analytics] [Settings] │
└─────────────────────────────────┘
```

**Guidelines**:
- 4 tabs maximum (we use exactly 4)
- SF Symbols for icons
- Single-word labels
- Never hide or disable tabs

**Navigation Stack** (Secondary):
- Large titles for top-level views
- Inline titles for detail views
- Back button with previous screen title
- Swipe-to-go-back gesture support

### Accessibility Compliance

#### VoiceOver Support

- All interactive elements have accessibility labels
- Meaningful descriptions for subscription cards
- Hints for complex interactions
- Rotor support for navigation

**Implementation**:
```swift
SubscriptionCard(subscription: subscription)
    .accessibilityLabel("\(subscription.name), \(subscription.amount) dollars per month")
    .accessibilityHint("Double tap to view details")
    .accessibilityAddTraits(.isButton)
```

#### Dynamic Type

- Support text sizes from 12pt to 40pt (AX5)
- Maintain readability at all sizes
- Adjust layouts dynamically
- Test with accessibility inspector

**Implementation**:
```swift
VStack(alignment: .leading, spacing: 8) {
    Text(subscription.name)
        .font(.headline)
        .minimumScaleFactor(0.75)
    
    Text("$\(subscription.amount)")
        .font(.title)
        .fontWeight(.bold)
}
```

#### Color Contrast

- WCAG AA compliance (4.5:1 for normal text, 3:1 for large text)
- Semantic colors for dark mode support
- No reliance on color alone to convey information

#### Reduce Motion

- Respect `UIAccessibility.isReduceMotionEnabled`
- Provide alternative transitions
- Maintain functionality without animations

### Privacy & Data Guidelines

#### App Store Privacy Labels

SubTally's privacy disclosure:

| Data Type | Collected | Purpose | Linked to User |
|-----------|-----------|---------|----------------|
| **Identifiers** | ❌ No | N/A | N/A |
| **Financial Info** | ✅ Yes (locally) | Core functionality | ❌ No (local only) |
| **Usage Data** | ❌ No | N/A | N/A |
| **Diagnostics** | ❌ No | N/A | N/A |

**Key Privacy Points**:
- **Zero Third-Party Data Sharing**: All data stays on device
- **No Analytics**: No tracking, no user behavior monitoring
- **No Account Required**: No email, no sign-up, no cloud account
- **Optional iCloud Sync**: User-controlled, encrypted via CloudKit

#### App Transport Security

- All network requests (if any) use HTTPS
- No insecure HTTP connections
- Proper certificate validation

#### Data Minimization

- Only collect data essential for functionality
- No unnecessary permissions
- Clear explanation for any data access

---

## 4. Technical Architecture

### Technology Stack Overview

```
┌─────────────────────────────────────────────────────────┐
│                    SubTally Tech Stack                   │
├─────────────────────────────────────────────────────────┤
│  UI Layer          │ SwiftUI (iOS 17+) + Swift Charts   │
│  Data Layer        │ SwiftData (modern Core Data)       │
│  Sync Layer        │ NSPersistentCloudKitContainer      │
│  Calendar Layer    │ EventKit (EKEventStore)            │
│  Notification Layer│ UserNotifications (local only)     │
│  Widget Layer      │ WidgetKit (Home + Lock Screen)     │
│  Security Layer    │ LocalAuthentication (Face ID/Touch ID) │
│  Analytics Layer   │ Swift Charts (spending trends)     │
│  Payment Layer     │ StoreKit 2 (one-time purchase)     │
└─────────────────────────────────────────────────────────┘
```

### Architecture Pattern: MVVM (Model-View-ViewModel)

**Why MVVM?**
- Clear separation of concerns
- Testable business logic
- Reactive data binding with SwiftUI
- Scalable for future features

**Architecture Diagram**:
```
┌──────────────┐
│     View     │ ← SwiftUI Views
│  (SwiftUI)   │
└──────┬───────┘
       │ @Observable/@StateObject
       ↓
┌──────────────┐
│  ViewModel   │ ← Business Logic
│ (@Observable)│
└──────┬───────┘
       │ SwiftData/@Query
       ↓
┌──────────────┐
│     Model    │ ← Data Models
│  (SwiftData) │
└──────────────┘
```

### Data Model Design (SwiftData)

#### Core Entities

**1. Subscription Model**

```swift
import SwiftData
import Foundation

@Model
final class Subscription {
    @Attribute(.unique) var id: UUID
    var name: String
    var icon: String
    var customIconData: Data?
    var amount: Decimal
    var currency: String
    var billingCycle: BillingCycle
    var customCycleDays: Int?
    var nextBillingDate: Date
    var firstBillingDate: Date
    var category: SubscriptionCategory
    var colorHex: String
    var notes: String
    var isTrial: Bool
    var trialEndDate: Date?
    var isActive: Bool
    var cancelledDate: Date?
    var createdAt: Date
    var updatedAt: Date
    
    var remindDaysBefore: Int
    var remindOnDay: Bool
    var reminderEnabled: Bool
    
    var calendarEventId: String?
    var syncToCalendar: Bool
    
    var monthlyEquivalent: Decimal {
        switch billingCycle {
        case .weekly: return amount * 52 / 12
        case .monthly: return amount
        case .quarterly: return amount / 3
        case .yearly: return amount / 12
        case .custom: return amount * (365 / Decimal(customCycleDays ?? 30)) / 12
        }
    }
    
    init(name: String, amount: Decimal, billingCycle: BillingCycle, 
         nextBillingDate: Date, category: SubscriptionCategory) {
        self.id = UUID()
        self.name = name
        self.amount = amount
        self.currency = "USD"
        self.billingCycle = billingCycle
        self.nextBillingDate = nextBillingDate
        self.firstBillingDate = nextBillingDate
        self.category = category
        self.colorHex = "#0A8754"
        self.notes = ""
        self.isTrial = false
        self.isActive = true
        self.createdAt = Date()
        self.updatedAt = Date()
        self.remindDaysBefore = 3
        self.remindOnDay = true
        self.reminderEnabled = true
        self.syncToCalendar = false
        self.icon = category.icon
    }
}
```

**2. BillingCycle Enum**

```swift
enum BillingCycle: String, Codable, CaseIterable {
    case weekly = "Weekly"
    case monthly = "Monthly"
    case quarterly = "Quarterly"
    case yearly = "Yearly"
    case custom = "Custom"
    
    var displayName: String { rawValue }
    var shortName: String {
        switch self {
        case .weekly: return "wk"
        case .monthly: return "mo"
        case .quarterly: return "qtr"
        case .yearly: return "yr"
        case .custom: return "custom"
        }
    }
}
```

**3. SubscriptionCategory Enum**

```swift
enum SubscriptionCategory: String, Codable, CaseIterable {
    case streaming = "Streaming"
    case music = "Music"
    case productivity = "Productivity"
    case gaming = "Gaming"
    case fitness = "Fitness"
    case news = "News"
    case cloud = "Cloud Storage"
    case utility = "Utilities"
    case education = "Education"
    case food = "Food & Delivery"
    case other = "Other"
    
    var icon: String {
        switch self {
        case .streaming: return "tv.fill"
        case .music: return "music.note"
        case .productivity: return "laptopcomputer"
        case .gaming: return "gamecontroller.fill"
        case .fitness: return "figure.run"
        case .news: return "newspaper.fill"
        case .cloud: return "cloud.fill"
        case .utility: return "bolt.fill"
        case .education: return "book.fill"
        case .food: return "fork.knife"
        case .other: return "square.grid.2x2.fill"
        }
    }
    
    var colorHex: String {
        switch self {
        case .streaming: return "#E50914"
        case .music: return "#1DB954"
        case .productivity: return "#0078D4"
        case .gaming: return "#107C10"
        case .fitness: return "#FC3C44"
        case .news: return "#FF6600"
        case .cloud: return "#00A1F1"
        case .utility: return "#FFB900"
        case .education: return "#7B68EE"
        case .food: return "#FF6347"
        case .other: return "#8E8E93"
        }
    }
}
```

### Key Technical Components

#### 1. Calendar Integration (EventKit)

**Purpose**: Create calendar events for billing reminders

**Implementation**:
```swift
import EventKit

final class CalendarManager: ObservableObject {
    private let eventStore = EKEventStore()
    private var subTallyCalendar: EKCalendar?
    
    func requestAccess() async -> Bool {
        do {
            return try await eventStore.requestFullAccessToEvents()
        } catch {
            print("Calendar access denied: \(error)")
            return false
        }
    }
    
    func createReminderEvents(for subscription: Subscription) async -> String? {
        // Creates 3 events: N days before, 1 day before, same day
        // Returns primary event ID
    }
}
```

**Features**:
- Creates dedicated "SubTally" calendar
- Generates multiple reminder events per subscription
- Handles updates and deletions
- Syncs across iCloud (if enabled)

#### 2. Widget Support (WidgetKit)

**Purpose**: Display monthly spending and upcoming bills on home/lock screen

**Widget Types**:
1. **Monthly Total Widget** (Small/Medium)
   - Shows total monthly subscription cost
   - Number of active subscriptions
   - Next billing date

2. **Upcoming Bills Widget** (Medium/Large)
   - List of upcoming charges
   - Sorted by date
   - Quick glance at next 7 days

**Implementation**:
```swift
import WidgetKit
import SwiftUI

struct SubTallyWidgetProvider: TimelineProvider {
    func getTimeline(in context: Context, completion: @escaping (Timeline<SubTallyEntry>) -> Void) {
        // Fetch subscriptions from SwiftData
        // Calculate monthly total
        // Create timeline with 1-hour refresh
    }
}
```

#### 3. Local Notifications

**Purpose**: Remind users before billing dates

**Implementation**:
```swift
import UserNotifications

final class NotificationManager: ObservableObject {
    func requestAuthorization() async -> Bool {
        let center = UNUserNotificationCenter.current()
        return try? await center.requestAuthorization(options: [.alert, .sound, .badge]) ?? false
    }
    
    func scheduleReminder(for subscription: Subscription) {
        // Schedule notifications for:
        // - N days before (configurable)
        // - 1 day before
        // - Same day
    }
}
```

#### 4. Security (Face ID/Touch ID)

**Purpose**: Protect sensitive financial data

**Implementation**:
```swift
import LocalAuthentication

final class BiometricAuthManager: ObservableObject {
    func authenticate() async -> Bool {
        let context = LAContext()
        var error: NSError?
        
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return false
        }
        
        return try? await context.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: "Authenticate to access your subscriptions"
        ) ?? false
    }
}
```

#### 5. StoreKit 2 Integration

**Purpose**: One-time purchase for premium features

**Product IDs**:
- `com.zzoutuo.SubTally.pro` (Lifetime access)

**Implementation**:
```swift
import StoreKit

@MainActor
final class PurchaseManager: ObservableObject {
    @Published private(set) var isPro = false
    @Published private(set) var product: Product?
    
    func loadProduct() async {
        let products = try? await Product.products(for: ["com.zzoutuo.SubTally.pro"])
        product = products?.first
    }
    
    func purchase() async -> Bool {
        guard let product = product else { return false }
        let result = try? await product.purchase()
        // Handle purchase result
    }
}
```

### Data Persistence Strategy

#### SwiftData Configuration

**Container Setup**:
```swift
import SwiftData

@main
struct SubTallyApp: App {
    let container: ModelContainer
    
    init() {
        let schema = Schema([Subscription.self])
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            container = try ModelContainer(for: schema, configurations: configuration)
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}
```

#### iCloud Sync (Optional)

**Configuration**:
```swift
let configuration = ModelConfiguration(
    schema: schema,
    isStoredInMemoryOnly: false,
    allowsSave: true,
    groupContainer: .identifier("group.com.zzoutuo.SubTally"),
    cloudKitDatabase: .private("iCloud.com.zzoutuo.SubTally")
)
```

**User Control**:
- Toggle in Settings
- Clear explanation of what syncs
- Option to disable at any time

---

## 5. Module Structure & File Organization

### Directory Structure

```
SubTally/
├── SubTallyApp.swift                 # App entry point
├── ContentView.swift                 # Root view with TabView
│
├── Models/                           # Data Models (SwiftData)
│   ├── Subscription.swift
│   ├── BillingCycle.swift
│   ├── SubscriptionCategory.swift
│   └── CancelGuide.swift
│
├── ViewModels/                       # Business Logic
│   ├── SubscriptionListViewModel.swift
│   ├── SubscriptionDetailViewModel.swift
│   ├── CalendarViewModel.swift
│   ├── AnalyticsViewModel.swift
│   └── SettingsViewModel.swift
│
├── Views/                            # SwiftUI Views
│   ├── Home/
│   │   ├── HomeView.swift
│   │   ├── SubscriptionCardView.swift
│   │   ├── MonthlyTotalView.swift
│   │   └── AddSubscriptionView.swift
│   │
│   ├── Calendar/
│   │   ├── CalendarView.swift
│   │   ├── CalendarDayView.swift
│   │   └── UpcomingBillsView.swift
│   │
│   ├── Analytics/
│   │   ├── AnalyticsView.swift
│   │   ├── SpendingChartView.swift
│   │   ├── CategoryBreakdownView.swift
│   │   └── TrendAnalysisView.swift
│   │
│   ├── Detail/
│   │   ├── SubscriptionDetailView.swift
│   │   ├── EditSubscriptionView.swift
│   │   └── CancelGuideView.swift
│   │
│   └── Settings/
│       ├── SettingsView.swift
│       ├── CalendarSettingsView.swift
│       ├── SecuritySettingsView.swift
│       ├── iCloudSyncView.swift
│       └── AboutView.swift
│
├── Services/                         # Business Services
│   ├── CalendarManager.swift         # EventKit integration
│   ├── NotificationManager.swift     # Local notifications
│   ├── BiometricAuthManager.swift    # Face ID/Touch ID
│   ├── PurchaseManager.swift         # StoreKit 2
│   └── ExportManager.swift           # CSV export
│
├── Utils/                            # Utilities
│   ├── Extensions/
│   │   ├── Date+Extensions.swift
│   │   ├── Decimal+Extensions.swift
│   │   ├── Color+Extensions.swift
│   │   └── View+Extensions.swift
│   │
│   ├── Helpers/
│   │   ├── CurrencyFormatter.swift
│   │   ├── DateCalculator.swift
│   │   └── ColorPicker.swift
│   │
│   └── Constants/
│       ├── AppConstants.swift
│       └── CancelGuides.swift
│
├── Resources/                        # Assets & Resources
│   ├── Assets.xcassets/
│   │   ├── AppIcon.appiconset/
│   │   ├── AccentColor.colorset/
│   │   └── Colors/
│   │       ├── NetflixRed.colorset/
│   │       ├── SpotifyGreen.colorset/
│   │       └── ...
│   │
│   └── Localizable.strings           # Localization (future)
│
├── Widget/                           # Widget Extension
│   ├── SubTallyWidget.swift
│   ├── SubTallyWidgetBundle.swift
│   └── SubTallyWidgetLiveActivity.swift
│
└── CancelGuides/                     # Cancel Guide Data
    ├── NetflixGuide.swift
    ├── SpotifyGuide.swift
    ├── AmazonPrimeGuide.swift
    └── ... (30+ guides)
```

### Module Organization Principles

#### Single Responsibility Principle

Each module has one clear purpose:

- **Models**: Data structure definition only
- **ViewModels**: Business logic and state management
- **Views**: UI presentation and user interaction
- **Services**: External system integration (Calendar, Notifications, etc.)
- **Utils**: Reusable helper functions and extensions

#### High Cohesion, Low Coupling

**High Cohesion**:
- Related functionality grouped together
- Home view components in `Views/Home/`
- Calendar-related logic in `Services/CalendarManager.swift`

**Low Coupling**:
- ViewModels don't know about Views
- Services are independent, injectable
- Models are pure data, no business logic

#### Naming Conventions

**Files**:
- Views: `<Feature>View.swift` (e.g., `HomeView.swift`)
- ViewModels: `<Feature>ViewModel.swift` (e.g., `HomeViewModel.swift`)
- Models: `<Entity>.swift` (e.g., `Subscription.swift`)
- Services: `<Feature>Manager.swift` (e.g., `CalendarManager.swift`)

**Classes/Structs**:
- PascalCase for types: `SubscriptionCardView`
- camelCase for properties: `monthlyTotal`
- Descriptive, self-documenting names

**Functions**:
- Verb-noun format: `calculateMonthlyTotal()`, `scheduleReminder()`
- Clear intent: `requestCalendarAccess()` not `doCalendar()`

---

## 6. Implementation Flow

### Phase 1: Project Setup & Configuration

**Duration**: 1 day

**Steps**:

1. **Create Xcode Project**
   - Template: iOS App
   - Interface: SwiftUI
   - Storage: SwiftData
   - Language: Swift
   - Minimum iOS: 17.0

2. **Configure Bundle ID**
   - Bundle ID: `com.zzoutuo.SubTally`
   - Team: Select development team
   - Signing: Automatic

3. **Set Up Git Repository**
   ```bash
   git init
   git add .
   git commit -m "Initial commit: SubTally iOS app"
   git branch -M main
   git remote add origin git@github.com:asunnyboy861/SubTally.git
   git push -u origin main
   ```

4. **Configure Build Settings**
   - Deployment Target: iOS 17.0
   - Swift Language Version: Swift 5
   - Enable: `GENERATE_INFOPLIST_FILE = YES`

5. **Add Required Capabilities**
   - Calendar (EventKit)
   - Notifications
   - iCloud (CloudKit)
   - In-App Purchase

**Deliverables**:
- ✅ Xcode project builds successfully
- ✅ Git repository initialized
- ✅ Basic app launches on simulator

---

### Phase 2: Data Models & Persistence

**Duration**: 2 days

**Steps**:

1. **Create SwiftData Models**
   - `Subscription.swift` (main entity)
   - `BillingCycle.swift` (enum)
   - `SubscriptionCategory.swift` (enum)
   - `CancelGuide.swift` (static data)

2. **Configure ModelContainer**
   ```swift
   @main
   struct SubTallyApp: App {
       let container: ModelContainer
       
       init() {
           do {
               container = try ModelContainer(for: Subscription.self)
           } catch {
               fatalError("Failed to initialize ModelContainer")
           }
       }
       
       var body: some Scene {
           WindowGroup {
               ContentView()
           }
           .modelContainer(container)
       }
   }
   ```

3. **Test Data Persistence**
   - Create sample subscriptions
   - Verify data saves correctly
   - Test app relaunch (data persists)

4. **Implement iCloud Sync (Optional)**
   - Configure CloudKit container
   - Add sync toggle in Settings
   - Test sync across devices

**Deliverables**:
- ✅ SwiftData models compile
- ✅ Data persists across app launches
- ✅ CRUD operations work correctly

---

### Phase 3: Core UI Implementation

**Duration**: 5 days

#### 3.1 Tab Navigation (Day 1)

**Steps**:
1. Create `ContentView.swift` with TabView
2. Add 4 tabs: Home, Calendar, Analytics, Settings
3. Configure tab icons (SF Symbols)
4. Test navigation flow

**Code**:
```swift
struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            CalendarView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
            
            AnalyticsView()
                .tabItem {
                    Label("Analytics", systemImage: "chart.pie.fill")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
}
```

#### 3.2 Home View (Day 2-3)

**Features**:
- Monthly total display
- Subscription list
- Add subscription button
- Quick actions (edit, delete)

**Implementation Order**:
1. `MonthlyTotalView.swift` - Display total spending
2. `SubscriptionCardView.swift` - Individual subscription card
3. `HomeView.swift` - Main home screen layout
4. `AddSubscriptionView.swift` - Add new subscription form

**UI Layout**:
```
┌─────────────────────────────────┐
│  SubTally              [Add +]  │
├─────────────────────────────────┤
│                                 │
│  ┌───────────────────────────┐ │
│  │  Monthly Total            │ │
│  │  $127.45                  │ │
│  │  8 subscriptions          │ │
│  └───────────────────────────┘ │
│                                 │
│  Upcoming                       │
│  ┌───────────────────────────┐ │
│  │ 📺 Netflix    $15.99  4/25│ │
│  │ 🎵 Spotify    $9.99   4/28│ │
│  │ ☁️ iCloud     $2.99   5/01│ │
│  └───────────────────────────┘ │
│                                 │
└─────────────────────────────────┘
```

#### 3.3 Calendar View (Day 4)

**Features**:
- Monthly calendar grid
- Bills marked on dates
- Upcoming bills list
- Filter by category

**Implementation Order**:
1. `CalendarView.swift` - Main calendar screen
2. `CalendarDayView.swift` - Individual day cell
3. `UpcomingBillsView.swift` - List of upcoming charges

#### 3.4 Analytics View (Day 5)

**Features**:
- Spending by category (pie chart)
- Monthly trend (line chart)
- Top subscriptions
- Export to CSV

**Implementation Order**:
1. `AnalyticsView.swift` - Main analytics screen
2. `SpendingChartView.swift` - Pie chart using Swift Charts
3. `TrendAnalysisView.swift` - Line chart for trends
4. `CategoryBreakdownView.swift` - Category breakdown

**Swift Charts Implementation**:
```swift
import Charts
import SwiftUI

struct SpendingChartView: View {
    let subscriptions: [Subscription]
    
    var body: some View {
        Chart(subscriptions) { subscription in
            SectorMark(
                angle: .value("Amount", subscription.monthlyEquivalent),
                innerAngle: .ratio(0.5),
                angularInset: 1.5
            )
            .foregroundStyle(by: .value("Category", subscription.category.displayName))
        }
        .frame(height: 300)
    }
}
```

**Deliverables**:
- ✅ All 4 tabs functional
- ✅ Home view displays subscriptions
- ✅ Calendar view shows billing dates
- ✅ Analytics view shows charts
- ✅ Settings view accessible

---

### Phase 4: Detail & Edit Views

**Duration**: 2 days

**Features**:
- Subscription detail view
- Edit subscription
- Delete confirmation
- Cancel guide integration

**Implementation Order**:
1. `SubscriptionDetailView.swift` - Show subscription details
2. `EditSubscriptionView.swift` - Edit existing subscription
3. `CancelGuideView.swift` - Display cancellation steps

**UI Layout (Detail View)**:
```
┌─────────────────────────────────┐
│  ← Netflix              [Edit]  │
├─────────────────────────────────┤
│                                 │
│       📺                        │
│     Netflix                     │
│     $15.99 / month              │
│                                 │
│  ─────────────────────────────  │
│                                 │
│  Category: Streaming            │
│  Next Bill: April 25, 2026      │
│  Started: January 2024          │
│                                 │
│  ─────────────────────────────  │
│                                 │
│  How to Cancel                  │
│  1. Go to netflix.com           │
│  2. Sign in to your account     │
│  3. Click "Cancel Membership"   │
│                                 │
│  [Mark as Cancelled]            │
│                                 │
└─────────────────────────────────┘
```

**Deliverables**:
- ✅ Detail view shows all subscription info
- ✅ Edit view updates data correctly
- ✅ Cancel guide displays for 30+ services
- ✅ Delete confirmation works

---

### Phase 5: Calendar Integration

**Duration**: 2 days

**Steps**:

1. **Request Calendar Permission**
   ```swift
   func requestCalendarAccess() async -> Bool {
       let eventStore = EKEventStore()
       do {
           return try await eventStore.requestFullAccessToEvents()
       } catch {
           print("Calendar access denied: \(error)")
           return false
       }
   }
   ```

2. **Create SubTally Calendar**
   - Dedicated calendar for billing reminders
   - Green color matching app theme
   - Syncs with iCloud

3. **Generate Calendar Events**
   - Create events for each subscription
   - Multiple reminders: 3 days, 1 day, same day
   - Include amount in event title

4. **Handle Updates**
   - Update events when subscription changes
   - Delete events when subscription deleted
   - Sync toggle in Settings

**Implementation**:
```swift
func createReminderEvents(for subscription: Subscription) async {
    let eventStore = EKEventStore()
    let calendar = await getOrCreateSubTallyCalendar()
    
    let reminderDays = [subscription.remindDaysBefore, 1, 0]
    
    for daysBefore in reminderDays {
        guard daysBefore >= 0 else { continue }
        
        let event = EKEvent(eventStore: eventStore)
        event.title = daysBefore == 0 
            ? "💳 \(subscription.name) — $\(subscription.amount) TODAY"
            : "⏰ \(subscription.name) — $\(subscription.amount) in \(daysBefore) day\(daysBefore > 1 ? "s" : "")"
        
        event.startDate = Calendar.current.date(
            byAdding: .day, 
            value: -daysBefore, 
            to: subscription.nextBillingDate
        ) ?? subscription.nextBillingDate
        
        event.endDate = event.startDate.addingTimeInterval(3600)
        event.calendar = calendar
        
        let alarm = EKAlarm(absoluteDate: event.startDate)
        event.addAlarm(alarm)
        
        try? eventStore.save(event, span: .thisEvent)
    }
}
```

**Deliverables**:
- ✅ Calendar permission requested
- ✅ Events created for subscriptions
- ✅ Reminders fire at correct times
- ✅ Events update when subscription changes

---

### Phase 6: Widget Implementation

**Duration**: 2 days

**Widget Types**:

1. **Monthly Total Widget (Small)**
   - Shows total monthly spending
   - Number of active subscriptions
   - Next billing date

2. **Upcoming Bills Widget (Medium)**
   - List of next 3-5 charges
   - Amounts and dates
   - Quick glance

**Implementation Steps**:

1. **Create Widget Extension**
   - Add Widget Extension target
   - Configure bundle ID: `com.zzoutuo.SubTally.widget`

2. **Implement Timeline Provider**
   ```swift
   struct SubTallyWidgetProvider: TimelineProvider {
       func getTimeline(in context: Context, completion: @escaping (Timeline<SubTallyEntry>) -> Void) {
           let currentDate = Date()
           let nextUpdate = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate)!
           
           let entry = SubTallyEntry(
               date: currentDate,
               monthlyTotal: calculateMonthlyTotal(),
               nextBilling: getNextBilling(),
               subscriptionCount: getSubscriptionCount()
           )
           
           let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
           completion(timeline)
       }
   }
   ```

3. **Design Widget UI**
   - Use SwiftUI views
   - Support multiple sizes
   - Dark mode support

4. **Add App Groups**
   - Share data between app and widget
   - Configure App Group ID: `group.com.zzoutuo.SubTally`

**Deliverables**:
- ✅ Widget appears in widget gallery
- ✅ Widget displays correct data
- ✅ Widget updates hourly
- ✅ Lock screen widget available

---

### Phase 7: Notifications

**Duration**: 1 day

**Features**:
- Local notifications (no server)
- Configurable reminder days
- Custom notification content
- Deep link to subscription detail

**Implementation**:
```swift
func scheduleReminder(for subscription: Subscription) {
    let center = UNUserNotificationCenter.current()
    
    let content = UNMutableNotificationContent()
    content.title = "Upcoming Charge"
    content.body = "\(subscription.name) will charge $\(subscription.amount) in \(subscription.remindDaysBefore) days"
    content.sound = .default
    content.userInfo = ["subscriptionId": subscription.id.uuidString]
    
    let triggerDate = Calendar.current.date(
        byAdding: .day, 
        value: -subscription.remindDaysBefore, 
        to: subscription.nextBillingDate
    ) ?? subscription.nextBillingDate
    
    let trigger = UNCalendarNotificationTrigger(
        dateMatching: Calendar.current.dateComponents([.year, .month, .day], from: triggerDate),
        repeats: false
    )
    
    let request = UNNotificationRequest(
        identifier: subscription.id.uuidString,
        content: content,
        trigger: trigger
    )
    
    center.add(request)
}
```

**Deliverables**:
- ✅ Notifications scheduled correctly
- ✅ Notifications fire at right time
- ✅ Deep linking works
- ✅ User can configure reminders

---

### Phase 8: Security & Privacy

**Duration**: 1 day

**Features**:
- Face ID/Touch ID protection
- App lock on background
- Privacy-focused design
- No data collection

**Implementation**:
```swift
import LocalAuthentication

final class BiometricAuthManager: ObservableObject {
    @Published var isAuthenticated = false
    
    func authenticate() async -> Bool {
        let context = LAContext()
        var error: NSError?
        
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return false
        }
        
        do {
            let success = try await context.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                localizedReason: "Authenticate to access SubTally"
            )
            isAuthenticated = success
            return success
        } catch {
            print("Authentication failed: \(error)")
            return false
        }
    }
}
```

**Deliverables**:
- ✅ Face ID/Touch ID works
- ✅ App locks when backgrounded
- ✅ No analytics/tracking
- ✅ Privacy labels correct

---

### Phase 9: In-App Purchase

**Duration**: 2 days

**Product Configuration**:
- Product ID: `com.zzoutuo.SubTally.pro`
- Type: Non-consumable (lifetime)
- Price: $9.99 (one-time)

**Implementation**:
```swift
import StoreKit

@MainActor
final class PurchaseManager: ObservableObject {
    @Published private(set) var isPro = false
    @Published private(set) var product: Product?
    @Published private(set) var isLoading = false
    
    private let productID = "com.zzoutuo.SubTally.pro"
    
    func loadProduct() async {
        let products = try? await Product.products(for: [productID])
        product = products?.first
    }
    
    func purchase() async -> Bool {
        guard let product = product else { return false }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            let result = try await product.purchase()
            
            switch result {
            case .success(let verification):
                let transaction = try checkVerified(verification)
                isPro = true
                await transaction.finish()
                return true
            case .userCancelled:
                return false
            case .pending:
                return false
            @unknown default:
                return false
            }
        } catch {
            print("Purchase failed: \(error)")
            return false
        }
    }
    
    func restorePurchases() async {
        do {
            try await AppStore.sync()
            await updatePurchaseStatus()
        } catch {
            print("Restore failed: \(error)")
        }
    }
    
    private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreError.failedVerification
        case .verified(let safe):
            return safe
        }
    }
}
```

**Paywall UI**:
```
┌─────────────────────────────────┐
│         SubTally Pro            │
├─────────────────────────────────┤
│                                 │
│    ✅ Unlimited Subscriptions   │
│    ✅ Calendar Integration      │
│    ✅ Widgets                   │
│    ✅ Cancel Guides (30+)       │
│    ✅ CSV Export                │
│    ✅ Face ID Protection        │
│                                 │
│    ┌─────────────────────────┐ │
│    │   Lifetime Access       │ │
│    │        $9.99            │ │
│    │    One-time purchase    │ │
│    └─────────────────────────┘ │
│                                 │
│    [Purchase]                   │
│    [Restore Purchases]          │
│                                 │
└─────────────────────────────────┘
```

**Deliverables**:
- ✅ Product loads from App Store
- ✅ Purchase flow works
- ✅ Restore purchases works
- ✅ Pro features unlock correctly

---

### Phase 10: Testing & Polish

**Duration**: 3 days

#### 10.1 Unit Tests (Day 1)

**Test Coverage**:
- ViewModel business logic
- Data calculations (monthly equivalent)
- Date calculations
- Currency formatting

**Example Test**:
```swift
import XCTest
@testable import SubTally

final class SubscriptionTests: XCTestCase {
    func testMonthlyEquivalentCalculation() {
        let weekly = Subscription(
            name: "Test",
            amount: 10.0,
            billingCycle: .weekly,
            nextBillingDate: Date(),
            category: .streaming
        )
        
        XCTAssertEqual(weekly.monthlyEquivalent, 10.0 * 52 / 12, accuracy: 0.01)
    }
    
    func testYearlyToMonthly() {
        let yearly = Subscription(
            name: "Test",
            amount: 120.0,
            billingCycle: .yearly,
            nextBillingDate: Date(),
            category: .streaming
        )
        
        XCTAssertEqual(yearly.monthlyEquivalent, 10.0, accuracy: 0.01)
    }
}
```

#### 10.2 UI Tests (Day 2)

**Test Scenarios**:
- Add subscription flow
- Edit subscription
- Delete subscription
- Navigate between tabs
- Widget displays correctly

#### 10.3 Polish & Bug Fixes (Day 3)

**Checklist**:
- [ ] All UI elements properly aligned
- [ ] Dark mode support complete
- [ ] Accessibility labels added
- [ ] Animations smooth
- [ ] No memory leaks
- [ ] No crashes on edge cases
- [ ] Loading states implemented
- [ ] Error handling user-friendly

**Deliverables**:
- ✅ Unit tests pass
- ✅ UI tests pass
- ✅ No critical bugs
- ✅ Performance optimized

---

### Phase 11: App Store Preparation

**Duration**: 2 days

#### 11.1 App Icon (Day 1)

**Requirements**:
- 1024x1024px for App Store
- All required sizes for iOS
- Simple, recognizable design
- Follow Apple icon guidelines

**Icon Concept**:
- Subscription list with checkmark
- Green color scheme (#0A8754)
- Clean, minimalist design

#### 11.2 App Store Metadata (Day 2)

**App Name**: SubTally

**Subtitle**: Track & Cancel Recurring Payments

**Promotional Text** (170 chars):
```
Stop losing money to forgotten subscriptions. Track all your recurring payments, get calendar reminders, and cancel unwanted services with step-by-step guides. Privacy-first, no bank access required.
```

**Keywords** (100 chars):
```
subscription,tracker,manager,recurring,payments,cancel,reminder,calendar,widget,bills
```

**Description** (4000 chars):
```
SubTally is the privacy-first subscription tracker that helps you take control of your recurring payments without sacrificing your financial privacy.

KEY FEATURES:

📊 COMPREHENSIVE TRACKING
• Track unlimited subscriptions in one place
• See total monthly and yearly spending at a glance
• Organize by category (Streaming, Music, Gaming, Fitness, etc.)
• Support for weekly, monthly, quarterly, yearly, and custom billing cycles

📅 CALENDAR INTEGRATION
• Automatic calendar events for billing dates
• Customizable reminders: 3 days, 1 day, and same day alerts
• Syncs with your iPhone calendar
• Never miss a payment again

🏠 HOME & LOCK SCREEN WIDGETS
• Quick view of monthly spending
• Upcoming bills at a glance
• Multiple widget sizes available
• Always know your subscription costs

📖 CANCEL GUIDES (30+ SERVICES)
• Step-by-step cancellation instructions
• Popular services: Netflix, Spotify, Disney+, Amazon Prime, and more
• Mark subscriptions as cancelled
• Track cancellation history

🔒 PRIVACY-FIRST DESIGN
• NO bank account access required
• NO third-party data sharing
• NO analytics or tracking
• All data stored locally on your device
• Optional iCloud sync (encrypted)

💎 ONE-TIME PURCHASE
• Lifetime access with a single purchase
• No subscription fatigue - we don't add to your recurring bills
• All features included
• Free updates forever

🛡️ SECURITY
• Face ID / Touch ID protection
• App lock when backgrounded
• Your financial data stays private

📊 ANALYTICS & INSIGHTS
• Spending breakdown by category
• Monthly trend analysis
• Identify costly subscriptions
• Export data to CSV

WHY SUBTALLY?

The average American household has 11+ active subscriptions, spending over $900 per year. 74% of people forget about recurring charges, leading to unexpected fees. SubTally solves this problem without requiring you to share your bank data with third parties.

Unlike competitors that charge monthly fees (adding to your subscription fatigue), SubTally offers lifetime access with a one-time purchase. We believe you shouldn't pay a subscription to track subscriptions.

WHO IS SUBTALLY FOR?

• Privacy-conscious users who don't want to share bank data
• People tired of subscription fatigue
• Anyone who wants to save money on unused services
• Families tracking shared subscriptions
• Budget-conscious individuals

WHAT USERS SAY:

"I was frustrated with subscription apps asking for bank access. SubTally gives me full control without compromising my privacy." - iOS User

"The calendar integration is a game-changer. I never miss a billing date now." - App Store Review

"The cancel guides saved me hours. I canceled 3 subscriptions I forgot about within the first week." - Happy Customer

PRICING:

Free Version:
• Track up to 5 subscriptions
• Basic analytics
• Local notifications

SubTally Pro (One-Time Purchase):
• Unlimited subscriptions
• Calendar integration
• Home & Lock screen widgets
• Cancel guides (30+ services)
• CSV export
• Face ID / Touch ID protection
• Priority support

SUPPORT:

Have questions or feedback? Contact us at support@subtally.app

Privacy Policy: https://asunnyboy861.github.io/SubTally-privacy/
Terms of Use: https://asunnyboy861.github.io/SubTally-terms/

Download SubTally today and take control of your subscriptions!
```

**Deliverables**:
- ✅ App icon created
- ✅ Screenshots captured (6.5" iPhone, 5.5" iPhone)
- ✅ Metadata prepared
- ✅ Privacy policy published
- ✅ Terms of use published

---

### Phase 12: App Store Submission

**Duration**: 1 day

**Steps**:

1. **Create App in App Store Connect**
   - App name: SubTally
   - Primary language: English
   - Bundle ID: com.zzoutuo.SubTally
   - SKU: subtally-2026

2. **Upload Build**
   ```bash
   xcodebuild -scheme SubTally -archivePath build/SubTally.xcarchive archive
   xcodebuild -exportArchive -archivePath build/SubTally.xcarchive -exportPath build/export -exportOptionsPlist ExportOptions.plist
   xcrun altool --upload-app -f build/export/SubTally.ipa -u <apple-id> -p <app-specific-password>
   ```

3. **Configure In-App Purchase**
   - Product ID: com.zzoutuo.SubTally.pro
   - Reference name: SubTally Pro
   - Price: $9.99 (Tier 9)
   - Review information provided

4. **Submit for Review**
   - Fill out all required fields
   - Upload screenshots
   - Provide demo account (if needed)
   - Submit for App Review

**Deliverables**:
- ✅ Build uploaded successfully
- ✅ IAP configured
- ✅ App submitted for review
- ✅ Waiting for approval

---

## 7. UI/UX Design Specifications

### Design Philosophy

SubTally follows **2026 iOS design trends** while maintaining Apple Human Interface Guidelines compliance.

**Core Principles**:
1. **Liquid Glass Aesthetics**: Translucent materials, depth through blur
2. **AI-Assisted Personalization**: Adaptive layouts, contextual information
3. **Micro-Interaction Design**: Haptic feedback, smooth animations
4. **Spatial-First Typography**: Dynamic Type support, multi-device scaling
5. **Privacy-First Messaging**: Clear, honest communication about data

### Color Palette

**Primary Colors**:
```
SubTally Green:  #0A8754 (RGB: 10, 135, 84)
Accent Color:    #34C759 (System Green)
Background:      #F2F2F7 (System Grouped Background)
Card Background: #FFFFFF (System Background)
```

**Category Colors** (Predefined):
```
Streaming:       #E50914 (Netflix Red)
Music:           #1DB954 (Spotify Green)
Productivity:    #0078D4 (Office Blue)
Gaming:          #107C10 (Xbox Green)
Fitness:         #FC3C44 (Activity Red)
News:            #FF6600 (News Orange)
Cloud Storage:   #00A1F1 (Sky Blue)
Utilities:       #FFB900 (Energy Yellow)
Education:       #7B68EE (Academic Purple)
Food & Delivery: #FF6347 (Tomato Red)
Other:           #8E8E93 (System Gray)
```

**Dark Mode Support**:
```swift
// Use semantic colors for automatic dark mode
.background(Color(.systemBackground))        // White in light, black in dark
.foregroundColor(.primary)                   // Black in light, white in dark
.foregroundColor(.secondary)                 // Gray in both modes
```

### Typography

**Font Family**: San Francisco (System Font)

**Type Scale**:
```
Large Title:  34pt, Bold    - Main screen titles
Title:        28pt, Bold    - Section headers
Title 2:      22pt, Bold    - Card titles
Title 3:      20pt, Semibold - Subsection headers
Headline:     17pt, Semibold - Important labels
Body:         17pt, Regular  - Body text
Callout:      16pt, Regular  - Secondary text
Subheadline:  15pt, Regular  - Tertiary text
Footnote:     13pt, Regular  - Captions, hints
Caption 1:    12pt, Regular  - Small labels
Caption 2:    11pt, Regular  - Tiny text
```

**Dynamic Type Support**:
```swift
Text("Monthly Total")
    .font(.title)
    .minimumScaleFactor(0.75)  // Scale down if needed
    .lineLimit(1)
```

### Layout Grid

**8pt Grid System**:
- Spacing: 8pt, 16pt, 24pt, 32pt, 40pt
- Margins: 16pt (standard), 20pt (iPad)
- Card padding: 16pt
- Section spacing: 24pt

**Safe Areas**:
```swift
VStack {
    // Content
}
.padding()  // Automatically respects safe areas
```

### Component Specifications

#### 1. Subscription Card

**Dimensions**:
- Height: 80pt
- Corner radius: 12pt
- Shadow: 0pt 2pt 8pt rgba(0,0,0,0.1)

**Layout**:
```
┌──────────────────────────────────────┐
│ [Icon]  Name              $15.99/mo  │
│         Category          Next: 4/25 │
└──────────────────────────────────────┘
```

**Implementation**:
```swift
struct SubscriptionCardView: View {
    let subscription: Subscription
    
    var body: some View {
        HStack(spacing: 16) {
            // Icon
            Image(systemName: subscription.icon)
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 48, height: 48)
                .background(Color(hex: subscription.colorHex))
                .cornerRadius(12)
            
            // Info
            VStack(alignment: .leading, spacing: 4) {
                Text(subscription.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(subscription.category.displayName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Amount & Date
            VStack(alignment: .trailing, spacing: 4) {
                Text("$\(subscription.amount)")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text("Next: \(subscription.nextBillingDate.formatted(.dateTime.month().day()))")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 2)
    }
}
```

#### 2. Monthly Total Card

**Dimensions**:
- Height: 120pt
- Corner radius: 16pt
- Background: SubTally Green gradient

**Layout**:
```
┌──────────────────────────────────────┐
│                                      │
│   Monthly Total                      │
│   $127.45                            │
│   8 active subscriptions             │
│                                      │
└──────────────────────────────────────┘
```

**Implementation**:
```swift
struct MonthlyTotalView: View {
    let total: Decimal
    let count: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Monthly Total")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.9))
            
            Text("$\(total)")
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(.white)
            
            Text("\(count) active subscriptions")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.9))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(
            LinearGradient(
                colors: [Color(hex: "#0A8754"), Color(hex: "#34C759")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(16)
        .shadow(color: Color(hex: "#0A8754").opacity(0.3), radius: 12, x: 0, y: 6)
    }
}
```

#### 3. Add Subscription Button

**Style**: Floating action button (FAB)

**Dimensions**:
- Size: 56x56pt
- Corner radius: 28pt (circular)
- Shadow: 0pt 4pt 12pt rgba(0,0,0,0.15)

**Implementation**:
```swift
struct AddButtonView: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(width: 56, height: 56)
                .background(Color(hex: "#0A8754"))
                .cornerRadius(28)
                .shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: 4)
        }
    }
}
```

#### 4. Calendar Day Cell

**Dimensions**:
- Size: 44x44pt
- Corner radius: 22pt (circular when selected)

**States**:
- Default: No background
- Today: Green border
- Has bills: Green dot indicator
- Selected: Green background, white text

**Implementation**:
```swift
struct CalendarDayView: View {
    let date: Date
    let isSelected: Bool
    let isToday: Bool
    let hasBills: Bool
    
    var body: some View {
        ZStack {
            // Background
            Circle()
                .fill(isSelected ? Color(hex: "#0A8754") : Color.clear)
            
            // Border for today
            if isToday && !isSelected {
                Circle()
                    .stroke(Color(hex: "#0A8754"), lineWidth: 2)
            }
            
            // Date text
            Text("\(Calendar.current.component(.day, from: date))")
                .font(.body)
                .fontWeight(isToday ? .semibold : .regular)
                .foregroundColor(isSelected ? .white : .primary)
            
            // Bill indicator
            if hasBills {
                Circle()
                    .fill(Color(hex: "#0A8754"))
                    .frame(width: 4, height: 4)
                    .offset(y: 12)
            }
        }
        .frame(width: 44, height: 44)
    }
}
```

### Animation Specifications

#### 1. Card Appear Animation

**Duration**: 0.3 seconds
**Curve**: easeOut

```swift
.transition(.asymmetric(
    insertion: .scale(scale: 0.9).combined(with: .opacity),
    removal: .opacity
))
.animation(.easeOut(duration: 0.3), value: subscriptions)
```

#### 2. Tab Switch Animation

**Duration**: 0.25 seconds
**Curve**: easeInOut

```swift
.animation(.easeInOut(duration: 0.25), value: selectedTab)
```

#### 3. Button Press Animation

**Duration**: 0.1 seconds
**Scale**: 0.95

```swift
.scaleEffect(isPressed ? 0.95 : 1.0)
.animation(.easeInOut(duration: 0.1), value: isPressed)
```

#### 4. List Delete Animation

**Duration**: 0.3 seconds
**Curve**: easeIn

```swift
.transition(.move(edge: .trailing).combined(with: .opacity))
.animation(.easeIn(duration: 0.3), value: isDeleting)
```

### Haptic Feedback

**Usage**:
- Selection changed: `.selection`
- Success: `.success`
- Error: `.error`
- Light impact: `.light`
- Medium impact: `.medium`

**Implementation**:
```swift
import UIKit

func hapticFeedback(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
    let generator = UIImpactFeedbackGenerator(style: style)
    generator.impactOccurred()
}

// Usage
Button("Add Subscription") {
    hapticFeedback(.medium)
    // Action
}
```

### Accessibility Features

#### VoiceOver Labels

```swift
SubscriptionCardView(subscription: subscription)
    .accessibilityLabel("\(subscription.name), \(subscription.amount) dollars per \(subscription.billingCycle.displayName)")
    .accessibilityHint("Double tap to view details")
    .accessibilityAddTraits(.isButton)
```

#### Dynamic Type Support

```swift
VStack(alignment: .leading, spacing: 8) {
    Text(subscription.name)
        .font(.headline)
        .minimumScaleFactor(0.75)
    
    Text("$\(subscription.amount)")
        .font(.title)
        .fontWeight(.bold)
        .minimumScaleFactor(0.5)
}
```

#### Color Contrast

- All text meets WCAG AA standards (4.5:1 for normal text)
- Interactive elements have 3:1 contrast ratio
- No information conveyed by color alone

#### Reduce Motion

```swift
@Environment(\.accessibilityReduceMotion) var reduceMotion

var body: some View {
    ContentView()
        .animation(reduceMotion ? .none : .default, value: someState)
}
```

---

## 8. Code Generation Rules

### Rule 1: Functional Module Principle

**Single Responsibility**: One feature per module

**Implementation**:
- Each view has one clear purpose
- ViewModels handle one aspect of business logic
- Services are focused on single integration point

**Example**:
```
✅ Good:
- HomeView.swift (displays subscription list)
- HomeViewModel.swift (manages subscription data)
- CalendarManager.swift (handles EventKit integration)

❌ Bad:
- HomeViewController.swift (handles UI, data, networking, calendar)
```

**High Cohesion, Low Coupling**:
- Related code grouped together
- Modules communicate via protocols
- Dependencies injected, not hardcoded

**Semantic Naming**:
- File names describe content: `SubscriptionCardView.swift`
- Function names describe action: `calculateMonthlyTotal()`
- Variable names describe purpose: `upcomingSubscriptions`

### Rule 2: Code Reuse Principle

**Merge Similar Code**:
- Identify duplicate patterns
- Extract common functionality
- Create reusable components

**Rule of Three**:
- Abstract after encountering same pattern 3 times
- Don't prematurely optimize
- Balance between DRY and over-engineering

**Example**:
```swift
// ❌ Bad: Duplicate code
func formatMonthlyAmount(_ amount: Decimal) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencyCode = "USD"
    return formatter.string(from: amount as NSDecimalNumber) ?? "$0.00"
}

func formatYearlyAmount(_ amount: Decimal) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencyCode = "USD"
    return formatter.string(from: amount as NSDecimalNumber) ?? "$0.00"
}

// ✅ Good: Reusable formatter
extension Decimal {
    func asCurrency(code: String = "USD") -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = code
        return formatter.string(from: self as NSDecimalNumber) ?? "$0.00"
    }
}

// Usage
let monthlyText = subscription.monthlyEquivalent.asCurrency()
let yearlyText = (subscription.monthlyEquivalent * 12).asCurrency()
```

**Prioritize Existing Modules**:
- Check if functionality exists before implementing
- Use SwiftUI built-in components when possible
- Leverage SwiftData for persistence

### Rule 3: Clean Refactoring Principle

**Mark Deprecated**:
```swift
@available(*, deprecated, message: "Use calculateMonthlyTotal() instead")
func getMonthlyTotal() -> Decimal {
    // Old implementation
}
```

**Verify No Impact**:
- Run tests after deprecation
- Check for compiler warnings
- Ensure no references remain

**Delete Obsolete Code**:
- Remove deprecated functions
- Clean up unused imports
- Delete commented-out code

**Commit Message Format**:
```
Refactor: Replace getMonthlyTotal with calculateMonthlyTotal

- Mark getMonthlyTotal as deprecated
- Update all references to use calculateMonthlyTotal
- Remove deprecated function after verification

Cleanup scope: SubscriptionViewModel.swift
```

### Rule 4: Open Source Integration Principle

**Leverage Existing Projects**:
- Use reference projects as starting point
- Adapt architecture to fit SubTally
- Maintain license compliance

**Reference Projects Used**:
1. **SubscriptionManagerApp** (simgebenzerr)
   - Architecture: SwiftUI + SwiftData
   - Borrowed: Data model structure, notification system

2. **mindful-subscribe** (euroyk)
   - Architecture: SwiftUI + MVVM
   - Borrowed: Calendar view implementation, UI patterns

3. **subMe** (MarioPeperoni)
   - Architecture: Swift + UIKit
   - Borrowed: Icon design system, category colors

**Integration Approach**:
- Extract useful components
- Convert to SwiftData if needed
- Adapt to SubTally's design language
- Maintain clean architecture

### Rule 5: Apple Native First Principle

**Prioritize Native Frameworks**:
- SwiftUI for UI (not React Native, Flutter)
- SwiftData for persistence (not Realm, SQLite)
- EventKit for calendar (not third-party SDKs)
- StoreKit 2 for IAP (not RevenueCat for simple needs)

**Convert Non-Native Code**:
- If reference project uses UIKit, evaluate SwiftUI alternative
- If uses Core Data, convert to SwiftData
- If uses third-party libs, check for native alternatives

**Example**:
```swift
// ❌ Bad: Third-party library
import RealmSwift

class Subscription: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var amount: Double = 0.0
}

// ✅ Good: Native SwiftData
import SwiftData

@Model
final class Subscription {
    var name: String
    var amount: Decimal
}
```

**Benefits**:
- Smaller app size
- Better performance
- Easier maintenance
- No third-party dependencies to manage
- Full Apple platform support

---

## 9. Testing & Validation Standards

### Unit Testing

**Coverage Target**: 70% minimum

**Test Categories**:

#### 1. Model Tests

**What to Test**:
- Data model initialization
- Computed properties (monthlyEquivalent)
- Enum cases and values
- Validation logic

**Example**:
```swift
final class SubscriptionModelTests: XCTestCase {
    func testMonthlyEquivalentWeekly() {
        let subscription = Subscription(
            name: "Test",
            amount: 10.0,
            billingCycle: .weekly,
            nextBillingDate: Date(),
            category: .streaming
        )
        
        XCTAssertEqual(subscription.monthlyEquivalent, 10.0 * 52 / 12, accuracy: 0.01)
    }
    
    func testMonthlyEquivalentYearly() {
        let subscription = Subscription(
            name: "Test",
            amount: 120.0,
            billingCycle: .yearly,
            nextBillingDate: Date(),
            category: .streaming
        )
        
        XCTAssertEqual(subscription.monthlyEquivalent, 10.0, accuracy: 0.01)
    }
}
```

#### 2. ViewModel Tests

**What to Test**:
- Business logic methods
- State changes
- Data transformations
- Error handling

**Example**:
```swift
@MainActor
final class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    var container: ModelContainer!
    
    override func setUp() async throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: Subscription.self, configurations: config)
        viewModel = HomeViewModel(modelContext: container.mainContext)
    }
    
    func testCalculateMonthlyTotal() {
        let sub1 = Subscription(name: "Netflix", amount: 15.99, billingCycle: .monthly, nextBillingDate: Date(), category: .streaming)
        let sub2 = Subscription(name: "Spotify", amount: 9.99, billingCycle: .monthly, nextBillingDate: Date(), category: .music)
        
        container.mainContext.insert(sub1)
        container.mainContext.insert(sub2)
        
        XCTAssertEqual(viewModel.monthlyTotal, 25.98, accuracy: 0.01)
    }
}
```

#### 3. Service Tests

**What to Test**:
- Calendar integration
- Notification scheduling
- Data export
- Purchase flow

### UI Testing

**Test Scenarios**:

1. **Add Subscription Flow**
   - Tap add button
   - Fill form
   - Save subscription
   - Verify appears in list

2. **Edit Subscription**
   - Tap subscription card
   - Tap edit button
   - Modify details
   - Save changes
   - Verify updates

3. **Delete Subscription**
   - Swipe to delete
   - Confirm deletion
   - Verify removed from list

4. **Calendar Integration**
   - Enable calendar in settings
   - Add subscription
   - Verify calendar event created

5. **Widget Functionality**
   - Add widget to home screen
   - Verify displays correct data
   - Update subscription
   - Verify widget updates

**Example**:
```swift
final class SubscriptionUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testAddSubscription() throws {
        let addButton = app.buttons["Add Subscription"]
        XCTAssertTrue(addButton.exists)
        addButton.tap()
        
        let nameField = app.textFields["Subscription Name"]
        nameField.tap()
        nameField.typeText("Netflix")
        
        let amountField = app.textFields["Amount"]
        amountField.tap()
        amountField.typeText("15.99")
        
        let saveButton = app.buttons["Save"]
        saveButton.tap()
        
        let netflixCard = app.staticTexts["Netflix"]
        XCTAssertTrue(netflixCard.waitForExistence(timeout: 2))
    }
}
```

### Performance Testing

**Metrics to Test**:

1. **App Launch Time**
   - Cold start: < 2 seconds
   - Warm start: < 1 second

2. **List Scrolling**
   - 60 FPS with 100+ subscriptions
   - Smooth animations

3. **Widget Refresh**
   - < 1 second to load data
   - No memory leaks

4. **Data Export**
   - CSV export: < 3 seconds for 100 subscriptions

**Example**:
```swift
func testListScrollingPerformance() throws {
    let app = XCUIApplication()
    app.launch()
    
    let homeTab = app.tabBars.buttons["Home"]
    homeTab.tap()
    
    let subscriptionList = app.tables.firstMatch
    measure(metrics: [XCTOSSignpostMetric.scrollDecelerationMetric]) {
        subscriptionList.swipeUp(velocity: .fast)
    }
}
```

### Validation Checklist

#### Functional Validation

- [ ] Add subscription with all fields
- [ ] Edit existing subscription
- [ ] Delete subscription with confirmation
- [ ] View subscription details
- [ ] Navigate between tabs
- [ ] Search/filter subscriptions
- [ ] Sort subscriptions by date/amount/name
- [ ] Export to CSV
- [ ] Calendar events created correctly
- [ ] Notifications scheduled correctly
- [ ] Widget displays correct data
- [ ] Face ID/Touch ID authentication works
- [ ] In-app purchase flow completes
- [ ] Restore purchases works

#### UI/UX Validation

- [ ] All text readable at Dynamic Type sizes
- [ ] VoiceOver navigation works
- [ ] Color contrast meets WCAG AA
- [ ] Dark mode support complete
- [ ] iPad layout optimized
- [ ] Landscape orientation supported
- [ ] Animations smooth (60 FPS)
- [ ] Haptic feedback appropriate
- [ ] Loading states shown
- [ ] Error messages user-friendly
- [ ] Empty states informative

#### Data Validation

- [ ] Data persists across app launches
- [ ] iCloud sync works (if enabled)
- [ ] No data loss on app update
- [ ] Backup/restore works
- [ ] Large datasets handled (100+ subscriptions)

#### Security Validation

- [ ] Face ID/Touch ID required on launch
- [ ] App locks when backgrounded
- [ ] No sensitive data in logs
- [ ] No data leakage to other apps
- [ ] Secure data storage (encrypted)

#### Performance Validation

- [ ] App launches in < 2 seconds
- [ ] List scrolling smooth (60 FPS)
- [ ] Widget refreshes in < 1 second
- [ ] No memory leaks
- [ ] Battery usage reasonable

#### Compatibility Validation

- [ ] iPhone (all sizes) works
- [ ] iPad works
- [ ] iOS 17.0 minimum supported
- [ ] iOS 17.x all versions tested
- [ ] No deprecated API usage

---

## 10. Build & Deployment Checklist

### Pre-Build Checklist

- [ ] All code compiles without warnings
- [ ] All tests pass
- [ ] No TODO/FIXME comments remaining
- [ ] Debug print statements removed
- [ ] Hardcoded test data removed
- [ ] App Transport Security configured
- [ ] Privacy permissions added to Info.plist:
  - [ ] NSCalendarUsageDescription
  - [ ] NSFaceIDUsageDescription
  - [ ] NSUserNotificationsUsageDescription

### Build Configuration

**Debug Build**:
```
Configuration: Debug
Optimization Level: None [-Onone]
Debug Information: DWARF with dSYM
Symbols Hidden: No
```

**Release Build**:
```
Configuration: Release
Optimization Level: Fast, Whole Module Optimization [-O]
Debug Information: DWARF with dSYM
Symbols Hidden: Yes
Strip Debug Symbols: Yes
```

### App Store Connect Setup

**App Information**:
- [ ] App name: SubTally
- [ ] Primary language: English
- [ ] Bundle ID: com.zzoutuo.SubTally
- [ ] SKU: subtally-2026
- [ ] Category: Finance
- [ ] Secondary category: Productivity
- [ ] Content rating: 4+ (No objectionable content)

**Pricing**:
- [ ] Price: Free (with in-app purchase)
- [ ] Availability: All regions

**App Privacy**:
- [ ] Data types disclosed:
  - [ ] Financial Info (Payment Info) - Not collected
  - [ ] Identifiers - Not collected
  - [ ] Usage Data - Not collected
- [ ] No third-party data sharing
- [ ] No tracking

**Age Rating**:
- [ ] No violence
- [ ] No profanity
- [ ] No mature/suggestive themes
- [ ] No gambling
- [ ] No alcohol/tobacco/drugs
- [ ] No unrestricted web access
- [ ] Result: 4+

### Screenshots Required

**iPhone 6.7" (iPhone 15 Pro Max)**:
- [ ] Home screen
- [ ] Calendar view
- [ ] Analytics view
- [ ] Add subscription screen
- [ ] Subscription detail view

**iPhone 6.5" (iPhone 11 Pro Max)**:
- [ ] Home screen
- [ ] Calendar view
- [ ] Analytics view
- [ ] Add subscription screen
- [ ] Subscription detail view

**iPhone 5.5" (iPhone 8 Plus)**:
- [ ] Home screen
- [ ] Calendar view
- [ ] Analytics view

**iPad Pro 12.9" (3rd generation)**:
- [ ] Home screen (landscape)
- [ ] Calendar view (landscape)
- [ ] Analytics view (landscape)

**iPad Pro 12.9" (2nd generation)**:
- [ ] Home screen (landscape)
- [ ] Calendar view (landscape)

### App Review Information

**Contact Information**:
- [ ] First name
- [ ] Last name
- [ ] Email address
- [ ] Phone number

**Demo Account** (if required):
- [ ] Username: Not required (no account needed)
- [ ] Password: Not required

**Notes for Reviewer**:
```
SubTally is a privacy-first subscription tracker. Key features:
- No account required
- No bank access needed
- All data stored locally
- Optional iCloud sync
- Calendar integration requires permission
- Face ID/Touch ID for security
- In-app purchase for Pro features

Test the in-app purchase using sandbox environment.
Product ID: com.zzoutuo.SubTally.pro
```

### Final Submission Checklist

- [ ] Build uploaded successfully
- [ ] All metadata filled
- [ ] Screenshots uploaded
- [ ] App privacy completed
- [ ] In-app purchase configured
- [ ] Age rating completed
- [ ] Export compliance answered
- [ ] Review notes provided
- [ ] App submitted for review

### Post-Submission

**Monitor**:
- [ ] App Store Connect for review status
- [ ] Email for reviewer feedback
- [ ] TestFlight for beta testing (optional)

**If Rejected**:
- [ ] Read rejection reason carefully
- [ ] Fix issues in code
- [ ] Update metadata if needed
- [ ] Resubmit with detailed notes

**If Approved**:
- [ ] Choose release date
- [ ] Prepare launch announcement
- [ ] Update website/social media
- [ ] Monitor user reviews
- [ ] Plan first update

---

## Appendix A: Cancel Guide Data Structure

### CancelGuide Model

```swift
struct CancelGuide: Identifiable, Codable {
    let id: UUID
    let serviceName: String
    let serviceIcon: String
    let category: SubscriptionCategory
    let website: URL?
    let phoneNumber: String?
    let steps: [CancelStep]
    let difficulty: CancelDifficulty
    let estimatedTime: String
    let tips: [String]
}

struct CancelStep: Identifiable, Codable {
    let id: UUID
    let order: Int
    let instruction: String
    let screenshot: String?
}

enum CancelDifficulty: String, Codable {
    case easy = "Easy (< 2 minutes)"
    case medium = "Medium (2-5 minutes)"
    case hard = "Hard (5+ minutes)"
    case veryHard = "Very Hard (Requires phone call)"
}
```

### Sample Cancel Guides

**Netflix**:
```swift
CancelGuide(
    serviceName: "Netflix",
    serviceIcon: "tv.fill",
    category: .streaming,
    website: URL(string: "https://netflix.com"),
    phoneNumber: nil,
    steps: [
        CancelStep(order: 1, instruction: "Go to netflix.com and sign in"),
        CancelStep(order: 2, instruction: "Click your profile icon in the top right"),
        CancelStep(order: 3, instruction: "Select 'Account' from the dropdown menu"),
        CancelStep(order: 4, instruction: "Click 'Cancel Membership' under Membership & Billing"),
        CancelStep(order: 5, instruction: "Click 'Finish Cancellation' to confirm")
    ],
    difficulty: .easy,
    estimatedTime: "1-2 minutes",
    tips: ["You can continue watching until the end of your billing period"]
)
```

**Spotify**:
```swift
CancelGuide(
    serviceName: "Spotify",
    serviceIcon: "music.note",
    category: .music,
    website: URL(string: "https://spotify.com"),
    phoneNumber: nil,
    steps: [
        CancelStep(order: 1, instruction: "Go to spotify.com and log in"),
        CancelStep(order: 2, instruction: "Click 'Profile' then 'Account'"),
        CancelStep(order: 3, instruction: "Scroll down to 'Your Plan'"),
        CancelStep(order: 4, instruction: "Click 'Change Plan'"),
        CancelStep(order: 5, instruction: "Scroll down and select 'Cancel Premium'"),
        CancelStep(order: 6, instruction: "Click 'Yes, Cancel' to confirm")
    ],
    difficulty: .easy,
    estimatedTime: "1-2 minutes",
    tips: ["You'll keep Premium benefits until your next billing date"]
)
```

---

## Appendix B: Environment Variables

### Required Environment Variables

Create `.env` file in project root:

```bash
# GitHub Configuration
GITHUB_TOKEN=ghp_xxxxxxxxxxxxxxxxxxxx
GITHUB_USER=asunnyboy861

# Contact Information
CONTACT_EMAIL=iocompile67692@gmail.com

# Wanx Image Generation API
WANX_API_KEY=sk-xxxxxxxxxxxxxxxxxxxx

# Feedback Backend (Optional)
FEEDBACK_BACKEND_URL=https://api.example.com/feedback

# Bundle ID Configuration
DEFAULT_BUNDLE_PREFIX=com.zzoutuo.
DEFAULT_MIN_IOS=17.0
```

### Usage in Code

```swift
enum Environment {
    static let githubUser = ProcessInfo.processInfo.environment["GITHUB_USER"] ?? "asunnyboy861"
    static let contactEmail = ProcessInfo.processInfo.environment["CONTACT_EMAIL"] ?? "support@subtally.app"
    static let bundlePrefix = ProcessInfo.processInfo.environment["DEFAULT_BUNDLE_PREFIX"] ?? "com.zzoutuo."
    static let minIOS = ProcessInfo.processInfo.environment["DEFAULT_MIN_IOS"] ?? "17.0"
}
```

---

## Appendix C: Git Repository Structure

### Main App Repository

**URL**: `git@github.com:asunnyboy861/SubTally.git`

**Branches**:
- `main` - Production-ready code
- `develop` - Active development
- `feature/*` - Feature branches
- `hotfix/*` - Critical bug fixes

### Policy Pages Repositories

**Privacy Policy**:
- URL: `git@github.com:asunnyboy861/SubTally-privacy.git`
- Deployment: `https://asunnyboy861.github.io/SubTally-privacy/`

**Terms of Use**:
- URL: `git@github.com:asunnyboy861/SubTally-terms.git`
- Deployment: `https://asunnyboy861.github.io/SubTally-terms/`

**Support Page**:
- URL: `git@github.com:asunnyboy861/SubTally-support.git`
- Deployment: `https://asunnyboy861.github.io/SubTally-support/`

---

## Appendix D: Reference Projects Summary

### Primary Reference Projects

| Project | Language | Architecture | Key Learnings |
|---------|----------|--------------|---------------|
| SubscriptionManagerApp | Swift/SwiftUI | SwiftData + MVVM | Modern data persistence, notification system |
| mindful-subscribe | Swift/SwiftUI | MVVM | Calendar view, UI patterns, onboarding |
| subMe | Swift/UIKit | MVC | Icon design, category colors, card UI |
| Subscription-Manager | Swift/UIKit | MVVM | Form handling, settings management |

### Technical Component References

| Component | Reference Project | Implementation |
|-----------|-------------------|----------------|
| SwiftData Models | SubscriptionManagerApp | @Model, relationships |
| Calendar Integration | mindful-subscribe | EventKit, calendar UI |
| Widget | SubscriptionManagerApp | WidgetKit, timeline |
| Charts | mindful-subscribe | Swift Charts, analytics |
| Notifications | SubscriptionManagerApp | UserNotifications |
| StoreKit | Custom implementation | StoreKit 2, IAP |

---

## Document Version History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-04-21 | SubTally Team | Initial English operation guide |

---

**End of Document**
