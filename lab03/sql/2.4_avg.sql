-- Przygotuj ranking produktów w zale¿noœci od œredniej liczby sprzedanych sztuk. Wy-
-- ró¿nij 3 (prawie równoliczne) grupy produktów: sprzedaj¹cych siê najlepiej, œrednio
-- i najs³abiej.

WITH ProductsRanked AS 
(
	SELECT 
		Product.ProductID AS "ID produktu",
		Product.Name AS "Nazwa produktu",
		SUM(SalesOrderDetail.OrderQty) AS "Suma liczby sprzedanych sztuk",
		AVG(CAST(SalesOrderDetail.OrderQty AS DECIMAL(10,2))) AS "Œrednia liczba sprzedanych sztuk",
		NTILE(3) OVER (ORDER BY AVG(CAST(SalesOrderDetail.OrderQty AS FLOAT)) DESC) AS "Numer grupy"
	FROM Production.Product
	JOIN Sales.SalesOrderDetail ON SalesOrderDetail.ProductID = Product.ProductID
	GROUP BY Product.ProductID, Product.Name
)
SELECT 
	ProductsRanked.[ID produktu],
	ProductsRanked.[Nazwa produktu],
	ProductsRanked.[Suma liczby sprzedanych sztuk],
	ProductsRanked.[Œrednia liczba sprzedanych sztuk],
	CASE 
        WHEN "Numer grupy" = 1 THEN 'Najlepiej sprzedaj¹ce siê'
        WHEN "Numer grupy" = 2 THEN 'Œrednio sprzedaj¹ce siê'
        WHEN "Numer grupy" = 3 THEN 'Najs³abiej sprzedaj¹ce siê'
    END AS SalesCategory
FROM ProductsRanked
ORDER BY ProductsRanked.[Œrednia liczba sprzedanych sztuk] DESC
