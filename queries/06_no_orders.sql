SELECT CustomerName, OrderID
FROM Customers
LEFT JOIN Orders ON Orders.CustomerID = Customers.CustomerID
WHERE OrderID IS NULL
