點飲料點餐系統 — 系統設計文件（SD.md）
一、系統架構設計 (System Architecture)
根據 REQ 的定義，本系統採用前後端分離架構。
1. 技術選型
   • Frontend (前台/後台介面): HTML5, CSS3, JavaScript (或 React/Vue 框架), Axios (API 請求)。
   • Backend (後端服務): Spring Boot (Java) 或 Node.js (Express)。
   • Database (資料庫): MySQL 8.0+。
   • Security: JWT (JSON Web Token) 用於身份驗證。
2. 系統模組圖
   graph TD
   Client[顧客/店員/管理員 瀏覽器] -->|HTTPS| Frontend[前端應用程式]
   Frontend -->|RESTful API| Backend[後端 API 伺服器]
   Backend -->|JDBC/ORM| DB[(MySQL 資料庫)]
   Backend -->|API| PaymentGW[金流模擬/LINE Pay API]

--------------------------------------------------------------------------------
二、資料庫設計 (Database Schema)
根據 REQ 與「資料表檢查」規則，設計以下資料表以支援功能。
1. users (使用者資料表)
   用於儲存所有角色的登入資訊。
   • id (PK, INT, Auto Increment): 使用者 ID
   • username (VARCHAR): 帳號
   • password (VARCHAR): 加密後的密碼
   • role (ENUM): 角色權限 ('CUSTOMER', 'STAFF', 'ADMIN')
   • created_at (DATETIME): 建立時間
2. menu_items (飲品菜單表)
   支援 REQ F1, B4 功能。
   • id (PK, INT, Auto Increment): 商品 ID
   • name (VARCHAR): 飲品名稱 (如：珍珠奶茶)
   • description (TEXT): 飲品介紹
   • price (DECIMAL): 單價
   • image_url (VARCHAR): 圖片連結
   • category (VARCHAR): 分類 (如：茶類, 奶類)
   • is_available (BOOLEAN): 上架狀態 (True: 上架 / False: 下架)
3. orders (訂單主表)
   支援 REQ F4, F5, B1, B2, B5 功能。
   • id (PK, INT, Auto Increment): 訂單編號
   • user_id (FK, INT): 下單顧客 ID (若支援訪客可為 Null)
   • total_amount (DECIMAL): 訂單總金額
   • status (ENUM): 訂單狀態 ('PENDING', 'PREPARING', 'COMPLETED', 'CANCELLED')
   • payment_method (VARCHAR): 付款方式 ('CREDIT_CARD', 'LINE_PAY')
   • created_at (DATETIME): 下單時間 (用於銷售報表統計)
   • updated_at (DATETIME): 狀態更新時間
4. order_items (訂單明細表)
   支援 REQ F2, F3 功能，記錄客製化選項。
   • id (PK, INT, Auto Increment): 明細 ID
   • order_id (FK, INT): 關聯訂單 ID
   • menu_item_id (FK, INT): 關聯飲品 ID
   • quantity (INT): 數量
   • sugar_level (VARCHAR): 甜度 (全糖, 半糖, 微糖, 無糖)
   • ice_level (VARCHAR): 冰塊 (正常, 少冰, 去冰, 熱)
   • toppings (VARCHAR): 加料備註 (如：珍珠, 椰果)
   • subtotal (DECIMAL): 該項小計 (單價 * 數量)

--------------------------------------------------------------------------------
三、API 介面設計 (API Specification)
根據 REQ 功能需求 與「API ↔ 功能對不上」檢查規則 定義。
1. 認證相關 (Auth)
   • POST /api/auth/login: 使用者登入 (回傳 JWT)。
   • POST /api/auth/register: 顧客註冊。
2. 菜單與商品 (Menu) — 對應 REQ F1, B4
   • GET /api/menu: 取得所有上架飲品 (Public)。
   • GET /api/menu/{id}: 取得特定飲品詳情。
   • POST /api/admin/menu: 新增飲品 (Admin only)。
   • PUT /api/admin/menu/{id}: 修改飲品資訊/上下架 (Admin only)。
   • DELETE /api/admin/menu/{id}: 刪除飲品 (Admin only)。
