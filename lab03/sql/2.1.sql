SELECT 
    pc.Name AS "Nazwa kategorii",
    YEAR(soh.OrderDate) AS Rok,
	SUM(sod.LineTotal) AS "Suma sprzeda¿y",
    ROUND(SUM(sod.LineTotal) / SUM(SUM(sod.LineTotal)) OVER (PARTITION BY pc.Name) * 100, 2) AS "Procent sprzeda¿y dla kategorii"
FROM 
    Sales.SalesOrderDetail sod
    JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
    JOIN Production.Product p ON sod.ProductID = p.ProductID
    JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
    JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
GROUP BY 
    YEAR(soh.OrderDate),
    CUBE(pc.Name)
ORDER BY 
    COALESCE(pc.Name, 'Total') DESC,
    YEAR(soh.OrderDate);