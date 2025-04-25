CREATE TABLE Kubs.DIM_TIME (
    PK_TIME INT PRIMARY KEY,
    FullDate DATE NOT NULL,
    Rok INT NOT NULL,
    Kwartal INT NOT NULL,
    Miesiac INT NOT NULL,
    Miesiac_slownie NVARCHAR(20) NOT NULL,
    Dzien_tyg INT NOT NULL,
    Dzien_tyg_slownie NVARCHAR(20) NOT NULL,
    Dzien_miesiaca INT NOT NULL
);