3. 訂單處理 (Orders) — 對應 REQ F3, F4, F5, B1, B2, B3
   • POST /api/orders: 建立新訂單 (顧客結帳)。
   ◦ Input: items list (product_id, quantity, sugar, ice), payment_method.
   • GET /api/orders/my-orders: 顧客查詢自己的歷史訂單。
   • GET /api/staff/orders: 店員查詢訂單列表 (支援狀態篩選)。
   • PATCH /api/staff/orders/{id}/status: 更新訂單狀態 (Pending -> Preparing -> Completed)。
   ◦ Input: status.
4. 報表統計 (Reports) — 對應 REQ B5
   • GET /api/admin/reports/sales: 取得銷售統計數據。
   ◦ Params: startDate, endDate.
   ◦ Output: 區間內總銷售額、熱門飲品排行。

--------------------------------------------------------------------------------
四、核心流程詳細設計 (Core Flows)
根據「流程檢查」規則，將 REQ 中的 P1 與 P2 流程具體化為前後端互動步驟。
流程一：顧客下單流程 (Customer Order Flow)
目標：完成選購並建立訂單。
1. [使用者] 在前端點選飲品，選擇「微糖、去冰」，點擊「加入購物車」。
2. [前端] 將商品資訊暫存於 LocalStorage 或 State 中，更新購物車圖示數量。
3. [使用者] 進入購物車頁面，點擊「確認結帳」。
4. [前端] 呼叫 API POST /api/orders，傳送包含商品 ID、客製化選項、總金額的 JSON 資料。
5. [後端] 驗證資料合法性（確認商品是否存在、價格是否正確）。
6. [後端-DB] 在 orders 資料表建立一筆新訂單 (Status: PENDING)。
7. [後端-DB] 迴圈將購買品項寫入 order_items 資料表。
8. [後端] 回傳 201 Created 及訂單編號 (Order ID)。
9. [前端] 接收成功回應，清空購物車，跳轉至「訂單追蹤頁面」顯示「已下單」。
   流程二：店員接單與出餐 (Staff Process Flow)
   目標：店員確認訂單並通知顧客取餐。
1. [使用者-店員] 登入後台，進入「訂單管理」頁面。
2. [前端] 呼叫 GET /api/staff/orders?status=PENDING 取得未處理訂單。
3. [後端-DB] 查詢 orders 表中狀態為 PENDING 的資料並回傳。
4. [使用者-店員] 點擊某筆訂單的「開始製作」按鈕。
5. [前端] 呼叫 PATCH /api/staff/orders/{id}/status，帶入 body {status: "PREPARING"}。
6. [後端-DB] 更新該筆訂單 status 為 PREPARING。
7. [後端] 回傳更新成功訊息。
8. [使用者-顧客] (若此時顧客刷新訂單頁) 前端顯示狀態變更為「準備中」。
9. [使用者-店員] 製作完成後，點擊「通知取餐」。
10. [後端-DB] 更新狀態為 COMPLETED，流程結束。

--------------------------------------------------------------------------------
五、自我稽核檢查點 (Self-Audit Check)
依據規則手冊 的自我檢核說明：
1. 意圖一致性: 本 SD 完全對應 REQ 定義的飲品訂購、客製化、訂單管理功能。
2. MVP 可行性:
   ◦ 移除: 複雜的地圖定位與即時推播 (WebSocket) 暫不在 MVP 範圍，改用輪詢 (Polling) 或手動刷新查看狀態，確保 3 週內可完成。
   ◦ 金流: 建議 MVP 階段使用模擬金流 (Mock) 或僅記錄付款方式，不串接真實銀行 API，以降低開發門檻。
3. 資料庫一致性: order_items 表包含了 sugar_level 與 ice_level，解決了 REQ F2 客製化選項的儲存問題。
4. API 對應: 所有 REQ 功能 (F1-F5, B1-B5) 皆有對應的 RESTful API Endpoint。