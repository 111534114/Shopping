# Design: Initial Application Architecture

This document details the proposed software architecture for the Spring Boot shopping application. The design is based on a classic layered architecture pattern, which separates concerns and promotes modularity.

## 1. Architectural Layers

The backend will be structured into the following layers:

### 1.1. Presentation Layer (Controllers)

*   **Responsibility**: This layer is responsible for handling all incoming HTTP requests from the client (frontend). It defines the RESTful API endpoints.
*   **Implementation**: Standard Spring MVC Controllers (`@RestController`).
*   **Details**:
    *   Controllers will delegate business logic to the Service Layer.
    *   They will receive Data Transfer Objects (DTOs) as request bodies and return DTOs as response bodies.
    *   No business logic should reside in the controllers.
*   **Example Components**:
    *   `ProductController`: Handles browsing products.
    *   `OrderController`: Handles order creation and history.
    *   `UserController`: Handles user registration and authentication.
    *   `AdminController`: Handles administrative functions.

### 1.2. Service Layer (Services)

*   **Responsibility**: This layer contains the core business logic of the application. It orchestrates calls to the Data Access Layer and other services.
*   **Implementation**: Spring Service components (`@Service`).
*   **Details**:
    *   Services are transactional (`@Transactional`).
    *   They operate on domain objects (Entities) and use DTOs to communicate with the Presentation Layer.
*   **Example Components**:
    *   `ProductService`: Logic for managing products.
    *   `OrderService`: Logic for placing orders, calculating totals, etc.
    *   `UserService`: Logic for user management.

### 1.3. Data Access Layer (Repositories)

*   **Responsibility**: This layer handles all communication with the database. It abstracts the data source from the rest of the application.
*   **Implementation**: Spring Data JPA repositories (`JpaRepository` interfaces).
*   **Details**:
    *   Repositories will provide CRUD (Create, Read, Update, Delete) operations for the domain entities.
    *   Custom queries can be defined using `@Query` or query methods.
*   **Example Components**:
    *   `ProductRepository`
    *   `OrderRepository`
    *   `UserRepository`

### 1.4. Domain Model (Entities)

*   **Responsibility**: This layer represents the business objects of the application and maps them to database tables.
*   **Implementation**: JPA Entities (`@Entity`).
*   **Details**:
    *   Based on the `REQ.md` keywords, the initial entities will be:
        *   `User`: Represents customers, staff, and admins. Will contain roles.
        *   `Product` (or `MenuItem`): Represents the items for sale.
        *   `Order`: Represents a customer's order.
        *   `OrderItem`: Represents a line item within an order.
    *   Lombok (`@Data`, `@Entity`) will be used to reduce boilerplate code.

## 2. Cross-Cutting Concerns

### 2.1. Security

*   **Responsibility**: Handles authentication (who is the user?) and authorization (what can the user do?).
*   **Implementation**: Spring Security.
*   **Details**:
    *   JWT (JSON Web Tokens) will be used for stateless authentication.
    *   Role-based access control will be implemented to restrict access for `Customer`, `Staff`, and `Admin` roles.

### 2.2. Data Transfer Objects (DTOs)

*   **Responsibility**: DTOs are used to transfer data between the Presentation Layer and the Service Layer. This prevents exposing internal domain models directly to the client and helps tailor data for specific views.
*   **Implementation**: Plain Java Objects (POJOs).
*   **Example Components**:
    *   `UserRegistrationDto`
    *   `ProductDto`
    *   `OrderDto`

## 3. Database Schema

*   **Database**: MySQL
*   **Initial Tables** (based on entities):
    *   `users`
    *   `products` (or `menu_items`)
    *   `orders`
    *   `order_items`
    *   Join tables for relationships (e.g., `user_roles`).

---

# 設計：初始應用程式架構

本文件詳細說明了為 Spring Boot 購物應用程式提議的軟體架構。此設計基於經典的分層架構模式，該模式能分離關注點並促進模組化。

