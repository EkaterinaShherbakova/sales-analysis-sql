WITH T AS (
 SELECT Customers.CustomerID, Customers.CustomerName, MIN(OrderDate) AS FirstOrder
 FROM Customers
 JOIN Orders ON Orders.CustomerID=Customers.CustomerID
 GROUP BY Customers.CustomerID, Customers.CustomerName
    ),
T2 AS (
 SELECT T.CustomerID, T.CustomerName, FORMAT(T.FirstOrder, 'yyyy-MM') AS FirstOrder,
 DATEDIFF(MONTH, T.FirstOrder, Orders.OrderDate) AS Datetdiff
 FROM T
    JOIN Orders ON Orders.CustomerID=T.CustomerID
    )
SELECT FirstOrder, Datetdiff, COUNT(DISTINCT(CustomerName)) AS CountCustomer
FROM T2
GROUP BY FirstOrder, Datetdiff
ORDER BY FirstOrder, Datetdiff
