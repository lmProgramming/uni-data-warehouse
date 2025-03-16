SET STATISTICS IO ON;
SET STATISTICS TIME ON;
SET STATISTICS PROFILE ON;

-- Kwerenda bez CTE
SELECT TOP 20 
    p.Name AS "Nazwa produktu", 
    pc.Name AS "Nazwa kategorii", 
    SUM(sod.OrderQty) AS "Suma liczby sprzedanych"
FROM Sales.SalesOrderDetail sod
JOIN Production.Product p ON sod.ProductID = p.ProductID
JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
GROUP BY p.Name, pc.Name
ORDER BY "Suma liczby sprzedanych" DESC;

-- Kwerenda z CTE
WITH ProductSales AS (
    SELECT 
        p.Name AS ProductName, 
        SUM(sod.OrderQty) AS TotalQuantitySold,
		p.ProductSubcategoryID
    FROM Sales.SalesOrderDetail sod
    JOIN Production.Product p ON sod.ProductID = p.ProductID
    GROUP BY p.Name, p.ProductSubcategoryID
),
ProductCategories AS (
	SELECT
		p.ProductName,
		pc.Name AS CategoryName,
		p.TotalQuantitySold
	FROM ProductSales p		
    JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
    JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
)
SELECT TOP 20
	ProductCategories.ProductName AS "Nazwa produktu",
	ProductCategories.CategoryName AS "Nazwa kategorii", 
	ProductCategories.TotalQuantitySold AS "Suma liczby sprzedanych"
FROM ProductCategories
ORDER BY TotalQuantitySold DESC;
