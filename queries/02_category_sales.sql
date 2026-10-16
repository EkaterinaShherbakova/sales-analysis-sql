SELECT CategoryName, SUM(Price*Quantity) AS CategorySum,
CAST(SUM(Price*Quantity)/SUM(SUM(Price*Quantity)) OVER () * 100 AS DECIMAL(10,2)) AS Precent
FROM Categories
JOIN Products ON Products.CategoryID=Categories.CategoryID
JOIN OrderDetails ON OrderDetails.ProductID=Products.ProductID
GROUP BY CategoryName
ORDER BY Precent DESC
