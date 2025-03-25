-- Przygotuj ranking produkt�w w zale�no�ci od �redniej liczby sprzedanych sztuk. Wy-
-- r�nij 3 (prawie r�wnoliczne) grupy produkt�w: sprzedaj�cych si� najlepiej, �rednio
-- i najs�abiej.

SELECT 
	Product.ProductID AS "ID produktu",
	Product.Name AS "Nazwa produktu",
	SUM(SalesOrderDetail.OrderQty) AS "Suma liczby sprzedanych sztuk",
	NTILE(3) OVER (ORDER BY SUM(SalesOrderDetail.OrderQty) DESC) AS "Numer grupy"
FROM Production.Product
JOIN Sales.SalesOrderDetail ON SalesOrderDetail.ProductID = Product.ProductID
GROUP BY Product.ProductID, Product.Name
ORDER BY SUM(SalesOrderDetail.OrderQty) DESC