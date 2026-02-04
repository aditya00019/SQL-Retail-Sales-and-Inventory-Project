CREATE DATABASE retail_db;
USE retail_db;

CREATE TABLE Customers(
customer_id INT PRIMARY KEY,
customer_name VARCHAR(50),
email VARCHAR(100),
city VARCHAR (50),
created_at DATE
);

CREATE TABLE Categories(
Category_id INT PRIMARY KEY,
category_name VARCHAR(50)
);

CREATE TABLE Products(
product_id INT PRIMARY KEY,
product_name VARCHAR(50),
category_id INT,
price DECIMAL(10 ,2),
stock INT,
FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

CREATE TABLE Orders(
order_id INT PRIMARY KEY,
customer_id INT,
order_date DATE,
total_amount DECIMAL(10 ,2),
FOREIGN KEY (customer_id) REFERENCES Customers (customer_id)
);

CREATE TABLE Order_items (
order_item_id INT PRIMARY KEY,
order_id INT,
product_id INT,
quantity INT,
price DECIMAL(10,2),
FOREIGN KEY (order_id) REFERENCES Orders (order_id),
FOREIGN KEY (product_id) REFERENCES Products (product_id)
);

INSERT INTO customers (customer_id, customer_name, email, city, created_at)
 VALUES
(1, 'Amit Sharma', 'amit@gmail.com', 'Delhi', '2024-01-10'),
(2, 'Riya Verma', 'riya@gmail.com', 'Mumbai', '2024-02-05'),
(3, 'Karan Mehta', 'karan@gmail.com', 'Pune', '2024-02-20'),
(4, 'Neha Singh', 'neha@gmail.com', 'Bangalore', '2024-03-01');

INSERT INTO categories (category_id, category_name)
 VALUES
(1, 'Electronics'),
(2, 'Accessories'),
(3, 'Home Appliances');

INSERT INTO products (product_id, product_name, category_id, price, stock) 
VALUES
(101, 'Laptop', 1, 55000, 10),
(102, 'Smartphone', 1, 30000, 20),
(103, 'Mouse', 2, 500, 100),
(104, 'Keyboard', 2, 1500, 50),
(105, 'Mixer Grinder', 3, 4000, 15);

INSERT INTO orders (order_id, customer_id, order_date, total_amount) 
VALUES
(1001, 1, '2024-03-05', 55500),
(1002, 2, '2024-03-08', 30000),
(1003, 3, '2024-03-10', 2000),
(1004, 1, '2024-03-15', 4000);

INSERT INTO order_items (order_item_id, order_id, product_id, quantity, price)
 VALUES
(1, 1001, 101, 1, 55000),
(2, 1001, 103, 1, 500),
(3, 1002, 102, 1, 30000),
(4, 1003, 104, 1, 1500),
(5, 1003, 103, 1, 500),
(6, 1004, 105, 1, 4000);

SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Orders;

#total sales per customer
SELECT c.customer_name , SUM(o.total_amount) AS 
total_spent
FROM Customers c
INNER JOIN Orders o 
ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

#Top quantity sold per product
SELECT p.product_name, SUM(oi.quantity) AS 
total_sold 
FROM Order_items oi
INNER JOIN Products p 
ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;

#low stock products
SELECT product_name, stock
FROM PRODUCTS
WHERE stock < 20;

#Monthly Revenue
SELECT MONTH(order_date) AS month,SUM(total_amount) AS Revenue
FROM Orders
GROUP BY MONTH(order_date);

#View
CREATE VIEW sales_report AS
SELECT o.order_id,c.customer_name,o.order_date,o.total_amount
FROM Orders o
INNER JOIN Customers c ON
o.customer_id = c.customer_id;









