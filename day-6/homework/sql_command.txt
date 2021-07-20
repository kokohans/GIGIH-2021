CREATE DATABASE food_oms_db_homework;

USE food_oms_db_homework

CREATE TABLE items (
	id int NOT NULL AUTO_INCREMENT,
	name varchar(50) DEFAULT NULL,
	price int DEFAULT 0,
	PRIMARY KEY(id)
);

CREATE TABLE categories (
    id int NOT NULL AUTO_INCREMENT,
    name varchar(50) DEFAULT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE item_categories (
    item_id int,
    category_id int,
    FOREIGN KEY(item_id) REFERENCES items(id),
    FOREIGN KEY(category_id) REFERENCES categories(id)
);

CREATE TABLE customers (
    id int NOT NULL AUTO_INCREMENT,
    name varchar(50),
    phone varchar(25),
    PRIMARY KEY(id),
    UNIQUE(phone)
);

CREATE TABLE orders (
    id int NOT NULL AUTO_INCREMENT,
    date datetime,
    total int DEFAULT 0,
    customer_id int,
    PRIMARY KEY(id),
    FOREIGN KEY(customer_id) REFERENCES customers(id)
);

CREATE TABLE order_detail (
    order_id int,
    item_id int,
    qty int DEFAULT 1,
    FOREIGN KEY(order_id) REFERENCES orders(id),
    FOREIGN KEY(item_id) REFERENCES items(id)
);


INSERT INTO categories (name) VALUES
('main course'),
('dessert'),
('beverage'),
('salad'),
('appetizers');

INSERT INTO items (name, price) VALUES
('Garlic Bread', 20000), 
('Cheese Plate', 15000),
('Nachos', 12000),
('Tossed Salad', 5000),
('Caesar Salad', 15000),
('Soda Pop', 5000),
('Juice', 7000),
('Milk', 6000),
('New York Steak', 50000),
('Chicken Stirfry', 65000),
('Hearty Stew', 50000),
('Apple Pie', 20000), 
('Mocha Cheesecake', 24000), 
('Banana Split', 25000);

INSERT INTO item_categories VALUES
(1, 5),
(2, 5),
(3, 5),
(4, 4),
(5, 4),
(6, 3),
(7, 3),
(8, 3),
(9, 1),
(10, 1),
(11, 1),
(12, 2),
(13, 2),
(14, 2);

INSERT INTO customers (name, phone) VALUES
('keqing', '+6212312411'),
('fischl', '+6212312231'),
('rosaria', '+6212885695'),
('venti', '+6215554123'),
('jean', '+62129996843');

INSERT INTO orders (date, customer_id) VALUES
('2021-07-21 23:50:30', 1),
('2021-07-22 20:50:30', 1),
('2021-07-22 21:20:30', 2),
('2021-07-23 23:20:30', 3),
('2021-07-25 19:20:30', 4);


INSERT INTO order_detail VALUES
(1, 9, 2),
(1, 1, 2),
(1, 8, 2),
(2, 8, 1),
(2, 5, 1),
(3, 7, 10),
(4, 14, 5),
(5, 3, 3),
(5, 8, 3);

UPDATE orders set total = (
    SELECT SUM(items.price * order_detail.qty) FROM items JOIN order_detail ON order_detail.item_id = items.id WHERE order_detail.order_id = 1
) WHERE id = 1;

UPDATE orders set total = (
    SELECT SUM(items.price * order_detail.qty) FROM items JOIN order_detail ON order_detail.item_id = items.id WHERE order_detail.order_id = 2
) WHERE id = 2;

UPDATE orders set total = (
    SELECT SUM(items.price * order_detail.qty) FROM items JOIN order_detail ON order_detail.item_id = items.id WHERE order_detail.order_id = 3
) WHERE id = 3;

UPDATE orders set total = (
    SELECT SUM(items.price * order_detail.qty) FROM items JOIN order_detail ON order_detail.item_id = items.id WHERE order_detail.order_id = 4
) WHERE id = 4;

UPDATE orders set total = (
    SELECT SUM(items.price * order_detail.qty) FROM items JOIN order_detail ON order_detail.item_id = items.id WHERE order_detail.order_id = 5
) WHERE id = 5;


SELECT order_detail.order_id as 'Order ID', orders.date as 'Order Date',customers.name as 'Customer name', customers.phone as 'Customer phone', orders.total as 'Total', GROUP_CONCAT(items.name) as 'Item bought'
FROM items 
JOIN order_detail ON items.id = order_detail.item_id 
JOIN orders ON orders.id = order_detail.order_id 
JOIN customers ON customers.id = orders.customer_id 
GROUP BY order_detail.order_id;
