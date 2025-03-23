SELECT
    CustomerAgeGroup AS "Grupa wiekowa",
    COUNT(*) AS "Liczba klientów z jednym zamówieniem"
FROM (
    SELECT 
        CustomerID,
        CustomerAgeGroup
    FROM (
        SELECT 
            SalesCustomer.CustomerID,
            NTILE(3) OVER (ORDER BY YEAR(GETDATE()) - YEAR(
                PersonTable.Demographics.value(
                    'declare default element namespace 
"http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey";
                    (//BirthDate)[1]', 
                    'DATE'
                )
            )) AS CustomerAgeGroup,
            SalesOrderHeader.SalesOrderID
        FROM Sales.Customer AS SalesCustomer
        INNER JOIN Person.Person AS PersonTable 
            ON SalesCustomer.PersonID = PersonTable.BusinessEntityID
        INNER JOIN Sales.SalesOrderHeader AS SalesOrderHeader 
            ON SalesCustomer.CustomerID = SalesOrderHeader.CustomerID
        WHERE PersonTable.Demographics.exist(
            'declare default element namespace 
"http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey";
            (//BirthDate)[1]'
        ) = 1
    ) AS OrdersPerCustomer
    GROUP BY CustomerID, CustomerAgeGroup
    HAVING COUNT(SalesOrderID) = 1
) AS SingleOrderCustomers
GROUP BY CustomerAgeGroup
ORDER BY CustomerAgeGroup;
