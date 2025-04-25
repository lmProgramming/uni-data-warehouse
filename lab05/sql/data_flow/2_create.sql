-- 2_dim
CREATE TABLE Kubs.DIM_TIME (
    PK_TIME INT PRIMARY KEY,
    FullDate DATE NOT NULL,
    Rok INT NOT NULL,
    Kwartal INT NOT NULL,
    Miesiac INT NOT NULL,
    Miesiac_slownie NVARCHAR(20) NOT NULL,
    Dzien_tyg INT NOT NULL,
    Dzien_tyg_slownie NVARCHAR(20) NOT NULL,
    Dzien_miesiaca INT NOT NULL
);

-- 2_helpers
CREATE TABLE Kubs.Helper_Months (
    MonthNum INT PRIMARY KEY,
    MonthName_PL NVARCHAR(20) NOT NULL
);

CREATE TABLE Kubs.Helper_Weekdays (
    WeekdayNum INT PRIMARY KEY,
    WeekdayName_PL NVARCHAR(20) NOT NULL
);

-- 3_tables
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