PRINT 'Test 1: Pr�ba naruszenia PK w DIM_CUSTOMER';
BEGIN TRY
    INSERT INTO Kubs.DIM_CUSTOMER (CustomerID, FirstName, LastName)
    VALUES (11000, 'Test', 'DuplicatePK');

    PRINT 'B��D - duplikat PK';
END TRY
BEGIN CATCH
    PRINT 'SUKCES';
    PRINT ERROR_MESSAGE();
END CATCH
GO

PRINT 'Test 2: Pr�ba naruszenia FK (nieistniej�cy ProductID) w FACT_SALES';
BEGIN TRY
    INSERT INTO Kubs.FACT_SALES (
        ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate,
        OrderQty, UnitPrice, UnitPriceDiscount, LineTotal
    ) VALUES (
        -999,
        11000,
        NULL,
        20250101, 20250102, 1, 10.0, 0, 10.0
    );

    PRINT 'B��D: Nieistniej�ce ProductID';
END TRY
BEGIN CATCH
    PRINT 'SUKCES';
    PRINT ERROR_MESSAGE();
END CATCH
GO

PRINT 'Test 3: Pr�ba naruszenia FK (nieistniej�cy CustomerID) w FACT_SALES';
BEGIN TRY
    INSERT INTO Kubs.FACT_SALES (
        ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate,
        OrderQty, UnitPrice, UnitPriceDiscount, LineTotal
    ) VALUES (
        776,
        -999,
        NULL,
        20240103, 20240104, 2, 20.0, 0, 40.0
    );

    PRINT 'B��D: nieistniej�cy CustomerID';
END TRY
BEGIN CATCH
    PRINT 'SUKCES';
    PRINT ERROR_MESSAGE();
END CATCH
GO

PRINT 'Koniec test�w'