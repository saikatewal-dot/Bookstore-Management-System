use  dbms_project;
# Database

select * from books ; 
select * from customers ; 
select * from orders ; 

# Aggregate function 

SELECT
    COUNT(*) AS Total_Orders,
    SUM(Total_amount) AS Total_Sales,
    AVG(Total_amount) AS Average_Order,
    MAX(Total_amount) AS Highest_Order,
    MIN(Total_amount) AS Lowest_Order
FROM Orders;

# using Join function inner and outer 
#1) inner 
SELECT
    o.Order_ID,
    c.Name AS Customer_Name,
    c.City,
    b.book_id,
    b.author,
    b.Genre,
    o.Order_Date,
    o.Quantity,
    o.Total_Amount
FROM orders o
INNER JOIN customers c
    ON o.Customer_id = c.Customer_id
INNER JOIN books b
    ON o.Book_id = b.Book_id;

#2)outer 
SELECT
    b.Book_ID,
    b.Author,
    b.Genre,
    o.Order_ID,
    o.Quantity,
    o.Total_Amount
FROM Books AS b
LEFT JOIN Orders AS o
    ON b.Book_ID = o.Book_ID;

# Group by funtion 
SELECT 
    customer_id,
    COUNT(*) AS Total_Orders
FROM Orders
GROUP BY customer_id;

# Having + group by + Join 
SELECT
    c.Customer_ID,
    c.name,
    COUNT(o.Order_id) AS Total_Orders
FROM Customers c
INNER JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY
    c.Customer_ID,
    c.name
HAVING COUNT(o.Order_ID) > 2;

    
    
# Sub-querry 

SELECT
    c.customer_id,
    c.name,
    o.order_id,
    o.Total_amount
FROM Customers c
INNER JOIN Orders o
    ON c.customer_id = o.customer_id
WHERE o.Total_amount >
(
    SELECT AVG(o2.Total_amount)
    FROM Orders o2
    WHERE o2.customer_id = o.customer_id
);

# view 1 customer and order
 


alter  VIEW vw_CustomerOrderDetails
AS
SELECT
    o.Order_ID,
    c.Customer_ID,
    c.Name AS Customer_Name,
    b.Book_ID,
    b.Author,
    b.Genre,
    o.Order_Date,
    o.Quantity,
    o.Total_Amount
FROM Orders AS o
INNER JOIN Customers AS c
    ON o.Customer_ID = c.Customer_ID
INNER JOIN Books AS b
    ON o.Book_ID = b.Book_ID;

        
    SELECT * FROM vw_CustomerOrderDetails ;	

    SELECT COUNT(*) AS Total_Orders FROM Orders;
    
#view 2  book only 

alter  VIEW vw_BookSalesSummary
AS
SELECT
    b.Book_ID,
    b.Author,
    b.Genre,
    SUM(o.Quantity) AS Total_Quantity_Sold,
    SUM(o.Total_Amount) AS Total_Sales
FROM Books AS b
INNER JOIN Orders AS o
    ON b.Book_ID = o.Book_ID
GROUP BY
    b.Book_ID,
    b.Author,
    b.Genre;
    
    SELECT * FROM vw_BookSalesSummary;

# Query 1 — Book Sales Analysis
SELECT
    b.Book_ID,
    b.Author,
    b.Genre,
    COUNT(o.Order_ID) AS Total_Orders,
    SUM(o.Quantity) AS Total_Quantity_Sold,
    SUM(o.Total_Amount) AS Total_Sales
FROM Books AS b
INNER JOIN Orders AS o
    ON b.Book_ID = o.Book_ID
INNER JOIN Customers AS c
    ON o.Customer_ID = c.Customer_ID
GROUP BY
    b.Book_ID,
    b.Author,
    b.Genre;

# Query 2 Customer Spending Analysis
SELECT
    c.Customer_ID,
    c.Name,
    c.City,
    COUNT(o.Order_ID) AS Total_Orders,
    SUM(o.Total_Amount) AS Total_Spending
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.Customer_ID = o.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Name,
    c.City
HAVING SUM(o.Total_Amount) > 500
ORDER BY Total_Spending DESC;


INSERT INTO Books
(Book_ID, Title, Author, Genre, Published_Year, Price, Stock)
VALUES
(9999, 'Test Book', 'Test Author', 'Test', 2025, -100, 10);
    
    
