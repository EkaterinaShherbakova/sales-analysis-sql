WITH T AS (
	SELECT CategoryName, ProductName, SUM(Price*Quantity) AS Revenue,
	ROW_NUMBER() OVER (PARTITION BY CategoryName ORDER BY SUM(Price*Quantity) DESC) AS Num
	FROM Categories
	JOIN Products ON Products.CategoryID=Categories.CategoryID
	JOIN OrderDetails ON OrderDetails.ProductID=Products.ProductID
    GROUP BY CategoryName, ProductName
)
SELECT CategoryName, ProductName, Revenue, Num
FROM T
WHERE Num <= 3
