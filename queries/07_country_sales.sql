SELECT Country, SUM(Quantity*Price) AS SumSales
FROM Customers
JOIN Orders ON Orders.CustomerID=Customers.CustomerID
JOIN OrderDetails ON OrderDetails.OrderID=Orders.OrderID
JOIN Products ON Products.ProductID=OrderDetails.ProductID
GROUP BY Country
ORDER BY SumSales DESC
