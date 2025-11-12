# GEMINI.md
所有對話用正體中文，並輸出程式碼

## 專案概觀

這是一個使用 Java Spring Boot 開發的購物應用程式專案。它使用 Gradle 進行建置，並採用 Java 17。專案包含了用於 Web 開發的依賴套件 (`spring-boot-starter-web`) 以及 `lombok`。

## 建置與執行

*   **建置專案：**
    ```bash
    ./gradlew build
    ```
*   **執行應用程式：**
    ```bash
    ./gradlew bootRun
    ```
*   **執行測試：**
    ```bash
    ./gradlew test
    ```

## 開發慣例

*   本專案遵循標準的 Spring Boot 開發慣例。
*   測試使用 JUnit 5 和 Spring Boot 的測試框架編寫。
*   主要的應用程式類別是 `com.example.shopping.ShoppingApplication`。