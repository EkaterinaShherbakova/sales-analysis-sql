SELECT TOP 10 CustomerName, SUM(Price*Quantity) AS OrderSum
FROM Customers
JOIN Orders ON Orders.CustomerID = Customers.CustomerID
JOIN OrderDetails ON OrderDetails.OrderID = Orders.OrderID
JOIN Products ON Products.ProductID = OrderDetails.ProductID
GROUP BY CustomerName
ORDER BY OrderSum DESC
