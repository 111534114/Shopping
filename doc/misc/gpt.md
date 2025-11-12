# 點飲料點餐系統 — 參考資料（Reference.md）

## 🧭 一、系統開發與架構參考

### 🔹 技術實作範例（前後端架構）
| 主題 | 內容 | 參考資料 |
|------|------|-----------|
| Spring Boot + MySQL 點餐系統範例 | 包含 RESTful API、訂單資料表、前端 AJAX 呼叫。 | [Spring Boot Order System Example on GitHub](https://github.com/search?q=spring+boot+order+system) |
| Node.js + Express 飲料點餐系統 | 使用 Express 架設後端、EJS/React/Vue 前端介面。 | [Node.js Food Ordering Example](https://github.com/topics/food-ordering-system) |
| Vue.js / React 前端設計 | 提供顧客端購物車、訂單追蹤畫面。 | [Vue.js E-commerce Example](https://github.com/topics/vue-ecommerce) |
| WebSocket 即時訂單狀態 | 讓前台能即時顯示「準備中 / 完成待取餐」。 | [Spring Boot WebSocket Chat Example](https://spring.io/guides/gs/messaging-stomp-websocket/) |

---
## 🧩 二、資料庫設計參考

| 資料表 | 建議欄位 | 說明 |
|--------|------------|------|
| users | id, username, password, role, phone | 儲存顧客 / 店員 / 管理員資訊 |
| menu_items | id, name, price, category, description, image_url | 飲品基本資料 |
| orders | id, user_id, total_price, status, created_at | 訂單主檔 |
| order_items | id, order_id, menu_item_id, quantity, sugar_level, ice_level | 訂單細項（含客製化） |
| payments（可選） | id, order_id, method, status, transaction_id | 支付紀錄（信用卡 / LINE Pay） |

📘 推薦參考資料：
- [Database Normalization (3NF) 教學](https://www.guru99.com/database-normalization.html)
- [MySQL 資料表設計實務](https://dev.mysql.com/doc/refman/8.0/en/create-table.html)

---

## 🧠 三、功能與流程設計範例

### 🔸 使用案例（Use Case）參考
| 用例名稱 | 主要行為者 | 說明 |
|-----------|--------------|------|
| UC01：建立訂單 | 顧客 | 顧客選擇飲品並送出訂單 |
| UC02：付款完成 | 顧客 | 完成線上支付並等待系統確認 |
| UC03：接收訂單通知 | 店員 | 後台顯示新訂單待處理 |
| UC04：更新訂單狀態 | 店員 | 訂單改為「準備中」或「已完成」 |
| UC05：菜單管理 | 管理員 | 新增 / 修改 / 刪除飲品項目 |

📖 推薦範例：
- [UML Use Case Example for Online Ordering System](https://creately.com/diagram/example/h2jvlnq63/online-food-ordering-system-use-case-diagram)

---

## 🎨 四、前端UI/UX設計參考

| 主題 | 說明 | 參考資源 |
|------|------|-----------|
| 飲料點餐網站範例 | 類似 COCO、清心福全等品牌的網站流程設計。 | [Dribbble 搜尋 "Drink Ordering App"](https://dribbble.com/search/drink%20ordering) |
| 前端模板 | 免費可改用的 Bootstrap / Vue 點餐模板。 | [Bootstrap Restaurant Template](https://startbootstrap.com/theme/resto) |
| 線上支付流程設計 | 模擬信用卡 / LINE Pay 支付 UX。 | [LINE Pay Developers Guide](https://pay.line.me/developers/) |

---

## 📊 五、進階功能與延伸方向

| 功能 | 實作方式 | 參考資料 |
|------|-----------|-----------|
| 即時通知 | 使用 WebSocket / Firebase Realtime Database | [WebSocket 教學（Spring Boot）](https://spring.io/guides/gs/messaging-stomp-websocket/) |
| 報表分析 | 統計每週銷售、熱門飲品 | [Chart.js 圖表套件](https://www.chartjs.org/docs/latest/) |
| 外送定位 | 整合 Google Maps API | [Google Maps JavaScript API](https://developers.google.com/maps/documentation/javascript) |
| 會員制度 | JWT 驗證 + 優惠券表 | [Spring Security JWT 教學](https://www.baeldung.com/spring-security-oauth-jwt) |

---

## 📚 六、學術與技術參考文獻

1. 王俊傑（2023）。*以 Spring Boot 架構設計線上訂餐系統*。資訊工程學刊。
2. 李柏廷（2022）。*Web 前後端分離架構於餐飲業系統實作之研究*。科技大學碩士論文。
3. W3C (2024). *HTML5 Specification.* [https://www.w3.org/TR/html5/](https://www.w3.org/TR/html5/)
4. Oracle (2023). *MySQL 8.0 Developer Reference.*
5. LINE Pay Developers (2024). *Integration Guide for Web Payments.*
