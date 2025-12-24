-- Drop tables if they exist to start from a clean slate
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS menu_items;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS promotions;

-- Table structure for users
CREATE TABLE users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  role VARCHAR(50) NOT NULL, -- Using VARCHAR instead of ENUM for broader compatibility
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table structure for menu_items
CREATE TABLE menu_items (
  item_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT,
  price DECIMAL(10, 2) NOT NULL,
  category VARCHAR(50),
  image_url VARCHAR(255),
  is_available BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- H2 does not support ON UPDATE CURRENT_TIMESTAMP
);

-- Table structure for orders
CREATE TABLE orders (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status VARCHAR(50) NOT NULL DEFAULT 'pending', -- Using VARCHAR instead of ENUM
  total_price DECIMAL(10, 2) NOT NULL,
  payment_method VARCHAR(50),
  notes TEXT,
  FOREIGN KEY (customer_id) REFERENCES users(user_id) ON DELETE RESTRICT
);

-- Table structure for order_items
CREATE TABLE order_items (
  order_item_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  item_id INT NOT NULL,
  quantity INT NOT NULL,
  price_per_item DECIMAL(10, 2) NOT NULL,
  customizations TEXT, -- Using TEXT for customizations
  FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
  FOREIGN KEY (item_id) REFERENCES menu_items(item_id) ON DELETE RESTRICT
);

-- Table structure for promotions
CREATE TABLE promotions (
  promotion_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT,
  type VARCHAR(50) NOT NULL, -- e.g., 'GACHAPON', 'LUCKY_DAY'
  trigger_rule VARCHAR(255), -- e.g., 'order_total >= 120'
  reward VARCHAR(255) NOT NULL, -- e.g., 'GACHAPON_SPIN:1'
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Sample data for users
INSERT INTO users (username, password_hash, email, role) VALUES
('admin', '$2a$12$8.P5V.g4G3g3g.s.Jg4g3e.s.Jg4g3e.s.Jg4g3e.s.Jg4g3e.s.J', 'admin@chihuahua.com', 'admin'),
('customer', '$2a$12$8.P5V.g4G3g3g.s.Jg4g3e.s.Jg4g3e.s.Jg4g3e.s.Jg4g3e.s.J', 'customer@example.com', 'customer');

-- Sample data for menu_items from SD.md
INSERT INTO menu_items (name, description, price, category, image_url, is_available) VALUES
('金蛋奶茶', '金光閃閃的滑嫩布丁在奶茶裡化開，像發現了雞娃娃的寶藏！濃郁奶香、布丁綿密，加上Q彈珍珠，帶來雙重驚喜，幸福感滿滿。', 75.00, '招牌系列', '/images/golden_egg_milk_tea.jpg', TRUE),
('小雞抹茶拿鐵', '綿密抹茶搭配Q彈白玉，就像雞娃娃窩裡的小幸福！抹茶的香氣與牛奶的溫潤融合，每一口都療癒，白玉珍珠更是驚喜小亮點。', 80.00, '拿鐵系列', '/images/chick_matcha_latte.jpg', TRUE),
('咕咕奶茶', '「咕咕叫的招牌奶茶來啦！」 茶香與奶香交織，每一口都像小雞啾啾般活潑可愛。', 55.00, '奶茶系列', '/images/gugu_milk_tea.jpg', TRUE),
('咕韻黑糖鮮奶', '濃郁黑糖熬出的溫潤甜香，遇上香醇鮮奶，再加上Q彈珍珠，每一口都是療癒的幸福感。', 70.00, '鮮奶系列', '/images/brown_sugar_milk.jpg', TRUE),
('百香椰啾綠', '一口酸甜，一口Q彈，還有小雞啾啾的清爽快樂感，這就是百香椰啾綠！', 65.00, '果茶系列', '/images/passionfruit_green_tea.jpg', TRUE);

-- Sample data for promotions
INSERT INTO promotions (name, description, type, trigger_rule, reward, is_active) VALUES
('雞娃娃扭蛋機', '訂單滿120元即可獲得一次扭蛋機會！', 'GACHAPON', 'total_price >= 120', 'GACHAPON_SPIN:1', TRUE),
('金蛋幸運日', '週一限定，點餐即可獲得免費加布丁優惠！', 'LUCKY_DAY', 'day_of_week == 1', 'FREE_TOPPING:Pudding', TRUE);