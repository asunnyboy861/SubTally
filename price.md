# Price Configuration

## Monetization Model
One-time Purchase (Non-consumable)

## Product Details

### SubTally Pro
- **Reference Name**: SubTally Pro
- **Product ID**: `com.zzoutuo.SubTally.pro`
- **Price**: $4.99 (USD)
- **Type**: Non-consumable (One-time purchase)
- **Localization (English US)**:
  - Display Name: SubTally Pro (max 35 chars)
  - Description: Unlock unlimited tracking forever (max 55 chars)

## Free vs Pro Features

### Free Version
- Track up to 5 subscriptions
- Basic analytics and reminders
- Cancel guides for all services
- Payment calendar view

### Pro Version (One-time Purchase)
- Unlimited subscription tracking
- Calendar sync (EventKit integration)
- Advanced analytics with charts
- CSV export functionality
- All future features

## App Store Connect Setup Instructions

1. Go to App Store Connect → Your App → Features → In-App Purchases
2. Click "+" to create a new In-App Purchase
3. Select Type: **Non-Consumable**
4. Configure the following:
   - Reference Name: `SubTally Pro`
   - Product ID: `com.zzoutuo.SubTally.pro`
   - Price: $4.99 (Tier 5)
5. Add Localization (English US):
   - Display Name: `SubTally Pro`
   - Description: `Unlock unlimited tracking forever`
6. Upload screenshot (required for review)
7. Submit for review

## StoreKit Configuration

### Product ID Constant
```swift
// In AppConstants.swift
static let proProductId = "com.zzoutuo.SubTally.pro"
```

### PurchaseManager Implementation
The app uses StoreKit 2 with the following features:
- Dynamic pricing from StoreKit (`product.displayPrice`)
- Transaction verification
- Purchase status tracking
- Restore purchases functionality

## Paywall Requirements (Already Implemented)

- [x] Product name displayed: "SubTally Pro"
- [x] Dynamic pricing from StoreKit
- [x] One-time purchase clearly indicated
- [x] Restore Purchases button implemented
- [x] Privacy Policy link included
- [x] Terms of Use link included

## App Store Description (Already in keytext.md)

The app description includes the following purchase information:
```
UPGRADE TO PRO:
• Unlimited subscription tracking
• Calendar sync
• Advanced analytics
• CSV export
• All future features

One-time purchase. No recurring fees. Ever.
```

## Compliance Checklist

- [x] StoreKit 2 integration complete
- [x] Product ID matches App Store Connect configuration
- [x] Dynamic pricing from StoreKit (no hardcoded prices)
- [x] Restore Purchases button functional
- [x] Privacy Policy link functional
- [x] Terms of Use link functional
- [x] Transaction verification implemented
- [x] Purchase status tracking implemented
- [x] Error handling with user-friendly messages
- [x] Loading states during purchase/restore
