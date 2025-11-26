# Tasks: Initial Application Architecture

This document lists the tasks required to implement the proposed initial application architecture.

1.  **Project Setup**:
    *   [ ] Initialize a new Spring Boot project using Gradle.
    *   [ ] Add required dependencies to `build.gradle`:
        *   `spring-boot-starter-web`
        *   `spring-boot-starter-data-jpa`
        *   `mysql-connector-java`
        *   `spring-boot-starter-security`
        *   `lombok`
        *   `jjwt` (for JWT token handling)
        *   `spring-boot-starter-test` (for testing)

2.  **Domain Model (Entities)**:
    *   [ ] Create the `User` entity with fields for username, password, and roles.
    *   [ ] Create the `Product` (or `MenuItem`) entity with fields for name, description, price, etc.
    *   [ ] Create the `Order` entity with a reference to the `User` and a list of `OrderItems`.
    *   [ ] Create the `OrderItem` entity with references to the `Order` and `Product`.

3.  **Data Access Layer (Repositories)**:
    *   [ ] Create `UserRepository` extending `JpaRepository`.
    *   [ ] Create `ProductRepository` extending `JpaRepository`.
    *   [ ] Create `OrderRepository` extending `JpaRepository`.

4.  **Service Layer**:
    *   [ ] Create `UserService` with methods for user registration and loading user details.
    *   [ ] Create `ProductService` with methods to find and manage products.
    *   [ ] Create `OrderService` with methods to create orders and retrieve order history.

5.  **Presentation Layer (Controllers)**:
    *   [ ] Create `AuthController` for user login and registration, returning JWT tokens.
    *   [ ] Create `ProductController` with public endpoints for listing products.
    *   [ ] Create `OrderController` with secured endpoints for order management.
    *   [ ] Create `AdminController` with secured endpoints for administrative tasks.

6.  **Security Configuration**:
    *   [ ] Configure Spring Security to use JWT for authentication.
    *   [ ] Implement a `JwtTokenProvider` to generate and validate tokens.
    *   [ ] Configure authorization rules based on user roles (e.g., `/admin/**` for ADMIN, `/orders/**` for USER).

7.  **Testing**:
    *   [ ] Write unit tests for the service layer components.
    *   [ ] Write integration tests for the controller endpoints using `MockMvc`.

8.  **Configuration**:
    *   [ ] Configure the `application.properties` file with MySQL database connection details.

---

# 任務：初始應用程式架構

本文件列出了實現所提議的初始應用程式架構所需的任務。

1.  **專案設定 (Project Setup)**:
    *   [ ] 使用 Gradle 初始化一個新的 Spring Boot 專案。
    *   [ ] 將所需的依賴項添加到 `build.gradle` 中：
        *   `spring-boot-starter-web`
        *   `spring-boot-starter-data-jpa`
        *   `mysql-connector-java`
        *   `spring-boot-starter-security`
        *   `lombok`
        *   `jjwt` (用於 JWT 權杖處理)
        *   `spring-boot-starter-test` (用於測試)

2.  **領域模型 (Domain Model / Entities)**:
    *   [ ] 建立 `User` 實體，包含使用者名稱、密碼和角色等欄位。
    *   [ ] 建立 `Product` (或 `MenuItem`) 實體，包含名稱、描述、價格等欄位。
    *   [ ] 建立 `Order` 實體，包含對 `User` 的引用和 `OrderItems` 列表。
    *   [ ] 建立 `OrderItem` 實體，包含對 `Order` 和 `Product` 的引用。

3.  **資料存取層 (Data Access Layer / Repositories)**:
    *   [ ] 建立繼承自 `JpaRepository` 的 `UserRepository`。
    *   [ ] 建立繼承自 `JpaRepository` 的 `ProductRepository`。
    *   [ ] 建立繼承自 `JpaRepository` 的 `OrderRepository`。

4.  **服務層 (Service Layer)**:
    *   [ ] 建立 `UserService`，包含用於使用者註冊和載入使用者詳細資訊的方法。
    *   [ ] 建立 `ProductService`，包含用於查找和管理商品的方法。
    *   [ ] 建立 `OrderService`，包含用於建立訂單和檢索訂單歷史的方法。

5.  **表現層 (Presentation Layer / Controllers)**:
    *   [ ] 建立 `AuthController`，用於使用者登入和註冊，並返回 JWT 權杖。
    *   [ ] 建立 `ProductController`，包含用於列出商品的公共端點。
    *   [ ] 建立 `OrderController`，包含用於訂單管理的受保護端點。
    *   [ ] 建立 `AdminController`，包含用於管理任務的受保護端點。

6.  **安全性設定 (Security Configuration)**:
    *   [ ] 設定 Spring Security 以使用 JWT 進行身份驗證。
    *   [ ] 實作一個 `JwtTokenProvider` 來產生和驗證權杖。
    *   [ ] 根據使用者角色設定授權規則（例如，`/admin/**` 給 ADMIN，`/orders/**` 給 USER）。

7.  **測試 (Testing)**:
    *   [ ] 為服務層元件編寫單元測試。
    *   [ ] 使用 `MockMvc` 為控制器端點編寫整合測試。

8.  **設定 (Configuration)**:
    *   [ ] 設定 `application.properties` 檔案，包含 MySQL 資料庫連接詳細資訊。