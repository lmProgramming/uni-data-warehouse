CREATE TABLE Kubs.DIM_CUSTOMER (
    CustomerID INT NOT NULL,
    FirstName NVARCHAR(50) NULL,
    LastName NVARCHAR(50) NULL,
    Title NVARCHAR(8) NULL,
    City NVARCHAR(30) NULL,
    TerritoryName NVARCHAR(50) NULL,
    CountryRegionCode NVARCHAR(3) NULL,
    [Group] NVARCHAR(50) NULL
);

CREATE TABLE Kubs.DIM_PRODUCT (
    ProductID INT NOT NULL,
    Name NVARCHAR(50) NOT NULL,
    ListPrice MONEY NULL,
    Color NVARCHAR(15) NULL,
    SubCategoryName NVARCHAR(50) NULL,
    CategoryName NVARCHAR(50) NULL,
    Weight DECIMAL(8, 2) NULL,
    Size NVARCHAR(5) NULL,
);

CREATE TABLE Kubs.DIM_SALESPERSON (
    SalesPersonID INT NOT NULL,
    FirstName NVARCHAR(50) NULL,
    LastName NVARCHAR(50) NULL,
    Title NVARCHAR(8) NULL,
    Gender NCHAR(1) NULL,
    CountryRegionCode NVARCHAR(3) NULL,
    [Group] NVARCHAR(50) NULL
);

CREATE TABLE Kubs.FACT_SALES (
    ProductID INT NOT NULL,
    CustomerID INT NOT NULL,
    SalesPersonID INT NULL,
    OrderDate INT NOT NULL,
    ShipDate INT NULL,
    OrderQty SMALLINT NOT NULL,
    UnitPrice MONEY NOT NULL,
    UnitPriceDiscount DECIMAL(8, 4) NOT NULL DEFAULT 0,
    LineTotal DECIMAL(19, 4) NOT NULL
);

ALTER TABLE
    Kubs.DIM_CUSTOMER
ADD
    CONSTRAINT PK_DIM_CUSTOMER PRIMARY KEY (CustomerID);

ALTER TABLE
    Kubs.DIM_PRODUCT
ADD
    CONSTRAINT PK_DIM_PRODUCT PRIMARY KEY (ProductID);

ALTER TABLE
    Kubs.DIM_SALESPERSON
ADD
    CONSTRAINT PK_DIM_SALESPERSON PRIMARY KEY (SalesPersonID);

ALTER TABLE
    Kubs.FACT_SALES
ADD
    CONSTRAINT FK_FACT_SALES_DIM_CUSTOMER FOREIGN KEY (CustomerID) REFERENCES Kubs.DIM_CUSTOMER(CustomerID);

ALTER TABLE
    Kubs.FACT_SALES
ADD
    CONSTRAINT FK_FACT_SALES_DIM_PRODUCT FOREIGN KEY (ProductID) REFERENCES Kubs.DIM_PRODUCT(ProductID);

ALTER TABLE
    Kubs.FACT_SALES
ADD
    CONSTRAINT FK_FACT_SALES_DIM_SALESPERSON FOREIGN KEY (SalesPersonID) REFERENCES Kubs.DIM_SALESPERSON(SalesPersonID);

INSERT INTO
    Kubs.DIM_CUSTOMER (
        CustomerID,
        FirstName,
        LastName,
        Title,
        City,
        TerritoryName,
        CountryRegionCode,
        [Group]
    )
SELECT
    c.CustomerID,
    MIN(p.FirstName) AS FirstName,
    MIN(p.LastName) AS LastName,
    MIN(p.Title) AS Title,
    MIN(a.City) AS City,
    MIN(st.Name) AS TerritoryName,
    ISNULL(MIN(st.CountryRegionCode), '000') AS CountryRegionCode,
    ISNULL(MIN(st.[Group]), 'Unknown') AS [Group]
FROM
    Sales.Customer AS c
    LEFT JOIN Person.Person AS p ON c.PersonID = p.BusinessEntityID
    LEFT JOIN Sales.SalesTerritory AS st ON c.TerritoryID = st.TerritoryID
    LEFT JOIN Person.BusinessEntityAddress bea ON p.BusinessEntityID = bea.BusinessEntityID
    LEFT JOIN Person.Address AS a ON bea.AddressID = a.AddressID
WHERE
    c.PersonID IS NOT NULL
GROUP BY
    c.CustomerID;

INSERT INTO
    Kubs.DIM_PRODUCT (
        ProductID,
        Name,
        ListPrice,
        Color,
        SubCategoryName,
        CategoryName,
        Weight,
        Size
    )
SELECT
    DISTINCT p.ProductID,
    p.Name,
    p.ListPrice,
    ISNULL(p.Color, 'Unknown') AS Color,
    ISNULL(psc.Name, 'Unknown') AS SubCategoryName,
    pc.Name AS CategoryName,
    p.Weight,
    p.Size
FROM
    Production.Product AS p
    INNER JOIN Sales.SalesOrderDetail AS sod ON p.ProductID = sod.ProductID
    LEFT JOIN Production.ProductSubcategory AS psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
    LEFT JOIN Production.ProductCategory AS pc ON psc.ProductCategoryID = pc.ProductCategoryID;

INSERT INTO
    Kubs.DIM_SALESPERSON (
        SalesPersonID,
        FirstName,
        LastName,
        Title,
        Gender,
        CountryRegionCode,
        [Group]
    )
SELECT
    sp.BusinessEntityID AS SalesPersonID,
    p.FirstName,
    p.LastName,
    p.Title,
    e.Gender,
    ISNULL(st.CountryRegionCode, '000') AS CountryRegionCode,
    ISNULL(st.[Group], 'Unknown') AS [Group]
FROM
    Sales.SalesPerson AS sp
    INNER JOIN Person.Person AS p ON sp.BusinessEntityID = p.BusinessEntityID
    INNER JOIN HumanResources.Employee AS e ON sp.BusinessEntityID = e.BusinessEntityID
    LEFT JOIN Sales.SalesTerritory AS st ON sp.TerritoryID = st.TerritoryID;

INSERT INTO
    Kubs.FACT_SALES (
        ProductID,
        CustomerID,
        SalesPersonID,
        OrderDate,
        ShipDate,
        OrderQty,
        UnitPrice,
        UnitPriceDiscount,
        LineTotal
    )
SELECT
    sod.ProductID,
    soh.CustomerID,
    soh.SalesPersonID,
    DATEPART(YEAR, soh.OrderDate) * 10000 + DATEPART(MONTH, soh.OrderDate) * 100 + DATEPART(DAY, soh.OrderDate) AS OrderDate,
    DATEPART(YEAR, soh.ShipDate) * 10000 + DATEPART(MONTH, soh.ShipDate) * 100 + DATEPART(DAY, soh.ShipDate) AS ShipDate,
    sod.OrderQty,
    sod.UnitPrice,
    sod.UnitPriceDiscount,
    sod.LineTotal
FROM
    Sales.SalesOrderDetail AS sod
    INNER JOIN Sales.SalesOrderHeader AS soh ON sod.SalesOrderID = soh.SalesOrderID;