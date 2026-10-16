SELECT FORMAT(OrderDate, 'yyyy.MM') AS DateOrder, SUM(Price*Quantity) AS Sum
FROM Orders
JOIN OrderDetails ON OrderDetails.OrderID=Orders.OrderID
JOIN Products ON Products.ProductID=OrderDetails.ProductID
GROUP BY FORMAT(OrderDate, 'yyyy.MM')
ORDER BY DateOrder
