SELECT 
    p.FirstName + ' ' + p.LastName AS [Imiê i nazwisko],
    YEAR(soh.OrderDate) AS [Rok],
    MONTH(soh.OrderDate) AS [Miesi¹c],
    COUNT(*) AS [W miesi¹cu],
    SUM(COUNT(*)) OVER (PARTITION BY p.BusinessEntityID, YEAR(soh.OrderDate)) AS [W roku],
    SUM(COUNT(*)) OVER (PARTITION BY p.BusinessEntityID, YEAR(soh.OrderDate) 
                        ORDER BY MONTH(soh.OrderDate)) AS [W roku narastaj¹co],
    COUNT(*) + LAG(COUNT(*), 1, 0) OVER (PARTITION BY p.BusinessEntityID 
                                        ORDER BY YEAR(soh.OrderDate), MONTH(soh.OrderDate)) 
                                        AS [Obecny i poprzedni miesi¹c]
FROM 
    Sales.SalesOrderHeader soh
    JOIN Sales.SalesPerson sp ON soh.SalesPersonID = sp.BusinessEntityID
    JOIN Person.Person p ON sp.BusinessEntityID = p.BusinessEntityID
GROUP BY 
    p.BusinessEntityID,
    p.FirstName,
    p.LastName,
    YEAR(soh.OrderDate),
    MONTH(soh.OrderDate)
ORDER BY 
    [Imiê i nazwisko],
    [Rok],
    [Miesi¹c];