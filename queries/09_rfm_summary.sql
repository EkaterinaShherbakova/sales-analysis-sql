WITH T AS (
	SELECT CustomerName, DATEDIFF(DAY, MAX(OrderDate), (SELECT MAX(OrderDate) FROM Orders)) AS Recency
	FROM Customers
	JOIN Orders ON Orders.CustomerID=Customers.CustomerID
	GROUP BY CustomerName
	),
T2 AS (
	SELECT CustomerName, COUNT(OrderID) AS Frequency 
	FROM Customers
	JOIN Orders ON Orders.CustomerID=Customers.CustomerID
	GROUP BY CustomerName
	),
T3 AS (
	SELECT CustomerName, SUM(Quantity*Price) AS Monetary 
	FROM Customers
	JOIN Orders ON Orders.CustomerID=Customers.CustomerID
	JOIN OrderDetails ON Orders.OrderID=OrderDetails.OrderID
	JOIN Products ON Products.ProductID=OrderDetails.ProductID
	GROUP BY CustomerName
    ),
T4 AS (
	SELECT T.CustomerName, T.Recency, T2.Frequency, T3.Monetary,
	NTILE(5) OVER (ORDER BY Recency DESC) AS R_Score, 
		CASE 
			WHEN Frequency >= 7 THEN 5
			WHEN Frequency >= 5 THEN 4
			WHEN Frequency >= 3 THEN 3
			WHEN Frequency >= 2 THEN 2
		ELSE 1
		END AS F_Score,
	NTILE(5) OVER (ORDER BY Monetary)  AS M_Score
	FROM T
	JOIN T2 ON T.CustomerName = T2.CustomerName
	JOIN T3 ON T.CustomerName = T3.CustomerName
    ),
T5 AS (
	SELECT CustomerName, Recency, Frequency, Monetary, R_Score, F_Score, M_Score,
	(R_Score + F_Score + M_Score) AS RFM_Score,
		CASE
    		WHEN (R_Score + F_Score + M_Score) >= 13 THEN 'TOP'
    		WHEN (R_Score + F_Score + M_Score) >= 10 THEN 'LOYAL'
   			WHEN (R_Score + F_Score + M_Score) >= 6 THEN 'RISK'
   		ELSE 'CHURN'
    	END AS Segment
	FROM T4
    )
SELECT Segment, COUNT(CustomerName) AS CountCustomers, SUM(Monetary) AS SumMonetary
FROM T5
GROUP BY Segment
ORDER BY CountCustomers
