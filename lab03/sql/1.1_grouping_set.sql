SELECT
    MIN(CONCAT(Person.FirstName, ' ', Person.LastName)) AS FullName,	
    YEAR(OrderDate) AS OrderYear,
    SUM(TotalDue) AS TotalDue
FROM Sales.SalesOrderHeader
JOIN Sales.Customer ON Customer.CustomerID = SalesOrderHeader.CustomerID
JOIN Person.Person ON Person.BusinessEntityID = Customer.PersonID
GROUP BY GROUPING SETS
    (
		(Person.BusinessEntityID),
        (YEAR(OrderDate), Person.BusinessEntityID)
    )
ORDER BY FullName, OrderYear;
