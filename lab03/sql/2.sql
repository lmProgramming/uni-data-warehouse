SELECT 
    ProductCategory.Name AS Kategoria, 
    ISNULL(Product.Name, '1. total') AS "Nazwa produktu", 
    ISNULL(CAST(YEAR(OrderDate) AS VARCHAR), 'total') AS Rok, 
    SUM(UnitPrice * OrderQty - LineTotal) AS "Suma rabatu" 
FROM Sales.SalesOrderDetail
JOIN Sales.SalesOrderHeader ON SalesOrderHeader.SalesOrderID = SalesOrderDetail.SalesOrderID
JOIN Production.Product ON SalesOrderDetail.ProductID = Product.ProductID
LEFT JOIN Production.ProductSubcategory ON Product.ProductSubcategoryID = ProductSubcategory.ProductSubcategoryID
LEFT JOIN Production.ProductCategory ON ProductSubcategory.ProductCategoryID = ProductCategory.ProductCategoryID
GROUP BY 
    CUBE(Product.Name, YEAR(OrderDate)),
	ProductCategory.Name
ORDER BY 
    Kategoria, "Nazwa produktu", Rok