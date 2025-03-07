-- Ile jest produktów w bazie? Ile kategorii i podkategorii?
SELECT COUNT(*) AS "Liczba produktów"
FROM Production.Product;

SELECT COUNT(*) AS "Liczba kategorii"
FROM Production.ProductCategory;

SELECT COUNT(*) AS "Liczba podkategorii"
FROM Production.ProductSubcategory;

-- Wypisz produkty, które nie mają zdefiniowanego koloru
SELECT *
FROM Production.Product
WHERE Color IS NULL 

-- Podaj roczną kwotę transakcji (SalesOrderHeader.TotalDue) w poszczególnych latach.
SELECT SUM(TotalDue) AS "Roczna kwota transakcji", YEAR(OrderDate) AS "Rok" 
FROM Sales.SalesOrderHeader 
GROUP BY YEAR(OrderDate) 
ORDER BY YEAR(OrderDate)

-- Ilu jest klientów, a ilu sprzedawców w sklepie? Ilu w poszczególnych regionach?
SELECT COUNT(*) AS "Liczba klientów"
FROM Sales.Customer;

SELECT COUNT(*) AS "Liczba sprzedawców"
FROM Sales.SalesPerson;

SELECT COUNT(*) AS "Liczba klientów", SalesTerritory.Name AS "Terytorium"
FROM Sales.Customer
JOIN Sales.SalesTerritory ON Customer.TerritoryID = SalesTerritory.TerritoryID
GROUP BY SalesTerritory.Name
ORDER BY SalesTerritory.Name;

SELECT COUNT(*) AS "Liczba sprzedawców", SalesTerritory.Name AS "Terytorium"
FROM Sales.SalesPerson
JOIN Sales.SalesTerritory ON SalesPerson.TerritoryID = SalesTerritory.TerritoryID
GROUP BY SalesTerritory.Name
ORDER BY SalesTerritory.Name;

-- Ile było wykonanych transakcji w poszczególnych latach?
SELECT COUNT(*) AS "Roczna liczba transakcji", YEAR(OrderDate) AS "Rok" 
FROM Sales.SalesOrderHeader 
GROUP BY YEAR(OrderDate) 
ORDER BY YEAR(OrderDate)

-- Podaj produkty, które nie zostały kupione przez żadnego klienta. Zestawienie pogrupuj według kategorii i podkategorii
SELECT ProductCategory.Name AS 'Kategoria', ProductSubcategory.Name AS 'Podkategoria', Product.Name AS "Nazwa produktu", ProductNumber AS "Numer produktu"
FROM Production.Product
LEFT JOIN Production.ProductSubcategory ON ProductSubcategory.ProductSubcategoryID = Product.ProductSubcategoryID
LEFT JOIN Production.ProductCategory ON ProductCategory.ProductCategoryID = ProductSubcategory.ProductCategoryID
LEFT JOIN Sales.SalesOrderDetail ON SalesOrderDetail.ProductID = Product.ProductID
WHERE SalesOrderDetail.SalesOrderDetailID IS NULL
GROUP BY ProductCategory.Name, ProductSubcategory.Name, Product.Name, ProductNumber
ORDER BY ProductCategory.Name DESC, ProductSubcategory.Name, Product.Name

-- Oblicz minimalną i maksymalną kwotę rabatu udzielonego na produkty w poszczególnych podkategoriach
SELECT ProductSubcategory.Name AS 'Podkategoria', MIN(SalesOrderDetail.UnitPriceDiscount) AS "Minimalny rabat", MAX(SalesOrderDetail.UnitPriceDiscount) AS "Maksymalny rabat"
FROM Production.Product
JOIN Production.ProductSubcategory ON ProductSubcategory.ProductSubcategoryID = Product.ProductSubcategoryID
JOIN Sales.SalesOrderDetail ON SalesOrderDetail.ProductID = Product.ProductID
GROUP BY ProductSubcategory.Name
ORDER BY MAX(SalesOrderDetail.UnitPriceDiscount) DESC

-- Podaj produkty, których cena jest wyższa od średniej ceny produktów w sklepie
SELECT Name, ListPrice 
FROM Production.Product 
WHERE ListPrice > (
	SELECT AVG(ListPrice) 
	FROM Production.Product
)
ORDER BY ListPrice

-- Ile średnio produktów w każdej kategorii sprzedaje się w poszczególnych miesiącach?
WITH MonthlySales AS (
    SELECT Production.ProductCategory.Name AS Category, MONTH(Sales.SalesOrderHeader.OrderDate) AS Month, SUM(Sales.SalesOrderDetail.OrderQty) AS SoldUnitsCount
    FROM Sales.SalesOrderDetail
    JOIN Sales.SalesOrderHeader ON Sales.SalesOrderDetail.SalesOrderID = Sales.SalesOrderHeader.SalesOrderID
    JOIN Production.Product ON Sales.SalesOrderDetail.ProductID = Production.Product.ProductID
    JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID
    JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID
    GROUP BY Production.ProductCategory.Name, MONTH(Sales.SalesOrderHeader.OrderDate)
)
SELECT Category AS "Kategoria", Month AS "Miesiąc", AVG(SoldUnitsCount) AS "Średnia sprzedaż"
FROM MonthlySales
GROUP BY Category, Month
ORDER BY Category, Month;


-- Ile średnio czasu klient czeka na dostawę zamówionych produktów? Przygotuj zestawienie w zależności od kodu regionu (SalesTerritory.CountryRegionCode)
SELECT AVG(CAST(DATEDIFF(day, OrderDate, ShipDate) AS FLOAT)) AS "Średni czas dostawy w dniach", SalesTerritory.CountryRegionCode AS "Kod regionu"
FROM Sales.SalesOrderHeader
JOIN Sales.SalesTerritory ON SalesTerritory.TerritoryID = SalesOrderHeader.TerritoryID
GROUP BY SalesTerritory.CountryRegionCode
ORDER BY SalesTerritory.CountryRegionCode