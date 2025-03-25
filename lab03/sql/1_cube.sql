SELECT
    CASE 
        WHEN GROUPING(Person.BusinessEntityID) = 1 THEN '1. total sum'
        ELSE CONCAT(MIN(Person.FirstName), ' ', MIN(Person.LastName))
    END AS FullName,
    YEAR(OrderDate) AS OrderYear,
    SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
JOIN Sales.Customer ON Customer.CustomerID = SalesOrderHeader.CustomerID
JOIN Person.Person ON Person.BusinessEntityID = Customer.PersonID
GROUP BY 
    CUBE(Person.BusinessEntityID, YEAR(OrderDate))
ORDER BY 
    FullName, OrderYear;
