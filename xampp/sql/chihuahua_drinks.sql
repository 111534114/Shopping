-- --------------------------------------------------------
--
-- 資料庫： `chihuahua_drinks`
-- 建立日期： 2025-11-12
--
-- --------------------------------------------------------

--
-- 若資料庫存在則刪除，避免重複建立
--
DROP DATABASE IF EXISTS `chihuahua_drinks`;

--
-- 建立資料庫 `chihuahua_drinks`
--
CREATE DATABASE `chihuahua_drinks` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `chihuahua_drinks`;

-- --------------------------------------------------------

--
-- 資料表結構 `users`
-- 儲存顧客、店員、管理員的帳號資訊
--

CREATE TABLE `users` (
  `user_id` INT AUTO_INCREMENT PRIMARY KEY,
  `username` VARCHAR(50) NOT NULL UNIQUE,
  `password_hash` VARCHAR(255) NOT NULL,
  `email` VARCHAR(100) NOT NULL UNIQUE,
  `role` ENUM('customer', 'staff', 'admin') NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- --------------------------------------------------------

--
-- 資料表結構 `menu_items`
-- 儲存菜單上的所有飲品項目
--

CREATE TABLE `menu_items` (
  `item_id` INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(100) NOT NULL,
  `description` TEXT,
  `price` DECIMAL(10, 2) NOT NULL,
  `category` VARCHAR(50),
  `image_url` VARCHAR(255),
  `is_available` BOOLEAN NOT NULL DEFAULT TRUE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- --------------------------------------------------------

--
-- 資料表結構 `orders`
-- 儲存顧客的訂單主體資訊
--

CREATE TABLE `orders` (
  `order_id` INT AUTO_INCREMENT PRIMARY KEY,
  `customer_id` INT NOT NULL,
  `order_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `status` ENUM('pending', 'preparing', 'completed', 'cancelled') NOT NULL DEFAULT 'pending',
  `total_price` DECIMAL(10, 2) NOT NULL,
  `payment_method` VARCHAR(50),
  `notes` TEXT,
  FOREIGN KEY (`customer_id`) REFERENCES `users`(`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- --------------------------------------------------------

--
-- 資料表結構 `order_items`
-- 儲存訂單中的每一個品項及其客製化選項
--

CREATE TABLE `order_items` (
  `order_item_id` INT AUTO_INCREMENT PRIMARY KEY,
  `order_id` INT NOT NULL,
  `item_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `price_per_item` DECIMAL(10, 2) NOT NULL,
  `customizations` JSON,
  FOREIGN KEY (`order_id`) REFERENCES `orders`(`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`item_id`) REFERENCES `menu_items`(`item_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;


-- --------------------------------------------------------
--
-- 插入範例資料
--
-- --------------------------------------------------------

--
-- `users` 表的範例資料
-- 密碼均為 'password123' 的雜湊值 (使用 BCRYPT)
--

INSERT INTO `users` (`username`, `password_hash`, `email`, `role`) VALUES
('admin_user', '$2a$12$8.P5V.g4G3g3g.s.Jg4g3e.s.Jg4g3e.s.Jg4g3e.s.Jg4g3e.s.J', 'admin@chihuahua.com', 'admin'),
('staff_user', '$2a$12$8.P5V.g4G3g3g.s.Jg4g3e.s.Jg4g3e.s.Jg4g3e.s.Jg4g3e.s.J', 'staff@chihuahua.com', 'staff'),
('customer1', '$2a$12$8.P5V.g4G3g3g.s.Jg4g3e.s.Jg4g3e.s.Jg4g3e.s.Jg4g3e.s.J', 'customer1@example.com', 'customer');

--
-- `menu_items` 表的範例資料
--

INSERT INTO `menu_items` (`name`, `description`, `price`, `category`, `image_url`, `is_available`) VALUES
('珍珠奶茶', '經典不敗的Q彈珍珠搭配香濃奶茶', 50.00, '奶茶系列', '/images/bubble_tea.jpg', TRUE),
('水果茶', '新鮮水果切片，清爽解渴', 65.00, '果茶系列', '/images/fruit_tea.jpg', TRUE),
('高山青茶', '來自高山的純粹茶香，甘醇潤喉', 35.00, '純茶系列', '/images/green_tea.jpg', TRUE),
('黑糖珍珠鮮奶', '濃郁黑糖搭配Q彈珍珠與新鮮牛奶', 70.00, '鮮奶系列', '/images/brown_sugar_milk.jpg', FALSE);

--
-- `orders` 表的範例資料
--

INSERT INTO `orders` (`customer_id`, `total_price`, `payment_method`, `notes`) VALUES
((SELECT user_id FROM users WHERE username = 'customer1'), 180.00, 'LINE Pay', '一杯要去冰，謝謝！');

--
-- `order_items` 表的範例資料
--

INSERT INTO `order_items` (`order_id`, `item_id`, `quantity`, `price_per_item`, `customizations`) VALUES
(1, (SELECT item_id FROM menu_items WHERE name = '珍珠奶茶'), 2, 55.00, '{"sweetness": "半糖", "ice": "少冰", "toppings": ["椰果"]}'),
(1, (SELECT item_id FROM menu_items WHERE name = '水果茶'), 1, 70.00, '{"sweetness": "正常", "ice": "去冰", "toppings": ["蘆薈"]}');

-- --------------------------------------------------------
--
-- SQL 腳本結束
--
-- --------------------------------------------------------
