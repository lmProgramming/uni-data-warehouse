SELECT
    CASE 
        WHEN GROUPING(YEAR(OrderDate)) = 1 AND GROUPING(Person.BusinessEntityID) = 1 THEN '1. total sum'
        WHEN GROUPING(YEAR(OrderDate)) = 1 THEN CONCAT(MIN(Person.FirstName), ' ', MIN(Person.LastName), ' (total)')
        ELSE MIN(CONCAT(Person.FirstName, ' ', Person.LastName))
    END AS FullName,
    YEAR(OrderDate) AS OrderYear,
    SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
JOIN Sales.Customer ON Customer.CustomerID = SalesOrderHeader.CustomerID
JOIN Person.Person ON Person.BusinessEntityID = Customer.PersonID
GROUP BY 
    ROLLUP(Person.BusinessEntityID, YEAR(OrderDate))
ORDER BY 
    FullName, OrderYear;
