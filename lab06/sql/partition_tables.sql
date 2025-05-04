CREATE TABLE Kubs.FACT_SALES_2011 (
	ProductID INT FOREIGN KEY REFERENCES Kubs.DIM_PRODUCT(ProductID),
    CustomerID INT FOREIGN KEY REFERENCES Kubs.DIM_CUSTOMER(CustomerID),
    SalesPersonID INT FOREIGN KEY REFERENCES Kubs.DIM_SALESPERSON(SalesPersonID),
    OrderDate INT NOT NULL,
    ShipDate INT NULL,
    OrderQty SMALLINT NOT NULL,
    UnitPrice MONEY NOT NULL,
    UnitPriceDiscount DECIMAL(8, 4) NOT NULL,
    LineTotal DECIMAL(19, 4) NOT NULL
);

CREATE TABLE Kubs.FACT_SALES_2012 (
	ProductID INT FOREIGN KEY REFERENCES Kubs.DIM_PRODUCT(ProductID),
    CustomerID INT FOREIGN KEY REFERENCES Kubs.DIM_CUSTOMER(CustomerID),
    SalesPersonID INT FOREIGN KEY REFERENCES Kubs.DIM_SALESPERSON(SalesPersonID),
    OrderDate INT NOT NULL,
    ShipDate INT NULL,
    OrderQty SMALLINT NOT NULL,
    UnitPrice MONEY NOT NULL,
    UnitPriceDiscount DECIMAL(8, 4) NOT NULL,
    LineTotal DECIMAL(19, 4) NOT NULL
);

CREATE TABLE Kubs.FACT_SALES_2013 (
	ProductID INT FOREIGN KEY REFERENCES Kubs.DIM_PRODUCT(ProductID),
    CustomerID INT FOREIGN KEY REFERENCES Kubs.DIM_CUSTOMER(CustomerID),
    SalesPersonID INT FOREIGN KEY REFERENCES Kubs.DIM_SALESPERSON(SalesPersonID),
    OrderDate INT NOT NULL,
    ShipDate INT NULL,
    OrderQty SMALLINT NOT NULL,
    UnitPrice MONEY NOT NULL,
    UnitPriceDiscount DECIMAL(8, 4) NOT NULL,
    LineTotal DECIMAL(19, 4) NOT NULL
);

CREATE TABLE Kubs.FACT_SALES_2014 (
	ProductID INT FOREIGN KEY REFERENCES Kubs.DIM_PRODUCT(ProductID),
    CustomerID INT FOREIGN KEY REFERENCES Kubs.DIM_CUSTOMER(CustomerID),
    SalesPersonID INT FOREIGN KEY REFERENCES Kubs.DIM_SALESPERSON(SalesPersonID),
    OrderDate INT NOT NULL,
    ShipDate INT NULL,
    OrderQty SMALLINT NOT NULL,
    UnitPrice MONEY NOT NULL,
    UnitPriceDiscount DECIMAL(8, 4) NOT NULL,
    LineTotal DECIMAL(19, 4) NOT NULL
);

with Sales1 AS (
	SELECT 
		Kubs.FACT_SALES.ProductID,
		Kubs.FACT_SALES.CustomerID,
		Kubs.FACT_SALES.SalesPersonID,
		Kubs.FACT_SALES.OrderDate,
		Kubs.FACT_SALES.ShipDate,
		Kubs.FACT_SALES.OrderQty,
		Kubs.FACT_SALES.UnitPrice,
		Kubs.FACT_SALES.UnitPriceDiscount,
		Kubs.FACT_SALES.LineTotal
	FROM Kubs.FACT_SALES
	WHERE OrderDate >= 20110101 AND OrderDate < 20120000
)
INSERT INTO Kubs.FACT_SALES_2011

SELECT * FROM Sales1;

with Sales2 AS (
	SELECT 
		Kubs.FACT_SALES.ProductID,
		Kubs.FACT_SALES.CustomerID,
		Kubs.FACT_SALES.SalesPersonID,
		Kubs.FACT_SALES.OrderDate,
		Kubs.FACT_SALES.ShipDate,
		Kubs.FACT_SALES.OrderQty,
		Kubs.FACT_SALES.UnitPrice,
		Kubs.FACT_SALES.UnitPriceDiscount,
		Kubs.FACT_SALES.LineTotal
	FROM Kubs.FACT_SALES
	WHERE OrderDate >= 20120101 AND OrderDate < 20130000
)
INSERT INTO Kubs.FACT_SALES_2012

SELECT * FROM Sales2;

with Sales3 AS (
	SELECT 
		Kubs.FACT_SALES.ProductID,
		Kubs.FACT_SALES.CustomerID,
		Kubs.FACT_SALES.SalesPersonID,
		Kubs.FACT_SALES.OrderDate,
		Kubs.FACT_SALES.ShipDate,
		Kubs.FACT_SALES.OrderQty,
		Kubs.FACT_SALES.UnitPrice,
		Kubs.FACT_SALES.UnitPriceDiscount,
		Kubs.FACT_SALES.LineTotal
	FROM Kubs.FACT_SALES
	WHERE OrderDate >= 20130101 AND OrderDate < 20140000
)
INSERT INTO Kubs.FACT_SALES_2013

SELECT * FROM Sales3;

with Sales4 AS (
	SELECT 
		Kubs.FACT_SALES.ProductID,
		Kubs.FACT_SALES.CustomerID,
		Kubs.FACT_SALES.SalesPersonID,
		Kubs.FACT_SALES.OrderDate,
		Kubs.FACT_SALES.ShipDate,
		Kubs.FACT_SALES.OrderQty,
		Kubs.FACT_SALES.UnitPrice,
		Kubs.FACT_SALES.UnitPriceDiscount,
		Kubs.FACT_SALES.LineTotal
	FROM Kubs.FACT_SALES
	WHERE OrderDate >= 20140101
)
INSERT INTO Kubs.FACT_SALES_2014

SELECT * FROM Sales4;