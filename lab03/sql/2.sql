SELECT 
    ProductCategory.Name AS Category, 
    ISNULL(Product.Name, '1. total') AS Product, 
    ISNULL(CAST(YEAR(OrderDate) AS VARCHAR), 'total') AS Year, 
    SUM(UnitPrice * OrderQty - LineTotal) AS TotalDiscount 
FROM Sales.SalesOrderDetail
JOIN Sales.SalesOrderHeader ON SalesOrderHeader.SalesOrderID = SalesOrderDetail.SalesOrderID
JOIN Production.Product ON SalesOrderDetail.ProductID = Product.ProductID
LEFT JOIN Production.ProductSubcategory ON Product.ProductSubcategoryID = ProductSubcategory.ProductSubcategoryID
LEFT JOIN Production.ProductCategory ON ProductSubcategory.ProductCategoryID = ProductCategory.ProductCategoryID
GROUP BY 
    CUBE(Product.Name, YEAR(OrderDate)),
	ProductCategory.Name
ORDER BY 
    Category, Product, Year