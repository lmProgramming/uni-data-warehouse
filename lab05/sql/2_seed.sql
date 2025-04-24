WITH SourceDates AS (
    SELECT
        DISTINCT OrderDate AS CalendarDate
    FROM
        Sales.SalesOrderHeader
    WHERE
        OrderDate IS NOT NULL
    UNION
    SELECT
        DISTINCT ShipDate AS CalendarDate
    FROM
        Sales.SalesOrderHeader
    WHERE
        ShipDate IS NOT NULL
)
INSERT INTO
    Kubs.DIM_TIME (
        PK_TIME,
        FullDate,
        Rok,
        Kwartal,
        Miesiac,
        Miesiac_slownie,
        Dzien_tyg,
        Dzien_tyg_slownie,
        Dzien_miesiaca
    )
SELECT
    (DATEPART(year, sd.CalendarDate) * 10000) + (DATEPART(month, sd.CalendarDate) * 100) + DATEPART(day, sd.CalendarDate) AS PK_TIME,
    sd.CalendarDate AS FullDate,
    DATEPART(year, sd.CalendarDate) AS Rok,
    DATEPART(quarter, sd.CalendarDate) AS Kwartal,
    DATEPART(month, sd.CalendarDate) AS Miesiac,
    ISNULL(hm.MonthName_PL, 'Unknown') AS Miesiac_slownie,
    DATEPART(weekday, sd.CalendarDate) AS Dzien_tygodnia,
    ISNULL(hwd.WeekdayName_PL, 'Unknown') AS Dzien_tygodnia_slownie,
    DATEPART(day, sd.CalendarDate) AS Dzien_miesiaca
FROM
    SourceDates sd
    LEFT JOIN Kubs.Helper_Months hm ON DATEPART(month, sd.CalendarDate) = hm.MonthNum
    LEFT JOIN Kubs.Helper_Weekdays hwd ON DATEPART(weekday, sd.CalendarDate) = hwd.WeekdayNum;

-- Add FK constraints from FACT_SALES to DIM_TIME (will be done in Reference step)
-- ALTER TABLE Kubs.FACT_SALES ADD CONSTRAINT FK_FACT_SALES_DIM_TIME_OrderDate FOREIGN KEY (OrderDate) REFERENCES Kubs.DIM_TIME(PK_TIME);
-- ALTER TABLE Kubs.FACT_SALES ADD CONSTRAINT FK_FACT_SALES_DIM_TIME_ShipDate FOREIGN KEY (ShipDate) REFERENCES Kubs.DIM_TIME(PK_TIME);