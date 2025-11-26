# 規格：核心點餐功能 (Core Ordering)

## ADDED Requirements

### #### Requirement: `core-ordering-1` 顧客能夠瀏覽所有飲品
- **As a** 顧客
- **I want to** 看到所有可購買的飲品及其名稱、價格和圖片
- **So that** 我可以決定要點什麼。

#### Scenario: 瀏覽菜單
- **Given** 我是一個顧客且已進入點餐網站
- **When** 我打開菜單頁面
- **Then** 系統應顯示一個列表，其中包含至少「金蛋奶茶」和「咕咕奶茶」等項目，並標明其價格。

### #### Requirement: `core-ordering-2` 顧客能夠將飲品加入購物車
- **As a** 顧客
- **I want to** 將我選擇的飲品加入購物車
- **So that** 我可以一次結帳多個商品。

#### Scenario: 加入購物車
- **Given** 我正在瀏覽菜單
- **When** 我點擊「金蛋奶茶」旁邊的「加入購物車」按鈕
- **Then** 購物車圖示應顯示有「1」個品項。

### #### Requirement: `core-ordering-3` 顧客能夠客製化飲品
- **As a** 顧客
- **I want to** 調整飲品的甜度和冰塊選項
- **So that** 飲品符合我的口味。

#### Scenario: 調整甜度冰塊
- **Given** 我已將「咕咕奶茶」加入購物車
- **When** 我在結帳前點擊該品項的「調整」選項，並選擇「半糖、少冰」
- **Then** 訂單確認頁面應顯示「咕咕奶茶 (半糖、少冰)」。

### #### Requirement: `core-ordering-4` 顧客能夠完成結帳
- **As a** 顧客
- **I want to** 使用線上支付方式（如信用卡）完成訂單付款
- **So that** 我可以成功下單。

#### Scenario: 進行結帳
- **Given** 我的購物車裡有價值 150 元的商品
- **When** 我點擊「前往結帳」，並輸入有效的付款資訊
- **Then** 系統應顯示「訂單已成立」的成功訊息，並提供一個訂單編號。
