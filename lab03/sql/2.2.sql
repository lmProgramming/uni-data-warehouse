SELECT 
    Person.FirstName + ' ' + Person.LastName AS [Imi� i nazwisko],
    YEAR(SalesOrderHeader.OrderDate) AS [Rok],
    MONTH(SalesOrderHeader.OrderDate) AS [Miesi�c],
    COUNT(*) AS [W miesi�cu],
    SUM(COUNT(*)) OVER (PARTITION BY Person.BusinessEntityID, YEAR(SalesOrderHeader.OrderDate)) AS [W roku],
    SUM(COUNT(*)) OVER (PARTITION BY Person.BusinessEntityID, YEAR(SalesOrderHeader.OrderDate) 
                        ORDER BY MONTH(SalesOrderHeader.OrderDate)) AS [W roku narastaj�co],
    COUNT(*) + LAG(COUNT(*), 1, 0) OVER (PARTITION BY Person.BusinessEntityID 
                                        ORDER BY YEAR(SalesOrderHeader.OrderDate), MONTH(SalesOrderHeader.OrderDate)) 
                                        AS [Obecny i poprzedni miesi�c]
FROM 
    Sales.SalesOrderHeader
    JOIN Sales.SalesPerson ON SalesOrderHeader.SalesPersonID = SalesPerson.BusinessEntityID
    JOIN Person.Person ON SalesPerson.BusinessEntityID = Person.BusinessEntityID
GROUP BY 
    Person.BusinessEntityID,
    Person.FirstName,
    Person.LastName,
    YEAR(SalesOrderHeader.OrderDate),
    MONTH(SalesOrderHeader.OrderDate)
ORDER BY 
    [Imi� i nazwisko],
    [Rok],
    [Miesi�c];