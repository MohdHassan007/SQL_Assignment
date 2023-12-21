--Q1.1
-- Create Customers Table
CREATE DATABASE TechShop;
USE TechShop;
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Email VARCHAR(255),
    Phone VARCHAR(20),
    Address VARCHAR(255)
);

-- Create Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(255),
    Description TEXT,
    Price DECIMAL(10, 2),
    Category VARCHAR(50)  
);

-- Create Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Create Inventory Table
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT,
    QuantityInStock INT,
    LastStockUpdate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


--Q3.a Insert atleast 10 sample records into each of the following tables.

INSERT INTO Customers (FirstName, LastName, Email, Phone, Address)
VALUES
('Rahul', 'Kumar', 'rahul.kumar@email.com', '9876543210', '123 Main St'),
('Priya', 'Sharma', 'priya.sharma@email.com', '8887776666', '456 Oak St'),
('Amit', 'Singh', 'amit.singh@email.com', '7776665555', '789 Pine St'),
('Anjali', 'Gupta', 'anjali.gupta@email.com', '5554443333', '101 Maple Ave'),
('Sandeep', 'Patel', 'sandeep.patel@email.com', '3332221111', '246 Elm St'),
('Neha', 'Bose', 'neha.bose@email.com', '2221110000', '135 Cedar St'),
('Raj', 'Sinha', 'raj.sinha@email.com', '9998887777', '567 Birch St'),
('Pooja', 'Malhotra', 'pooja.malhotra@email.com', '8889990000', '876 Walnut St'),
('Arjun', 'Rao', 'arjun.rao@email.com', '7778889999', '543 Oak St'),
('Divya', 'Menon', 'divya.menon@email.com', '6665554444', '987 Pine St');

-- Inserting into Products
INSERT INTO Products (ProductName, Description, Price, Category)
VALUES
('Laptop', 'Powerful laptop for professional use', 49999, 'Electronics'),
('Smartphone', 'Latest smartphone with advanced features', 29999, 'Electronics'),
('Tablet', 'Lightweight and portable tablet', 14999, 'Electronics'),
('Smartwatch', 'Fitness and health tracking smartwatch', 9999, 'Wearable'),
('Headphones', 'Noise-canceling wireless headphones', 6999, 'Audio'),
('Digital Camera', 'High-resolution digital camera', 14999, 'Electronics'),
('Gaming Console', 'Next-gen gaming console', 24999, 'Gaming'),
('Fitness Tracker', 'Activity and sleep tracking fitness band', 4999, 'Wearable'),
('External Hard Drive', '1TB USB 3.0 external hard drive', 7999, 'Storage'),
('Wireless Speaker', 'Bluetooth wireless speaker', 2999, 'Audio');

-- Inserting into Orders
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
VALUES
(1, '2023-01-01', 49999),
(2, '2023-01-02', 29999),
(3, '2023-01-03', 14999),
(4, '2023-01-04', 9999),
(5, '2023-01-05', 6999),
(6, '2023-01-06', 14999),
(7, '2023-01-07', 24999),
(8, '2023-01-08', 4999),
(9, '2023-01-09', 7999),
(10, '2023-01-10', 2999);
-- Inserting into OrderDetails
INSERT INTO OrderDetails (OrderID, ProductID, Quantity)
VALUES
(1, 1, 2),
(2, 2, 1),
(3, 3, 3),
(4, 4, 1),
(5, 5, 2),
(6, 6, 1),
(7, 7, 1),
(8, 8, 2),
(9, 9, 1),
(10, 10, 3);

-- Inserting into Inventory
INSERT INTO Inventory (ProductID, QuantityInStock, LastStockUpdate)
VALUES
(1, 8, '2023-01-01'),
(2, 15, '2023-01-02'),
(3, 10, '2023-01-03'),
(4, 5, '2023-01-04'),
(5, 20, '2023-01-05'),
(6, 7, '2023-01-06'),
(7, 12, '2023-01-07'),
(8, 15, '2023-01-08'),
(9, 8, '2023-01-09'),	
(10, 25, '2023-01-10');


--Q3.b
-- 1. Retrieve names and emails of all customers.
SELECT FirstName, LastName, Email FROM Customers;

-- 2. Retrieve order details including order ID, order date, and customer names.
SELECT Orders.OrderID, Orders.OrderDate, Customers.FirstName, Customers.LastName
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

-- 3. Insert a new customer record into the "Customers" table.
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address)
VALUES ('Arun', 'Kumar', 'arun.kumar@email.com', '1234567890', '321 Pine St');

-- 4. Update the prices of all electronic gadgets in the "Products" table by increasing them by 10%.
UPDATE Products
SET Price = Price * 1.10;

-- 5. Delete a specific order and its associated order details from the "Orders" and "OrderDetails" tables.
DECLARE @OrderIDToDelete INT;
SET @OrderIDToDelete = 3;
DELETE FROM OrderDetails WHERE OrderID = @OrderIDToDelete;
DELETE FROM Orders WHERE OrderID = @OrderIDToDelete;

-- 7. Update the contact information of a specific customer in the "Customers" table.
DECLARE @CustomerIDToUpdate INT;
SET @CustomerIDToUpdate = 2;
UPDATE Customers
SET Email = 'Sharmaa212@email.com', Address = '789 Oak St'
WHERE CustomerID = @CustomerIDToUpdate;

