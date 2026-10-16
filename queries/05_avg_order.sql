WITH T AS (
SELECT CustomerName, Orders.OrderID, SUM(Price*Quantity) AS SumOrders
FROM Orders
JOIN Customers ON Orders.CustomerID=Customers.CustomerID
JOIN OrderDetails ON OrderDetails.OrderID=Orders.OrderID
JOIN Products ON Products.ProductID=OrderDetails.ProductID
GROUP BY CustomerName, Orders.OrderID
)
SELECT CustomerName, CAST(AVG(SumOrders) AS DECIMAL(10,2)) AS AvgSumOrders
FROM T
GROUP BY CustomerName
ORDER BY AvgSumOrders DESC
