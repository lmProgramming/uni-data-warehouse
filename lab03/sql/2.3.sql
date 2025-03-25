SELECT 
	Customer.CustomerID AS "ID",
	Person.FirstName AS "Imiê",
	Person.LastName AS "Nazwisko",
	COUNT(*) AS "Liczba transakcji",
	RANK() OVER(ORDER BY COUNT(*) DESC) AS "Ranking"
FROM Sales.Customer
RIGHT JOIN Sales.SalesOrderHeader ON SalesOrderHeader.CustomerID = Customer.CustomerID
RIGHT JOIN Sales.SalesOrderDetail ON SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesOrderID
JOIN Person.Person ON Person.BusinessEntityID = Customer.PersonID
GROUP BY Customer.CustomerID, Person.FirstName, Person.LastName
ORDER BY COUNT(*) DESC