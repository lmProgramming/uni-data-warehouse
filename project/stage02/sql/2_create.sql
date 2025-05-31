CREATE TABLE Dim_Driver (
    DriverKey INT IDENTITY(1, 1) PRIMARY KEY,
    DriverID_NK INT UNIQUE,
    FirstName NVARCHAR(255),
    LastName NVARCHAR(255),
    FullName NVARCHAR(511),
    DateOfBirth DATE,
    CountryName NVARCHAR(255),
    Continent NVARCHAR(255)
);

CREATE TABLE Dim_Constructor (
    ConstructorKey INT IDENTITY(1, 1) PRIMARY KEY,
    ConstructorID_NK INT UNIQUE,
    Name NVARCHAR(255),
    CountryName NVARCHAR(255),
    Continent NVARCHAR(255)
);

CREATE TABLE Dim_Race (
    RaceKey INT IDENTITY(1, 1) PRIMARY KEY,
    RaceID_NK INT UNIQUE,
    CircuitID_NK INT,
    YearSeason INT,
    RoundNumberInSeason INT,
    RaceNameOfficial NVARCHAR(255),
    Date DATE,
);

CREATE TABLE Dim_Circuit (
    CircuitKey INT IDENTITY(1, 1) PRIMARY KEY,
    CircuitID_NK INT UNIQUE,
    CircuitName NVARCHAR(255),
    LocationCity NVARCHAR(255),
    CountryName NVARCHAR(255)
);

CREATE TABLE Dim_Time (
    DateKey INT PRIMARY KEY,
    FullDate DATE UNIQUE,
    Year INT,
    Quarter INT,
    Month INT,
    MonthName NVARCHAR(50),
    DayOfMonth INT,
    DayOfWeekName NVARCHAR(50),
);

CREATE TABLE Dim_Weather (
    WeatherKey INT PRIMARY KEY,
    DidRainOccur NVARCHAR(50) NULL,
    WindSpeedCategory NVARCHAR(50) NULL,
    AirTempCategory NVARCHAR(50) NULL,
    TrackTempCategory NVARCHAR(50) NULL,
    HumidityCategory NVARCHAR(50) NULL,
    PressureCategory NVARCHAR(50) NULL,
);

CREATE TABLE Dim_Status (
    StatusKey INT IDENTITY(1, 1) PRIMARY KEY,
    StatusID_NK INT UNIQUE,
    StatusDescription NVARCHAR(255),
    StatusCategory NVARCHAR(100) NULL
);

CREATE TABLE Fact_Result (
    RaceKey INT,
    DriverKey INT,
    ConstructorKey INT,
    CircuitKey INT,
    DateKey INT,
    WeatherKey INT NULL,
    StatusKey INT,
    PointsScored DECIMAL(5, 1),
    LapsCompleted INT,
    NumberOfPitStops INT NULL,
    RaceTimeMilliseconds BIGINT NULL,
    PositionOrderChange INT,
    RankFastestLap INT NULL,
    FastestLapTopSpeed DECIMAL(6, 3) NULL,
    AgeAtRace INT NULL
);

CREATE INDEX idx_fact_race ON Fact_Result(RaceKey);

CREATE INDEX idx_fact_driver ON Fact_Result(DriverKey);

CREATE INDEX idx_fact_constructor ON Fact_Result(ConstructorKey);

CREATE INDEX idx_fact_date ON Fact_Result(DateKey);

CREATE TABLE Helper_Months (
    MonthNum INT PRIMARY KEY,
    MonthName NVARCHAR(20) NOT NULL
);

CREATE TABLE Helper_Weekdays (
    WeekdayNum INT PRIMARY KEY,
    WeekdayName NVARCHAR(20) NOT NULL
);

CREATE TABLE Helper_CountryContinents (
    CountryName NVARCHAR(100) PRIMARY KEY,
    Continent NVARCHAR(50) NOT NULL
);

CREATE TABLE Helper_NationalityCountries (
    Nationality NVARCHAR(100) PRIMARY KEY,
    CountryName NVARCHAR(100) NOT NULL
);

CREATE TABLE Helper_StatusCategory (
    StatusText NVARCHAR(255) PRIMARY KEY,
    BroadCategory NVARCHAR(100) NOT NULL
);