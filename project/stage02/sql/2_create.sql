CREATE TABLE Dim_Driver (
    DriverKey INT IDENTITY(1, 1) PRIMARY KEY,
    DriverID_NK INT UNIQUE,
    DriverRef NVARCHAR(255) UNIQUE,
    FirstName NVARCHAR(255),
    LastName NVARCHAR(255),
    FullName NVARCHAR(510),
    DateOfBirth DATE,
    Nationality NVARCHAR(255),
    Continent NVARCHAR(255)
);

CREATE TABLE Dim_Constructor (
    ConstructorKey INT IDENTITY(1, 1) PRIMARY KEY,
    ConstructorID_NK INT UNIQUE,
    ConstructorRef NVARCHAR(255) UNIQUE,
    Name NVARCHAR(255),
    Nationality NVARCHAR(255),
    Continent NVARCHAR(255)
);

CREATE TABLE Dim_Race (
    RaceKey INT IDENTITY(1, 1) PRIMARY KEY,
    RaceID_NK INT UNIQUE,
    YearSeason INT,
    RoundNumberInSeason INT,
    RaceNameOfficial NVARCHAR(255)
);

CREATE TABLE Dim_Circuit (
    CircuitKey INT IDENTITY(1, 1) PRIMARY KEY,
    CircuitID_NK INT UNIQUE,
    CircuitRef NVARCHAR(255) UNIQUE,
    CircuitName NVARCHAR(255),
    LocationCity NVARCHAR(255),
    CountryName NVARCHAR(255)
);

CREATE TABLE Dim_Time (
    DateKey INT IDENTITY(1, 1) PRIMARY KEY,
    FullDate DATE UNIQUE,
    Year INT,
    Quarter INT,
    Month INT,
    MonthName NVARCHAR(50),
    DayOfMonth INT,
    DayOfWeekName NVARCHAR(50),
    WeekOfYear INT
);

CREATE TABLE Dim_Weather (
    WeatherKey INT IDENTITY(1, 1) PRIMARY KEY,
    DidRainOccur BIT,
    DominantWindDirection NVARCHAR(50) NULL,
    WindSpeedCategory NVARCHAR(50) NULL,
    AirTempCategory NVARCHAR(50) NULL,
    TrackTempCategory NVARCHAR(50) NULL,
    HumidityCategory NVARCHAR(50) NULL,
    PressureCategory NVARCHAR(50) NULL,
    RainfallCategory NVARCHAR(50) NULL
);

CREATE TABLE Dim_Status (
    StatusKey INT IDENTITY(1, 1) PRIMARY KEY,
    StatusID_NK INT UNIQUE,
    StatusDescription NVARCHAR(255),
    StatusCategory NVARCHAR(100)
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
    GridPosition INT,
    FinalPositionOrder INT,
    PositionOrderChange INT,
    FastestLapTimeMilliseconds BIGINT NULL,
    RankFastestLap INT NULL,
    FastestLapTopSpeed DECIMAL(6, 2) NULL,
    AgeAtRace DECIMAL(5, 3) NULL,
    FOREIGN KEY (RaceKey) REFERENCES Dim_Race(RaceKey),
    FOREIGN KEY (DriverKey) REFERENCES Dim_Driver(DriverKey),
    FOREIGN KEY (ConstructorKey) REFERENCES Dim_Constructor(ConstructorKey),
    FOREIGN KEY (CircuitKey) REFERENCES Dim_Circuit(CircuitKey),
    FOREIGN KEY (DateKey) REFERENCES Dim_Time(DateKey),
    FOREIGN KEY (WeatherKey) REFERENCES Dim_Weather(WeatherKey),
    FOREIGN KEY (StatusKey) REFERENCES Dim_Status(StatusKey)
);

CREATE INDEX idx_fact_race ON Fact_Result(RaceKey);

CREATE INDEX idx_fact_driver ON Fact_Result(DriverKey);

CREATE INDEX idx_fact_constructor ON Fact_Result(ConstructorKey);

CREATE INDEX idx_fact_date ON Fact_Result(DateKey);