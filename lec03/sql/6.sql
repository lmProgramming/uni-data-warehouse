SELECT 
    Territory.Name AS Region,
    ISNULL(CAST(Currency.CurrencyCode AS VARCHAR(20)), 'Brak waluty') AS Waluta,
    CountryRegionCode AS "Kod regionu",
    SUM(SalesOrderHeader.TotalDue) AS "Wartość sprzedaży",
    COUNT(SalesOrderHeader.SalesOrderID) AS "Liczba zamówień"
FROM Sales.SalesTerritory AS Territory
LEFT JOIN Sales.SalesOrderHeader 
    ON Territory.TerritoryID = SalesOrderHeader.TerritoryID
LEFT JOIN Sales.CurrencyRate AS CurrencyRate
    ON SalesOrderHeader.CurrencyRateID = CurrencyRate.CurrencyRateID
LEFT JOIN Sales.Currency AS Currency
    ON CurrencyRate.ToCurrencyCode = Currency.CurrencyCode
GROUP BY Territory.Name, Currency.CurrencyCode, CountryRegionCode
ORDER BY CountryRegionCode, Territory.Name, SUM(SalesOrderHeader.TotalDue) DESC
