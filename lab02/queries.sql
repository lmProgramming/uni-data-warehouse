-- 1

-- Utworzyć zestawienie, które dla poszczególnych miesięcy i lat przedstawi informację o liczbie różnych klientów. Przygotuj zapytanie z i bez użycia polecenia pivot.

-- normal version

SELECT YEAR(OrderDate), MONTH(OrderDate), COUNT(DISTINCT CustomerID) 
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY YEAR(OrderDate), MONTH(OrderDate)

-- pivot version

WITH UniqueCustomers AS (
    SELECT 
        YEAR(OrderDate) AS OrderYear, 
        MONTH(OrderDate) AS OrderMonth, 
        CustomerID
    FROM Sales.SalesOrderHeader
    GROUP BY YEAR(OrderDate), MONTH(OrderDate), CustomerID
)
SELECT * FROM UniqueCustomers
PIVOT (
    COUNT(CustomerID) 
    FOR OrderMonth IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
) AS PivotTable
ORDER BY OrderYear;

-- 2

-- Utworzyć zestawienie zawierające w wierszach imiona i nazwiska sprzedawców, 
-- a w kolumnach kolejne lata. Wartością będzie liczba obsłużonych transakcji. 
-- Wyświetlić tylko tych sprzedawców, którzy pracowali przez wszystkie 4 lata.

SELECT * FROM
(
	SELECT FirstName, LastName, SalesOrderID, YEAR(OrderDate) AS OrderYear FROM Sales.SalesPerson
	JOIN HumanResources.Employee ON Employee.BusinessEntityID = SalesPerson.BusinessEntityID
	JOIN Person.Person ON Person.BusinessEntityID = Employee.BusinessEntityID
	JOIN Sales.SalesOrderHeader ON SalesOrderHeader.SalesPersonID = SalesPerson.BusinessEntityID
	WHERE YEAR(HireDate) = 2011
) AS SourceTable
PIVOT (
	COUNT(SalesOrderID)
	FOR OrderYear IN ([2011], [2012], [2013], [2014])
) AS PivotedTable
ORDER BY FirstName

-- 3

-- Zdefiniować zapytanie wyznaczające sumę kwot sprzedaży towarów oraz liczbę różnych produktów w zamówieniach w poszczególnych latach, miesiącach, dniach.

SELECT YEAR(OrderDate) AS "Rok", MONTH(OrderDate) AS "Miesiąc", DAY(OrderDate) AS "Dzień", SUM(LineTotal) AS "Suma", COUNT(DISTINCT ProductID) AS "Liczba różnych produktów"
FROM Sales.SalesOrderHeader
JOIN Sales.SalesOrderDetail ON SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesOrderID
GROUP BY YEAR(OrderDate), MONTH(OrderDate), DAY(OrderDate)
ORDER BY YEAR(OrderDate), MONTH(OrderDate), DAY(OrderDate)

-- 4

-- Wykorzystując polecenie CASE przygotować podsumowania do zestawienia z poprzedniego zadania tak, aby sumowane były kwoty zamówień oraz obliczana liczba
-- różnych produktów dla poszczególnych miesięcy i dni tygodnia.
-- Uwaga: Pamiętaj o wybraniu właściwego atrybutu funkcji datepart tak, aby zgadzała się nazwa dnia tygodnia

SET DATEFIRST 1;
SET LANGUAGE Polish;

SELECT 
	YEAR(OrderDate) AS "Rok", 
	DATENAME(month, OrderDate) AS "Miesiąc",     
	CASE DATEPART(dw, OrderDate)
        WHEN 1 THEN 'Poniedziałek'
        WHEN 2 THEN 'Wtorek'
        WHEN 3 THEN 'Środa'
        WHEN 4 THEN 'Czwartek'
        WHEN 5 THEN 'Piątek'
        WHEN 6 THEN 'Sobota'
        WHEN 7 THEN 'Niedziela'
    END AS "Dzień tygodnia", 
	SUM(LineTotal) AS "Suma", 
	COUNT(DISTINCT ProductID) AS "Liczba różnych produktów"
FROM Sales.SalesOrderHeader
JOIN Sales.SalesOrderDetail ON SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesOrderID
GROUP BY YEAR(OrderDate), DATENAME(month, OrderDate), MONTH(OrderDate), DATEPART(dw, OrderDate)
ORDER BY YEAR(OrderDate), MONTH(OrderDate), DATEPART(dw, OrderDate)