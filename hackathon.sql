CREATE DATABASE shop;
USE shop;

CREATE TABLE Customers (
	customer_id VARCHAR(5) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL UNIQUE
);

CREATE TABLE Brands (
	brand_id VARCHAR(5) PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Products (
	product_id VARCHAR(5) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL UNIQUE,
    brand_id VARCHAR(5) NOT NULL,
    FOREIGN KEY (brand_id) REFERENCES Brands(brand_id),
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL
);

CREATE TABLE Orders (
	order_id INT PRIMARY KEY,
    customer_id VARCHAR(5) NOT NULL,
    product_id VARCHAR(5) NOT NULL,
    status VARCHAR(20) NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
	FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Customers VALUES 
('C01', 'Nguyễn Văn An', 'an.nv@gmail.com', '0911111111'),
('C02', 'Nguyễn Thị Mai', 'mai.nt@gmail.com', '0922222222'),
('C03', 'Trần Quang Hải', 'hai.tq@gmail.com', '0933333333'),
('C04', 'Phạm Bảo Ngọc', 'ngoc.pb@gmail.com', '0944444444'),
('C05', 'Vũ Đức Đam', 'duc.vd@gmail.com', '0955555555');

INSERT INTO Brands VALUES 
('B01', 'Apple'),
('B02', 'Samsung'),
('B03', 'Sony'),
('B04', 'Dell');

INSERT INTO Products VALUES 
('P01', 'iPhone 15 Pro Max', 'B01', 30000000, 10),
('P02', 'MacBook Pro M3', 'B01', 45000000, 5),
('P03', 'Galaxy S24 Ultra', 'B02', 25000000, 20),
('P04', 'PlayStation 5', 'B03', 15000000, 8),
('P05', 'Dell XPS 15', 'B04', 35000000, 15);

INSERT INTO Orders VALUES 
(1, 'C01', 'P01', 'Pending', '2025-10-01'),
(2, 'C02', 'P03', 'Completed', '2025-10-02'),
(3, 'C01', 'P02', 'Completed', '2025-10-03'),
(4, 'C04', 'P05', 'Cancelled', '2025-10-04'),
(5, 'C05', 'P01', 'Pending', '2025-10-05');

-- 3
UPDATE Products
SET stock = stock + 10, price = price * 1.05
WHERE product_name = 'DELL XPS 15';

-- 4
UPDATE Customers
SET phone = '0999999999'
WHERE customer_id = 'C03';

-- 5
DELETE FROM Orders 
WHERE status = 'COMPLETED' AND order_date < '2025-10-03';

-- 6
SELECT product_id, product_name, price
FROM Products
WHERE price BETWEEN 15000000 AND 30000000 AND stock > 0;

-- 7
SELECT full_name, email
FROM Customers
WHERE full_name LIKE 'Nguyễn%';

-- 8
SELECT order_id, customer_id, order_date
FROM Orders
ORDER BY order_date DESC;

-- 9
SELECT *
FROM Products 
ORDER BY price DESC 
LIMIT 3;

-- 10
SELECT product_name, stock
FROM Products
LIMIT 2 OFFSET 2;

-- 11
SELECT o.order_id, c.full_name, p.product_name, o.order_date
FROM Orders o
INNER JOIN Customers c ON c.customer_id = o.customer_id
INNER JOIN Products p ON p.product_id = o.product_id;

-- 12
SELECT b.*, p.product_name
FROM Brands b
INNER JOIN Products p ON p.brand_id = b.brand_id;

-- 13
SELECT status, COUNT(*) total_order
FROM Orders
GROUP BY status;

-- 14
SELECT c.full_name, COUNT(c.customer_id) total_order
FROM Orders o
INNER JOIN Customers c ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING COUNT(c.customer_id) >= 2;

-- 15
SELECT product_id, product_name, price
FROM Products
WHERE price > (
	SELECT AVG(price)
    FROM Products
);

-- 16
SELECT c.full_name, c.email
FROM Orders o
INNER JOIN Customers c ON c.customer_id = o.customer_id
INNER JOIN Products p ON p.product_id = o.product_id
WHERE p.product_name = 'iPhone 15 Pro Max';



