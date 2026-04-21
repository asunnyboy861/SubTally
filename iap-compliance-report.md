# SubTally IAP 合规性分析报告

## 审核结论
**状态：✅ 基本合规，建议优化**

当前实现符合 Apple IAP 基本要求，但有几处可以优化以提高审核通过率。

---

## 一、当前实现审查

### 1. PurchaseManager.swift

#### ✅ 已合规的项目

| 要求 | 实现状态 | 代码位置 |
|------|----------|----------|
| StoreKit 2 集成 | ✅ | `import StoreKit` + `Product.products(for:)` |
| 动态定价 | ✅ | `product.displayPrice` |
| 交易验证 | ✅ | `checkVerified(_:)` 方法 |
| 交易监听 | ✅ | `listenForTransactions()` |
| 恢复购买 | ✅ | `restorePurchases()` 使用 `AppStore.sync()` |
| 加载状态 | ✅ | `isLoading` + `ProgressView` |
| 错误处理 | ✅ | `errorMessage` + `StoreError` |

#### ⚠️ 需要改进的项目

| 问题 | 严重程度 | 说明 | 建议修复 |
|------|----------|------|----------|
| 缺少购买成功反馈 | 中 | 购买成功后仅关闭页面，无成功提示 | 添加成功提示后再 dismiss |
| 恢复购买无反馈 | 中 | 恢复后无成功/失败提示 | 添加恢复结果提示 |
| 错误消息未显示 | 低 | `errorMessage` 有值但 UI 未展示 | 添加错误提示 Alert |

### 2. PaywallView.swift

#### ✅ 已合规的项目

| 要求 | 实现状态 | 说明 |
|------|----------|------|
| 产品名称显示 | ✅ | "SubTally Pro" |
| 动态价格显示 | ✅ | `product.displayPrice` |
| 一次性购买标识 | ✅ | "Buy Once" / "One-time purchase" |
| 恢复购买按钮 | ✅ | "Restore Purchases" |
| 隐私政策链接 | ✅ | Link to Privacy Policy |
| 使用条款链接 | ✅ | Link to Terms of Use |
| 功能列表 | ✅ | 5个 Pro 功能清晰展示 |
| 免费版限制说明 | ✅ | "Track more than 5 subscriptions" |

#### ⚠️ 需要改进的项目

| 问题 | 严重程度 | 说明 | 建议修复 |
|------|----------|------|----------|
| 无购买成功提示 | 中 | 购买成功后直接关闭，用户不确定是否成功 | 添加成功 Alert |
| 恢复购买无反馈 | 中 | 用户不知道恢复是否成功 | 添加恢复结果提示 |
| 价格加载状态 | 低 | 产品未加载时显示 "Buy Once" 无价格 | 添加加载占位符 |

---

## 二、Apple IAP 规范对比（2025）

### 必须满足的要求（Mandatory）

| # | Apple 要求 | SubTally 状态 | 备注 |
|---|------------|---------------|------|
| 1 | StoreKit 2 API | ✅ 合规 | 使用 `Product.products(for:)` |
| 2 | 产品名称显示 | ✅ 合规 | "SubTally Pro" |
| 3 | 产品类型显示 | ✅ 合规 | "One-time purchase" |
| 4 | 动态定价 | ✅ 合规 | `displayPrice` |
| 5 | 恢复购买按钮 | ✅ 合规 | 已实现 |
| 6 | 隐私政策链接 | ✅ 合规 | 已实现 |
| 7 | 使用条款链接 | ✅ 合规 | 已实现 |
| 8 | 交易验证 | ✅ 合规 | `VerificationResult` |
| 9 | 交易监听 | ✅ 合规 | `Transaction.updates` |
| 10 | 购买状态管理 | ✅ 合规 | `isPro` 跟踪 |

### 禁止的行为（Prohibited）

