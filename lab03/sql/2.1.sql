SELECT 
    ISNULL(ProductCategory.Name, 'Total') AS "Nazwa kategorii",
    YEAR(SalesOrderHeader.OrderDate) AS Rok,
	SUM(SalesOrderDetail.LineTotal) AS "Suma sprzeda¿y",
    CAST(ROUND(SUM(SalesOrderDetail.LineTotal) / SUM(SUM(SalesOrderDetail.LineTotal)) OVER (PARTITION BY ProductCategory.Name) * 100, 2) AS DECIMAL(10,2)) AS "Procent sprzeda¿y dla kategorii"
FROM 
    Sales.SalesOrderDetail
    JOIN Sales.SalesOrderHeader ON SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesOrderID
    JOIN Production.Product ON SalesOrderDetail.ProductID = Product.ProductID
    JOIN Production.ProductSubcategory ON Product.ProductSubcategoryID = ProductSubcategory.ProductSubcategoryID
    JOIN Production.ProductCategory ON ProductSubcategory.ProductCategoryID = ProductCategory.ProductCategoryID
GROUP BY 
    YEAR(SalesOrderHeader.OrderDate),
    CUBE(ProductCategory.Name)
ORDER BY 
    COALESCE(ProductCategory.Name, 'Total') DESC,
    YEAR(SalesOrderHeader.OrderDate);