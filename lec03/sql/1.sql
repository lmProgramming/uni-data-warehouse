-- Jaka by�a ��czna suma transakcji (SalesOrderHeader.SubTotal) w poszczeg�lnych latach dla
-- kolejnych dni tygodnia?

SET DATEFIRST 1;

SELECT 
	SUM(SubTotal) AS "Suma",
	DATENAME(DW, OrderDate) AS "Dzie� tygodnia",
	DATEPART(YEAR, OrderDate) AS "Rok"
FROM Sales.SalesOrderHeader
GROUP BY DATENAME(DW, OrderDate), DATEPART(YEAR, OrderDate), DATEPART(DW, OrderDate)
ORDER BY DATEPART(YEAR, OrderDate), DATEPART(DW, OrderDate)