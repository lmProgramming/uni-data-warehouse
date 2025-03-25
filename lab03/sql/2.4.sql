-- Przygotuj ranking produktów w zale¿noœci od œredniej liczby sprzedanych sztuk. Wy-
-- ró¿nij 3 (prawie równoliczne) grupy produktów: sprzedaj¹cych siê najlepiej, œrednio
-- i najs³abiej.

SELECT 
	Product.ProductID AS "ID produktu",
	Product.Name AS "Nazwa produktu",
	SUM(SalesOrderDetail.OrderQty) AS "Suma liczby sprzedanych sztuk",
	NTILE(3) OVER (ORDER BY SUM(SalesOrderDetail.OrderQty) DESC) AS "Numer grupy"
FROM Production.Product
JOIN Sales.SalesOrderDetail ON SalesOrderDetail.ProductID = Product.ProductID
GROUP BY Product.ProductID, Product.Name
ORDER BY SUM(SalesOrderDetail.OrderQty) DESC