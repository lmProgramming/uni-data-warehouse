SELECT 
    Sales.ProductName AS "Nazwa produktu",
    Sales.CategoryName AS "Nazwa kategorii",
    Sales.SalesYear AS "Rok",
    Sales.SalesMonth AS "Miesi�c",
    Sales.MonthlyQty AS "Liczba zakupionych produkt�w"
FROM (
    SELECT 
        Product.ProductID,
        Product.Name AS ProductName,
        ProductCategory.Name AS CategoryName,
        YEAR(SalesOrderHeader.OrderDate) AS SalesYear,
        MONTH(SalesOrderHeader.OrderDate) AS SalesMonth,
        SUM(SalesDetail.OrderQty) AS MonthlyQty
    FROM Sales.SalesOrderDetail AS SalesDetail
    JOIN Production.Product AS Product 
        ON SalesDetail.ProductID = Product.ProductID
    JOIN Sales.SalesOrderHeader AS SalesOrderHeader
        ON SalesDetail.SalesOrderID = SalesOrderHeader.SalesOrderID
    LEFT JOIN Production.ProductSubcategory AS ProductSubcategory
        ON Product.ProductSubcategoryID = ProductSubcategory.ProductSubcategoryID
    LEFT JOIN Production.ProductCategory AS ProductCategory
        ON ProductSubcategory.ProductCategoryID = ProductCategory.ProductCategoryID
    GROUP BY 
        Product.ProductID, 
        Product.Name,
        ProductCategory.Name,
        YEAR(SalesOrderHeader.OrderDate), 
        MONTH(SalesOrderHeader.OrderDate)
) AS Sales
INNER JOIN (
    SELECT ProductID
    FROM (
        SELECT 
            Product.ProductID,
            SUM(SalesDetail.OrderQty) AS MonthlyQty
        FROM Sales.SalesOrderDetail AS SalesDetail
        JOIN Production.Product AS Product 
            ON SalesDetail.ProductID = Product.ProductID
        JOIN Sales.SalesOrderHeader AS SalesOrderHeader
            ON SalesDetail.SalesOrderID = SalesOrderHeader.SalesOrderID
        GROUP BY 
            Product.ProductID,
            YEAR(SalesOrderHeader.OrderDate), 
            MONTH(SalesOrderHeader.OrderDate)
    ) AS Monthly
    GROUP BY ProductID
    HAVING MIN(MonthlyQty) >= 20
) AS FilteredProducts
    ON Sales.ProductID = FilteredProducts.ProductID
ORDER BY Sales.ProductName, Sales.SalesYear, Sales.SalesMonth;
