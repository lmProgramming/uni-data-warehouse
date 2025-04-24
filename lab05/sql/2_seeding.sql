-- Efficiently get all unique dates needed from the source
WITH SourceDates AS (
    SELECT DISTINCT OrderDate AS CalendarDate
    FROM Sales.SalesOrderHeader
    WHERE OrderDate IS NOT NULL
    UNION -- UNION handles DISTINCT automatically
    SELECT DISTINCT ShipDate AS CalendarDate
    FROM Sales.SalesOrderHeader
    WHERE ShipDate IS NOT NULL
)
INSERT INTO Kubs.DIM_TIME (
    PK_TIME,
    FullDate,
    Rok,
    Kwarta�,
    Miesi�c,
    Miesi�c_s�ownie,
    Dzie�_tyg,
    Dzie�_tyg_s�ownie,
    Dzie�_miesi�ca
)
SELECT
    (DATEPART(year, sd.CalendarDate) * 10000) + (DATEPART(month, sd.CalendarDate) * 100) + DATEPART(day, sd.CalendarDate) AS PK_TIME,
    sd.CalendarDate AS FullDate,
    DATEPART(year, sd.CalendarDate) AS Rok,
    DATEPART(quarter, sd.CalendarDate) AS Kwarta�,
    DATEPART(month, sd.CalendarDate) AS Miesi�c,
    ISNULL(hm.MonthName_PL, 'Unknown') AS Miesi�c_s�ownie, -- Join to helper table
    DATEPART(weekday, sd.CalendarDate) AS Dzie�_tygodnia,
    ISNULL(hwd.WeekdayName_PL, 'Unknown') AS Dzie�_tygodnia_s�ownie, -- Join to helper table
    DATEPART(day, sd.CalendarDate) AS Dzie�_miesi�ca
FROM SourceDates sd
LEFT JOIN Kubs.Helper_Months hm ON DATEPART(month, sd.CalendarDate) = hm.MonthNum
LEFT JOIN Kubs.Helper_Weekdays hwd ON DATEPART(weekday, sd.CalendarDate) = hwd.WeekdayNum; -- Ensure WeekdayNum matches DATEPART output

-- Add FK constraints from FACT_SALES to DIM_TIME (will be done in Reference step)
-- ALTER TABLE Kubs.FACT_SALES ADD CONSTRAINT FK_FACT_SALES_DIM_TIME_OrderDate FOREIGN KEY (OrderDate) REFERENCES Kubs.DIM_TIME(PK_TIME);
-- ALTER TABLE Kubs.FACT_SALES ADD CONSTRAINT FK_FACT_SALES_DIM_TIME_ShipDate FOREIGN KEY (ShipDate) REFERENCES Kubs.DIM_TIME(PK_TIME);