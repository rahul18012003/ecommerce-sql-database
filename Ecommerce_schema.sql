CREATE DATABASE ECOMMERCE;
USE ECOMMERCE;


CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),															-- Customers Table 
    phone VARCHAR(15),
    city VARCHAR(50),
    created_at DATE
);

INSERT INTO Customers VALUES
(1,'Rahul','Kumar','rahul@gmail.com','9876543210','Hyderabad','2025-01-10'),
(2,'Anita','Sharma','anita@gmail.com','9123456780','Delhi','2025-02-15'),
(3,'Vikram','Singh','vikram@gmail.com','9988776655','Mumbai','2025-03-20'),		-- Customers Data
(4,'Priya','Reddy','priya@gmail.com','9001122334','Chennai','2025-04-12'),
(5,'Arjun','Patel','arjun@gmail.com','9556677889','Ahmedabad','2025-05-05');


CREATE TABLE Categories (
    category_id INT PRIMARY KEY,												-- Categories Table
    category_name VARCHAR(100)
);

INSERT INTO Categories VALUES
(1,'Electronics'),
(2,'Fashion'),																	-- categories Data
(3,'Books'),
(4,'Home Appliances');


CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category_id INT,
    price DECIMAL(10,2),														-- products table
    stock_quantity INT,
    brand VARCHAR(50),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

INSERT INTO Products VALUES
(101,'iPhone 14',1,70000,20,'Apple'),
(102,'Samsung Galaxy S23',1,65000,25,'Samsung'),
(103,'Men T-Shirt',2,1200,100,'Nike'),
(104,'Women Handbag',2,2500,50,'Zara'),
(105,'SQL Programming Book',3,800,40,'Pearson'),
(106,'Microwave Oven',4,9000,15,'LG');


CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,															-- Orders table
    order_status VARCHAR(50),
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Orders VALUES
(1001,1,'2026-03-01','Delivered',71200),
(1002,2,'2026-03-02','Shipped',2500),
(1003,3,'2026-03-05','Delivered',800),
(1004,1,'2026-03-07','Pending',65000);

CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,																	
    quantity INT,																-- Order Items table
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Order_Items VALUES
(1,1001,101,1,70000),
(2,1001,105,1,800),
(3,1001,103,1,1200),
(4,1002,104,1,2500),
(5,1003,105,1,800),
(6,1004,102,1,65000);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_method VARCHAR(50),											-- Payments Table
    payment_status VARCHAR(50),
    payment_date DATE,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);


INSERT INTO Payments VALUES
(1,1001,'UPI','Completed','2026-03-01'),
(2,1002,'Credit Card','Completed','2026-03-02'),
(3,1003,'Debit Card','Completed','2026-03-05'),
(4,1004,'Cash on Delivery','Pending','2026-03-07');



CREATE TABLE Shipping (
    shipping_id INT PRIMARY KEY,
    order_id INT,
    address VARCHAR(200),
    city VARCHAR(50),													-- Shipping Table
    postal_code VARCHAR(10),
    delivery_status VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);


INSERT INTO Shipping VALUES
(1,1001,'MG Road','Hyderabad','500001','Delivered'),
(2,1002,'Connaught Place','Delhi','110001','Shipped'),
(3,1003,'Andheri East','Mumbai','400069','Delivered'),
(4,1004,'Banjara Hills','Hyderabad','500034','Processing');










