WITH T AS (
	SELECT CustomerName, SUM(Price*Quantity) AS Monetary 
	FROM Customers
	JOIN Orders ON Orders.CustomerID=Customers.CustomerID
	JOIN OrderDetails ON Orders.OrderID=OrderDetails.OrderID
	JOIN Products ON Products.ProductID=OrderDetails.ProductID
	GROUP BY CustomerName
	),
T2 AS(
	SELECT CustomerName, Monetary,
	SUM(Monetary) OVER (ORDER BY Monetary DESC)/SUM(Monetary) OVER()*100 AS PercentRunning
	FROM T
    )
SELECT CustomerName, Monetary, PercentRunning,
	CASE
    	WHEN PercentRunning <= 80 THEN 'A'
        WHEN PercentRunning <= 95 THEN 'B'
        ELSE 'C'
        END AS ABC_Group
FROM T2
