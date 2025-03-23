WITH CustomersGender AS (
    SELECT Customer.CustomerID, 
           Demographics.value(
               'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; (//Gender)[1]', 
               'CHAR(1)'
           ) AS Gender
    FROM Sales.Customer AS Customer
    INNER JOIN Person.Person AS Person ON Person.BusinessEntityID = Customer.PersonID
    WHERE Demographics.exist(
        'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; (//Gender)[1]'
    ) = 1
),
SalesData AS (
    SELECT 
        YEAR(SalesOrderHeader.OrderDate) AS Year, 
        MONTH(SalesOrderHeader.OrderDate) AS Month, 
        CustomersGender.Gender,
        SUM(SalesOrderHeader.TotalDue) AS TotalDue,
        COUNT(DISTINCT CustomersGender.CustomerID) AS NumberOfClients
    FROM Sales.SalesOrderHeader AS SalesOrderHeader
    INNER JOIN CustomersGender ON CustomersGender.CustomerID = SalesOrderHeader.CustomerID
    WHERE SalesOrderHeader.OrderDate BETWEEN '2011-05-01' AND '2024-06-30'
    GROUP BY YEAR(SalesOrderHeader.OrderDate), MONTH(SalesOrderHeader.OrderDate), CustomersGender.Gender
),
TotalSalesPerPeriod AS (
    SELECT Year, Month, SUM(TotalDue) AS TotalDueAll
    FROM SalesData
    GROUP BY Year, Month
)
SELECT 
    SalesData.Year AS "Rok",
    SalesData.Month AS "Miesiąc",
    SUM(CASE WHEN SalesData.Gender = 'M' THEN SalesData.TotalDue ELSE 0 END) AS "Wartość sprzedaży M",
	SUM(CASE WHEN SalesData.Gender = 'F' THEN SalesData.TotalDue ELSE 0 END) AS "Wartość sprzedaży K",
    SUM(CASE WHEN SalesData.Gender = 'M' THEN SalesData.NumberOfClients ELSE 0 END) AS "Liczba klientów",
    SUM(CASE WHEN SalesData.Gender = 'F' THEN SalesData.NumberOfClients ELSE 0 END) AS "Liczba klientek",
    ROUND(CAST(SUM(CASE WHEN SalesData.Gender = 'M' THEN SalesData.TotalDue ELSE 0 END) AS FLOAT) / TotalSalesPerPeriod.TotalDueAll, 2) AS "Udział M",
    ROUND(CAST(SUM(CASE WHEN SalesData.Gender = 'F' THEN SalesData.TotalDue ELSE 0 END) AS FLOAT) / TotalSalesPerPeriod.TotalDueAll, 2) AS "Udział K"
FROM SalesData
INNER JOIN TotalSalesPerPeriod ON SalesData.Year = TotalSalesPerPeriod.Year AND SalesData.Month = TotalSalesPerPeriod.Month
GROUP BY SalesData.Year, SalesData.Month, TotalSalesPerPeriod.TotalDueAll
ORDER BY "Rok", "Miesiąc";