-- 8. Recalculate and update the total cost of each order in the "Orders" table based on the prices and quantities in the "OrderDetails" table.
UPDATE Orders
SET TotalAmount = (
    SELECT SUM(Quantity * Price)
    FROM OrderDetails
    JOIN Products ON OrderDetails.ProductID = Products.ProductID
    WHERE OrderDetails.OrderID = Orders.OrderID
);

-- 9. Delete all orders and their associated order details for a specific customer from the "Orders" and "OrderDetails" tables.
DECLARE @CustomerIDToDelete INT;
SET @CustomerIDToDelete = 5;
DELETE FROM OrderDetails WHERE OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID = @CustomerIDToDelete);
DELETE FROM Orders WHERE CustomerID = @CustomerIDToDelete;

-- 10. Insert a new electronic gadget product into the "Products" table.
INSERT INTO Products (ProductName, Description, Price, Category)
VALUES ('Smart Glasses', 'Augmented reality smart glasses', 799, 'Wearable');

SELECT * from Products;




--4. Joins:

-- 1. Write an SQL query to retrieve a list of all orders along with customer information (e.g., customer name) for each order.
SELECT Orders.OrderID, OrderDate, CONCAT(FirstName, ' ', LastName) AS CustomerName, TotalAmount
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

-- 2. Write an SQL query to find the total revenue generated by each electronic gadget product. Include the product name and the total revenue.
SELECT Products.ProductID, ProductName, SUM(Quantity * Price) AS TotalRevenue
FROM Products
JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
GROUP BY Products.ProductID, ProductName;

-- 3. Write an SQL query to list all customers who have made at least one purchase. Include their names and contact information.
SELECT DISTINCT Customers.CustomerID, FirstName, LastName, Email, Phone
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- 4. Write an SQL query to find the most popular electronic gadget, which is the one with the highest total quantity ordered. Include the product name and the total quantity ordered.
SELECT TOP 1 Products.ProductName, SUM(OrderDetails.Quantity) AS TotalQuantityOrdered
FROM OrderDetails INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.ProductName ORDER BY TotalQuantityOrdered DESC;

-- 5. Write an SQL query to retrieve a list of electronic gadgets along with their corresponding categories.
SELECT ProductName, Category
FROM Products;

-- 6. Write an SQL query to calculate the average order value for each customer. Include the customer's name and their average order value.
SELECT Customers.CustomerID, FirstName, LastName, AVG(TotalAmount) AS AverageOrderValue
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, FirstName, LastName;

-- 7. Write an SQL query to find the order with the highest total revenue. Include the order ID, customer information, and the total revenue.
SELECT TOP 1 Orders.OrderID, OrderDate, CONCAT(FirstName, ' ', LastName) AS CustomerName, TotalAmount
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
ORDER BY TotalAmount DESC;

-- 8. Write an SQL query to list electronic gadgets and the number of times each product has been ordered.
SELECT Products.ProductID, ProductName, COUNT(OrderDetails.OrderID) AS OrderCount
FROM Products
LEFT JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
GROUP BY Products.ProductID, ProductName;

-- 9. Write an SQL query to find customers who have purchased a specific electronic gadget product. Allow users to input the product name as a parameter.
DECLARE @ProductNameParameter VARCHAR(255) = 'Laptop';
SELECT DISTINCT Customers.CustomerID, FirstName, LastName, Email, Phone
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID
WHERE Products.ProductName = @ProductNameParameter;

-- 10. Write an SQL query to calculate the total revenue generated by all orders placed within a specific time period. Allow users to input the start and end dates as parameters.
DECLARE @StartDateParameter DATE = '2023-01-01';
DECLARE @EndDateParameter DATE = '2023-01-31';
SELECT SUM(TotalAmount) AS TotalRevenue
FROM Orders
WHERE OrderDate BETWEEN @StartDateParameter AND @EndDateParameter;



--5. Aggregate Functions and Subqueries:

-- 1. Write an SQL query to find out which customers have not placed any orders.
SELECT CustomerID, FirstName, LastName, Email, Phone
FROM Customers
WHERE CustomerID NOT IN (SELECT DISTINCT CustomerID FROM Orders);

-- 2. Write an SQL query to find the total number of products available for sale.
SELECT COUNT(*) AS TotalProducts
FROM Products;

-- 3. Write an SQL query to calculate the total revenue generated by TechShop.
SELECT SUM(TotalAmount) AS TotalRevenue
FROM Orders;

-- 4. Write an SQL query to calculate the average quantity ordered for products in a specific category. Allow users to input the category name as a parameter.
DECLARE @CategoryParameter VARCHAR(255) = 'Laptop';
SELECT AVG(Quantity) AS AverageQuantityOrdered
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
WHERE Products.Category = @CategoryParameter;

-- 5. Write an SQL query to calculate the total revenue generated by a specific customer. Allow users to input the customer ID as a parameter.
DECLARE @CustomerIDParameter INT = 1;
SELECT SUM(TotalAmount) AS TotalRevenue
FROM Orders
WHERE CustomerID = @CustomerIDParameter;

-- 6. Write an SQL query to find the customers who have placed the most orders. List their names and the number of orders they've placed.
SELECT TOP 1 Customers.CustomerID, FirstName, LastName, COUNT(Orders.OrderID) AS OrderCount
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, FirstName, LastName
ORDER BY OrderCount DESC;

-- 7. Write an SQL query to find the most popular product category, which is the one with the highest total quantity ordered across all orders.
SELECT TOP 1 Products.Category, SUM(Quantity) AS TotalQuantityOrdered
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.Category
ORDER BY TotalQuantityOrdered DESC;