## 1. 架構分層

後端將分為以下幾個層次：

### 1.1. 表現層 (Presentation Layer / Controllers)

*   **職責**: 此層負責處理來自客戶端（前端）的所有傳入 HTTP 請求。它定義了 RESTful API 端點。
*   **實現**: 標準的 Spring MVC 控制器 (`@RestController`)。
*   **詳細資訊**:
    *   控制器會將業務邏輯委派給服務層。
    *   它們將接收資料傳輸物件（DTO）作為請求主體，並返回 DTO 作為回應主體。
    *   控制器中不應包含任何業務邏輯。
*   **範例元件**:
    *   `ProductController`: 處理商品瀏覽。
    *   `OrderController`: 處理訂單建立和歷史記錄。
    *   `UserController`: 處理使用者註冊和身份驗證。
    *   `AdminController`: 處理管理功能。

### 1.2. 服務層 (Service Layer / Services)

*   **職責**: 此層包含應用程式的核心業務邏輯。它協調對資料存取層和其他服務的呼叫。
*   **實現**: Spring 服務元件 (`@Service`)。
*   **詳細資訊**:
    *   服務是交易性的 (`@Transactional`)。
    *   它們操作領域物件（實體），並使用 DTO 與表現層進行通信。
*   **範例元件**:
    *   `ProductService`: 管理商品的邏輯。
    *   `OrderService`: 處理下單、計算總價等的邏輯。
    *   `UserService`: 處理使用者管理的邏輯。

### 1.3. 資料存取層 (Data Access Layer / Repositories)

*   **職責**: 此層處理與資料庫的所有通信。它將資料來源從應用程式的其餘部分抽象出來。
*   **實現**: Spring Data JPA 儲存庫（`JpaRepository` 介面）。
*   **詳細資訊**:
    *   儲存庫將為領域實體提供 CRUD（建立、讀取、更新、刪除）操作。
    *   可以使用 `@Query` 或查詢方法定義自訂查詢。
*   **範例元件**:
    *   `ProductRepository`
    *   `OrderRepository`
    *   `UserRepository`

### 1.4. 領域模型 (Domain Model / Entities)

*   **職責**: 此層代表應用程式的業務物件，並將它們對應到資料庫表。
*   **實現**: JPA 實體 (`@Entity`)。
*   **詳細資訊**:
    *   根據 `REQ.md` 的關鍵字，初始實體將是：
        *   `User`: 代表顧客、員工和管理員。將包含角色資訊。
        *   `Product` (或 `MenuItem`): 代表待售商品。
        *   `Order`: 代表顧客的訂單。
        *   `OrderItem`: 代表訂單中的一個品項。
    *   將使用 Lombok (`@Data`, `@Entity`) 來減少樣板程式碼。

## 2. 橫切關注點 (Cross-Cutting Concerns)

### 2.1. 安全性 (Security)

*   **職責**: 處理身份驗證（使用者是誰？）和授權（使用者可以做什麼？）。
*   **實現**: Spring Security。
*   **詳細資訊**:
    *   將使用 JWT (JSON Web Tokens) 進行無狀態身份驗證。
    *   將實施基於角色的存取控制，以限制 `Customer`、`Staff` 和 `Admin` 角色的存取權限。

### 2.2. 資料傳輸物件 (Data Transfer Objects / DTOs)

*   **職責**: DTO 用於在表現層和服務層之間傳輸資料。這可以防止將內部領域模型直接暴露給客戶端，並有助於為特定視圖量身訂製資料。
*   **實現**: 普通 Java 物件 (POJO)。
*   **範例元件**:
    *   `UserRegistrationDto`
    *   `ProductDto`
    *   `OrderDto`

## 3. 資料庫結構 (Database Schema)

*   **資料庫**: MySQL
*   **初始資料表** (基於實體):
    *   `users`
    *   `products` (或 `menu_items`)
    *   `orders`
    *   `order_items`
    *   用於關聯的連接表 (例如 `user_roles`)。