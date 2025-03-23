WITH OrdersWithCustomerDetails AS (
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
        SalesOrderHeader.SalesOrderID,
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
        (//BirthDate)[1]') = 1
),
CustomersWithSingleOrder AS (
    SELECT
        CustomerID,
        AgeGroup
    FROM OrdersWithCustomerDetails
    GROUP BY CustomerID, AgeGroup
    HAVING COUNT(SalesOrderID) = 1
)
SELECT
    AgeGroup AS "Grupa wiekowa",
    COUNT(CustomerID) AS "Liczba klientów z pojedynczym zamówieniem"
FROM CustomersWithSingleOrder
GROUP BY AgeGroup
ORDER BY AgeGroup;

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
