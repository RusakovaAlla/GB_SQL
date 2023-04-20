USE gb_homework; -- моя база данных для выполнения домашних заданий

-- 1. Создайте таблицу с мобильными телефонами, используя графический интерфейс. 
-- Заполните БД данными. 
-- Добавьте скриншот на платформу в качестве ответа на ДЗ
CREATE TABLE IF NOT EXISTS smartphones 
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(45),
    manufacturer VARCHAR(45), 
    product_count INT,
    price FLOAT
);

INSERT INTO smartphones (product_name, manufacturer, product_count, price)
VALUES 
	("iPhone X", "Apple", 3, 76000),
	("iPhone 8", "Apple", 2, 51000),
    ("Galaxy S9", "Samsung", 2, 56000),
    ("Galaxy S8", "Samsung", 1, 41000),
    ("P20 Pro", "Huawei", 5, 36000);
    
-- 2. Выведите название, производителя и цену для товаров, количество которых превышает 2 
SELECT product_name, manufacturer, price
FROM smartphones
WHERE product_count > 2;

-- 3. Выведите весь ассортимент товаров марки “Samsung”
SELECT product_name, price
FROM smartphones
WHERE manufacturer = "Samsung";

-- 4. Выведите информацию о телефонах, где суммарный чек больше 100 000 и меньше 145 000**
SELECT product_name, price
FROM smartphones
WHERE product_count * price > 100000 AND 
	product_count * price < 145000;
    
-- 4.*** С помощью регулярных выражений найти:
-- 4.1. Товары, в которых есть упоминание "Iphone"
SELECT product_name
FROM smartphones
WHERE product_name LIKE "%Iphone%";

-- 4.2. "Galaxy"
SELECT product_name
FROM smartphones
WHERE product_name LIKE "%Galaxy%";

-- 4.3.  Товары, в которых есть ЦИФРЫ

SELECT product_name
FROM smartphones
WHERE product_name RLIKE "[0-9]";

-- 4.4.  Товары, в которых есть ЦИФРА "8" 

SELECT product_name
FROM smartphones
WHERE product_name RLIKE "8";
