SELECT 
    ProductCategory.Name AS Kategoria,
    ProductSubcategory.Name AS Podkategoria,
    SUM(SalesOrderDetail.OrderQty) AS "Liczba sprzedanych produktów",
    SUM(SalesOrderDetail.LineTotal) AS "Wartość sprzedaży",
    FORMAT(
        100.0 * SUM(SalesOrderDetail.OrderQty) 
        / SUM(SUM(SalesOrderDetail.OrderQty)) OVER(PARTITION BY ProductCategory.Name), 
        '0.00'
    ) + '%' AS "Udział liczbowy",
    FORMAT(
        100.0 * SUM(SalesOrderDetail.LineTotal) 
        / SUM(SUM(SalesOrderDetail.LineTotal)) OVER(PARTITION BY ProductCategory.Name), 
        '0.00'
    ) + '%' AS "Udział wartościowy"
FROM Production.Product
INNER JOIN Production.ProductSubcategory 
    ON Product.ProductSubcategoryID = ProductSubcategory.ProductSubcategoryID
INNER JOIN Production.ProductCategory 
    ON ProductSubcategory.ProductCategoryID = ProductCategory.ProductCategoryID
INNER JOIN Sales.SalesOrderDetail 
    ON Product.ProductID = SalesOrderDetail.ProductID
GROUP BY ProductCategory.Name, ProductSubcategory.Name;
