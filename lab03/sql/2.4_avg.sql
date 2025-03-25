-- Przygotuj ranking produkt�w w zale�no�ci od �redniej liczby sprzedanych sztuk. Wy-
-- r�nij 3 (prawie r�wnoliczne) grupy produkt�w: sprzedaj�cych si� najlepiej, �rednio
-- i najs�abiej.

WITH ProductsRanked AS 
(
	SELECT 
		Product.ProductID AS "ID produktu",
		Product.Name AS "Nazwa produktu",
		SUM(SalesOrderDetail.OrderQty) AS "Suma liczby sprzedanych sztuk",
		AVG(CAST(SalesOrderDetail.OrderQty AS DECIMAL(10,2))) AS "�rednia liczba sprzedanych sztuk",
		NTILE(3) OVER (ORDER BY AVG(CAST(SalesOrderDetail.OrderQty AS FLOAT)) DESC) AS "Numer grupy"
	FROM Production.Product
	JOIN Sales.SalesOrderDetail ON SalesOrderDetail.ProductID = Product.ProductID
	GROUP BY Product.ProductID, Product.Name
)
SELECT 
	ProductsRanked.[ID produktu],
	ProductsRanked.[Nazwa produktu],
	ProductsRanked.[Suma liczby sprzedanych sztuk],
	ProductsRanked.[�rednia liczba sprzedanych sztuk],
	CASE 
        WHEN "Numer grupy" = 1 THEN 'Najlepiej sprzedaj�ce si�'
        WHEN "Numer grupy" = 2 THEN '�rednio sprzedaj�ce si�'
        WHEN "Numer grupy" = 3 THEN 'Najs�abiej sprzedaj�ce si�'
    END AS SalesCategory
FROM ProductsRanked
ORDER BY ProductsRanked.[�rednia liczba sprzedanych sztuk] DESC
