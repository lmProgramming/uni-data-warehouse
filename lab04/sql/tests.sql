SELECT * FROM Kubs.DIM_CUSTOMER;
SELECT * FROM Kubs.DIM_PRODUCT;
SELECT * FROM Production.Product
LEFT JOIN Production.ProductSubcategory ON ProductSubcategory.ProductSubcategoryID = Product.ProductSubcategoryID
LEFT JOIN Production.ProductCategory ON ProductCategory.ProductCategoryID = ProductSubcategory.ProductCategoryID;

SELECT DISTINCT
    p.ProductID,
    p.Name,
    p.ListPrice,
    p.Color,
    psc.Name AS SubCategoryName,
    pc.Name AS CategoryName,
    p.Weight,
    p.Size,
    1 AS IsPurchased
FROM Production.Product AS p
INNER JOIN Sales.SalesOrderDetail AS sod ON p.ProductID = sod.ProductID
LEFT JOIN Production.ProductSubcategory AS psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
LEFT JOIN Production.ProductCategory AS pc ON psc.ProductCategoryID = pc.ProductCategoryID;

SELECT DISTINCT
    p.ProductID,
    p.Name,
    p.ListPrice,
    p.Color,
    psc.Name AS SubCategoryName,
    pc.Name AS CategoryName,
    p.Weight,
    p.Size,
    1 AS IsPurchased
FROM Production.Product AS p
INNER JOIN Sales.SalesOrderDetail AS sod ON p.ProductID = sod.ProductID
LEFT JOIN Production.ProductSubcategory AS psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
LEFT JOIN Production.ProductCategory AS pc ON psc.ProductCategoryID = pc.ProductCategoryID;

SELECT CustomerID, COUNT(*)
FROM Kubs.DIM_CUSTOMER
GROUP BY CustomerID
HAVING COUNT(*) > 1;

SELECT * FROM Kubs.DIM_CUSTOMER;
SELECT * FROM Kubs.DIM_PRODUCT;
SELECT * FROM Kubs.DIM_SALESPERSON;
SELECT * FROM Kubs.FACT_SALES;