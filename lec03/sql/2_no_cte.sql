SELECT
    OrderYear AS "Rok",
    OrderMonth AS "Miesi�c",
    AgeGroup AS "Grupa wiekowa",
    COUNT(DISTINCT CustomerID) AS "Liczba unikalnych klient�w"
FROM (
    SELECT 
        Customer.CustomerID,
        NTILE(3) OVER (ORDER BY YEAR(GETDATE()) - YEAR(
            Person.Demographics.value(
                'declare default element namespace 
"http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey";
                (//BirthDate)[1]', 
                'DATE'
            )
        )) AS AgeGroup,
        YEAR(SalesOrderHeader.OrderDate) AS OrderYear,
        MONTH(SalesOrderHeader.OrderDate) AS OrderMonth
    FROM Sales.Customer AS Customer
    INNER JOIN Person.Person AS Person 
        ON Customer.PersonID = Person.BusinessEntityID
    INNER JOIN Sales.SalesOrderHeader AS SalesOrderHeader 
        ON Customer.CustomerID = SalesOrderHeader.CustomerID
    WHERE Person.Demographics.exist(
        'declare default element namespace 
"http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey";
        (//BirthDate)[1]'
    ) = 1
) AS CustomerOrderData
GROUP BY AgeGroup, OrderYear, OrderMonth
ORDER BY OrderYear, OrderMonth, AgeGroup;