| # | 禁止行为 | SubTally 状态 | 备注 |
|---|----------|---------------|------|
| 1 | 自动选择高价选项 | ✅ 无此问题 | 一次性购买，无选项 |
| 2 | 隐藏低价选项 | ✅ 无此问题 | 只有一个选项 |
| 3 | 硬编码价格 | ✅ 无此问题 | 使用 `displayPrice` |
| 4 | 误导性定价 | ✅ 无此问题 | 明确显示 "One-time" |
| 5 | 虚假紧迫感 | ✅ 无此问题 | 无倒计时等 |

---

## 三、建议优化项

### 高优先级（建议修复）

#### 1. 添加购买成功反馈
```swift
// 在 PaywallView.swift 的 purchaseButton 中
Button {
    Task {
        if await purchaseManager.purchase() {
            // 添加成功提示
            await MainActor.run {
                showSuccessAlert = true
            }
            dismiss()
        }
    }
}
```

#### 2. 添加恢复购买反馈
```swift
// 在 PurchaseManager.swift 中
func restorePurchases() async -> Bool {
    isLoading = true
    defer { isLoading = false }

    do {
        try await AppStore.sync()
        await updatePurchaseStatus()
        return isPro // 返回恢复是否成功
    } catch {
        errorMessage = error.localizedDescription
        return false
    }
}
```

#### 3. 添加错误提示
```swift
// 在 PaywallView.swift 中添加
.alert("Error", isPresented: .constant(purchaseManager.errorMessage != nil)) {
    Button("OK") { purchaseManager.errorMessage = nil }
} message: {
    Text(purchaseManager.errorMessage ?? "")
}
```

### 中优先级（可选优化）

#### 4. 产品加载占位符
```swift
// 产品未加载时显示加载状态
if purchaseManager.product == nil {
    ProgressView()
        .frame(maxWidth: .infinity)
        .padding()
}
```

#### 5. 添加购买确认对话框
虽然一次性购买不需要像订阅那样详细的条款，但可以添加简单的确认：
```swift
.confirmationDialog("Confirm Purchase", isPresented: $showConfirm) {
    Button("Buy \(product.displayPrice)", role: .none) { /* 执行购买 */ }
    Button("Cancel", role: .cancel) { }
} message: {
    Text("You will be charged \(product.displayPrice) for SubTally Pro. This is a one-time purchase.")
}
```

---

## 四、App Store Connect 配置检查清单

提交审核前，请确认以下配置：

### In-App Purchase 配置
- [ ] Product ID: `com.zzoutuo.SubTally.pro`
- [ ] 类型: Non-Consumable
- [ ] 价格: $4.99 (或其他选择的等级)
- [ ] 显示名称: "SubTally Pro"
- [ ] 描述: "Unlock unlimited tracking forever"
- [ ] 截图: 已上传 paywall 页面截图

### App Store 元数据
- [ ] 隐私政策 URL: https://asunnyboy861.github.io/SubTally-privacy/
- [ ] 使用条款 URL: https://asunnyboy861.github.io/SubTally-terms/
- [ ] 应用描述包含 Pro 功能说明
- [ ] 应用描述包含 "One-time purchase" 说明

---

## 五、总结

### 当前状态
- **技术实现**: 95% 合规
- **UI/UX**: 90% 合规
- **预期审核结果**: 大概率通过，可能要求添加购买反馈

### 建议操作
1. **必须**: 添加购买成功提示
2. **必须**: 添加恢复购买反馈
3. **建议**: 添加错误提示显示
4. **可选**: 添加产品加载占位符

### 审核风险评级
| 项目 | 风险等级 |
|------|----------|
| 技术实现 | 🟢 低 |
| 用户体验 | 🟡 中 |
| 元数据配置 | 🟢 低 |
| **总体** | **🟢 低风险** |

---

## 六、参考文档

- [Apple App Store Review Guidelines - In-App Purchase](https://developer.apple.com/app-store/review/guidelines/#in-app-purchase)
- [StoreKit 2 Documentation](https://developer.apple.com/documentation/storekit)
- [Testing In-App Purchases](https://developer.apple.com/documentation/xcode/testing-in-app-purchases)
