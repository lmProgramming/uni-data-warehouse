ALTER TABLE
    Fact_Result
ADD
    CONSTRAINT FK_Fact_Result_RaceKey FOREIGN KEY (RaceKey) REFERENCES Dim_Race(RaceKey),
    CONSTRAINT FK_Fact_Result_DriverKey FOREIGN KEY (DriverKey) REFERENCES Dim_Driver(DriverKey),
    CONSTRAINT FK_Fact_Result_ConstructorKey FOREIGN KEY (ConstructorKey) REFERENCES Dim_Constructor(ConstructorKey),
    CONSTRAINT FK_Fact_Result_CircuitKey FOREIGN KEY (CircuitKey) REFERENCES Dim_Circuit(CircuitKey),
    CONSTRAINT FK_Fact_Result_DateKey FOREIGN KEY (DateKey) REFERENCES Dim_Time(DateKey),
    CONSTRAINT FK_Fact_Result_WeatherKey FOREIGN KEY (WeatherKey) REFERENCES Dim_Weather(WeatherKey),
    CONSTRAINT FK_Fact_Result_StatusKey FOREIGN KEY (StatusKey) REFERENCES Dim_Status(StatusKey);