ALTER TABLE
    Fact_Result
ADD
    FOREIGN KEY (RaceKey) REFERENCES Dim_Race(RaceKey),
    FOREIGN KEY (DriverKey) REFERENCES Dim_Driver(DriverKey),
    FOREIGN KEY (ConstructorKey) REFERENCES Dim_Constructor(ConstructorKey),
    FOREIGN KEY (CircuitKey) REFERENCES Dim_Circuit(CircuitKey),
    FOREIGN KEY (DateKey) REFERENCES Dim_Time(DateKey),
    FOREIGN KEY (WeatherKey) REFERENCES Dim_Weather(WeatherKey),
    FOREIGN KEY (StatusKey) REFERENCES Dim_Status(StatusKey);