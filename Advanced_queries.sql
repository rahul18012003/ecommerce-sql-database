-- =============================================
-- ADVANCED SQL – ECOMMERCE DATABASE (Rahul's Project)
-- =============================================

USE ECOMMERCE;

-- 1. VIEW: Customer Order Summary (Reusable)
CREATE VIEW Customer_Order_Summary AS
SELECT 
    c.customer_id, c.first_name, c.last_name, c.city,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent,
    MAX(o.order_date) AS last_order_date
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id;

-- 2. STORED PROCEDURE: Get Revenue by Category
DELIMITER //
CREATE PROCEDURE GetRevenueByCategory()
BEGIN
    SELECT 
        cat.category_name,
        SUM(oi.quantity * oi.price) AS revenue,
        COUNT(DISTINCT o.order_id) AS orders_count
    FROM Categories cat
    JOIN Products p ON cat.category_id = p.category_id
    JOIN Order_Items oi ON p.product_id = oi.product_id
    JOIN Orders o ON oi.order_id = o.order_id
    GROUP BY cat.category_name
    ORDER BY revenue DESC;
END //
DELIMITER ;

-- 3. STORED PROCEDURE: Place New Order (Demo)
DELIMITER //
CREATE PROCEDURE PlaceNewOrder(
    IN p_customer_id INT,
    IN p_product_id INT,
    IN p_quantity INT
)
BEGIN
    DECLARE v_price DECIMAL(10,2);
    DECLARE v_order_id INT;
    
    SELECT price INTO v_price FROM Products WHERE product_id = p_product_id;
    
    INSERT INTO Orders (customer_id, order_date, order_status, total_amount)
    VALUES (p_customer_id, CURDATE(), 'Pending', v_price * p_quantity);
    
    SET v_order_id = LAST_INSERT_ID();
    
    INSERT INTO Order_Items (order_id, product_id, quantity, price)
    VALUES (v_order_id, p_product_id, p_quantity, v_price);
    
    SELECT CONCAT('Order ', v_order_id, ' created successfully!') AS message;
END //
DELIMITER ;

-- 4. VIEW: Pending Payments & Shipping
CREATE VIEW Pending_Orders AS
SELECT 
    o.order_id, c.first_name, c.last_name,
    o.total_amount, p.payment_status, s.delivery_status
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Payments p ON o.order_id = p.order_id
JOIN Shipping s ON o.order_id = s.order_id
WHERE o.order_status = 'Pending' OR p.payment_status = 'Pending';

-- 5. ANALYTICAL QUERY: Average Order Value by City
SELECT 
    c.city,
    COUNT(o.order_id) AS total_orders,
    ROUND(AVG(o.total_amount), 2) AS avg_order_value,
    SUM(o.total_amount) AS city_revenue
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY city_revenue DESC;