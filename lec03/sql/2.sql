-- Zaproponuj podzia� klient�w na 3 roz��czne grupy wiekowe. Ilu r�nych klient�w dokona�o zakup�w
-- w kolejnych miesi�cach roku w ka�dej z grup? Ilu klient�w w poszczeg�lnych grupach wykona�o
-- zakup dok�adnie jeden raz?

WITH CustomersWithBirthDate AS (
	SELECT 
		C.CustomerID,
		P.Demographics.value(
			'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey";
			 (//BirthDate)[1]', 
			'DATE'
		) AS BirthDate
	FROM Sales.Customer AS C
	JOIN Person.Person AS P ON P.BusinessEntityID = C.PersonID
	WHERE
		P.Demographics.exist(
			'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey";
			 (//BirthDate)[1]'
		) = 1
),
CustomersWithAgeGroup AS (
	SELECT 
		CustomerID,
		CASE 
			WHEN YEAR(GETDATE()) - YEAR(BirthDate) < 30 THEN 'Below 30'
			WHEN YEAR(GETDATE()) - YEAR(BirthDate) BETWEEN 30 AND 50 THEN '30-50'
			ELSE 'Above 50'
		END AS AgeGroup
	FROM CustomersWithBirthDate
),
CustomerOrders AS (
	SELECT 
		CWA.CustomerID,
		CWA.AgeGroup,
		SOH.SalesOrderID,
		MONTH(SOH.OrderDate) AS OrderMonth
	FROM CustomersWithAgeGroup AS CWA
	JOIN Sales.SalesOrderHeader AS SOH ON SOH.CustomerID = CWA.CustomerID
),
CustomerOrderCount AS (
	SELECT 
		CustomerID,
		AgeGroup,
		COUNT(*) AS TotalOrders
	FROM CustomerOrders
	GROUP BY CustomerID, AgeGroup
)

-- FINAL SELECT: ��czymy wszystkie wyniki jako jeden zestaw
SELECT 'UniqueCustomersPerMonth' AS ResultType, 
	AgeGroup, 
	OrderMonth,
	COUNT(DISTINCT CustomerID) AS Value
FROM CustomerOrders
GROUP BY AgeGroup, OrderMonth

UNION ALL

SELECT 'CustomersWithOneOrder', 
	AgeGroup, 
	NULL,
	COUNT(*)
FROM CustomerOrderCount
WHERE TotalOrders = 1
GROUP BY AgeGroup

UNION ALL

SELECT 'TotalCustomers', 
	AgeGroup, 
	NULL,
	COUNT(DISTINCT CustomerID)
FROM CustomersWithAgeGroup
GROUP BY AgeGroup;
