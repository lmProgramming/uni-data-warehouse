CREATE TABLE Dim_Driver (
    DriverKey INT PRIMARY KEY,
    DriverID_NK INT UNIQUE,
    DriverRef VARCHAR(255) UNIQUE,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    FullName VARCHAR(510),
    DateOfBirth DATE,
    Nationality VARCHAR(255),
    Continent VARCHAR(255)
);

CREATE TABLE Dim_Constructor (
    ConstructorKey INT PRIMARY KEY,
    ConstructorID_NK INT UNIQUE,
    ConstructorRef VARCHAR(255) UNIQUE,
    Name VARCHAR(255),
    Nationality VARCHAR(255),
    Continent VARCHAR(255)
);

CREATE TABLE Dim_Race (
    RaceKey INT PRIMARY KEY,
    RaceID_NK INT UNIQUE,
    YearSeason INT,
    RoundNumberInSeason INT,
    RaceNameOfficial VARCHAR(255)
);

CREATE TABLE Dim_Circuit (
    CircuitKey INT PRIMARY KEY,
    CircuitID_NK INT UNIQUE,
    CircuitRef VARCHAR(255) UNIQUE,
    CircuitName VARCHAR(255),
    LocationCity VARCHAR(255),
    CountryName VARCHAR(255),
    Latitude DECIMAL(9, 6),
    Longitude DECIMAL(9, 6),
    Altitude INT
);

CREATE TABLE Dim_Time (
    DateKey INT PRIMARY KEY,
    FullDate DATE UNIQUE,
    Year INT,
    Quarter INT,
    Month INT,
    MonthName VARCHAR(50),
    DayOfMonth INT,
    DayOfWeekName VARCHAR(50),
    WeekOfYear INT
);

CREATE TABLE Dim_Weather (
    WeatherKey INT PRIMARY KEY,
    AvgAirTempCelsius DECIMAL(5, 2),
    MinAirTempCelsius DECIMAL(5, 2),
    MaxAirTempCelsius DECIMAL(5, 2),
    AvgTrackTempCelsius DECIMAL(5, 2),
    AvgHumidityPercent DECIMAL(5, 2),
    DidRainOccur BIT,
    -- 0 lub 1
    TotalRainfallMM DECIMAL(6, 2),
    AvgWindSpeedKmph DECIMAL(5, 2),
    MaxWindSpeedKmph DECIMAL(5, 2),
    DominantWindDirection VARCHAR(50),
    -- Np. N, NW, S (kategoria)
);

CREATE TABLE Dim_Status (
    StatusKey INT PRIMARY KEY,
    StatusID_NK INT UNIQUE,
    StatusDescription VARCHAR(255),
    StatusCategory VARCHAR(100) -- Np. Finished, Accident, Failure
);

CREATE TABLE Fact_Result (
    RaceKey INT,
    DriverKey INT,
    ConstructorKey INT,
    CircuitKey INT,
    DateKey INT,
    WeatherKey INT NULL,
    StatusKey INT,
    -- Miary
    PointsScored DECIMAL(5, 1),
    LapsCompleted INT,
    NumberOfPitStops INT NULL,
    RaceTimeMilliseconds BIGINT NULL,
    GridPosition INT,
    FinalPositionOrder INT,
    PositionOrderChange INT,
    -- (GridPosition - FinalPositionOrder)
    FastestLapTimeMilliseconds BIGINT NULL,
    RankFastestLap INT NULL,
    FastestLapTopSpeed DECIMAL(6, 2) NULL,
    AgeAtRace DECIMAL(5, 3) NULL,
    FOREIGN KEY (RaceKey) REFERENCES Dim_Race(RaceKey),
    FOREIGN KEY (DriverKey) REFERENCES Dim_Driver(DriverKey),
    FOREIGN KEY (ConstructorKey) REFERENCES Dim_Constructor(ConstructorKey),
    FOREIGN KEY (CircuitKey) REFERENCES Dim_Circuit(CircuitKey),
    FOREIGN KEY (DateKey) REFERENCES Dim_Time(DateKey),
    FOREIGN KEY (WeatherKey) REFERENCES Dim_Weather_Aggregated(WeatherKey),
    FOREIGN KEY (StatusKey) REFERENCES Dim_Status(StatusKey)
);

CREATE INDEX idx_fact_race ON Fact_Result(RaceKey);

CREATE INDEX idx_fact_driver ON Fact_Result(DriverKey);

CREATE INDEX idx_fact_constructor ON Fact_Result(ConstructorKey);

CREATE INDEX idx_fact_date ON Fact_Result(DateKey);