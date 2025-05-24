IF EXISTS (
    SELECT
        *
    FROM
        INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE
        CONSTRAINT_NAME = 'FK_Fact_Result_Dim_Race'
)
ALTER TABLE
    Fact_Result DROP CONSTRAINT FK_Fact_Result_Dim_Race;

IF EXISTS (
    SELECT
        *
    FROM
        INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE
        CONSTRAINT_NAME = 'FK_Fact_Result_Dim_Driver'
)
ALTER TABLE
    Fact_Result DROP CONSTRAINT FK_Fact_Result_Dim_Driver;

IF EXISTS (
    SELECT
        *
    FROM
        INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE
        CONSTRAINT_NAME = 'FK_Fact_Result_Dim_Constructor'
)
ALTER TABLE
    Fact_Result DROP CONSTRAINT FK_Fact_Result_Dim_Constructor;

IF EXISTS (
    SELECT
        *
    FROM
        INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE
        CONSTRAINT_NAME = 'FK_Fact_Result_Dim_Circuit'
)
ALTER TABLE
    Fact_Result DROP CONSTRAINT FK_Fact_Result_Dim_Circuit;

IF EXISTS (
    SELECT
        *
    FROM
        INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE
        CONSTRAINT_NAME = 'FK_Fact_Result_Dim_Time'
)
ALTER TABLE
    Fact_Result DROP CONSTRAINT FK_Fact_Result_Dim_Time;

IF EXISTS (
    SELECT
        *
    FROM
        INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE
        CONSTRAINT_NAME = 'FK_Fact_Result_Dim_Weather'
)
ALTER TABLE
    Fact_Result DROP CONSTRAINT FK_Fact_Result_Dim_Weather;

IF EXISTS (
    SELECT
        *
    FROM
        INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE
        CONSTRAINT_NAME = 'FK_Fact_Result_Dim_Status'
)
ALTER TABLE
    Fact_Result DROP CONSTRAINT FK_Fact_Result_Dim_Status;

DROP TABLE IF EXISTS Fact_Result;

DROP TABLE IF EXISTS Dim_Race;

DROP TABLE IF EXISTS Dim_Driver;

DROP TABLE IF EXISTS Dim_Constructor;

DROP TABLE IF EXISTS Dim_Circuit;

DROP TABLE IF EXISTS Dim_Time;

DROP TABLE IF EXISTS Dim_Weather;

DROP TABLE IF EXISTS Dim_Status;

DROP TABLE IF EXISTS Helper_Months;

DROP TABLE IF EXISTS Helper_Weekdays;