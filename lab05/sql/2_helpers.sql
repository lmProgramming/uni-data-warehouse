CREATE TABLE Kubs.Helper_Months (
    MonthNum INT PRIMARY KEY,
    MonthName_PL NVARCHAR(20) NOT NULL
);
INSERT INTO Kubs.Helper_Months (MonthNum, MonthName_PL) VALUES
(1, N'Styczen'), (2, N'Luty'), (3, N'Marzec'), (4, N'Kwiecien'),
(5, N'Maj'), (6, N'Czerwiec'), (7, N'Lipiec'), (8, N'Sierpien'),
(9, N'Wrzesien'), (10, N'Pazdziernik'), (11, N'Listopad'), (12, N'Grudzien');

CREATE TABLE Kubs.Helper_Weekdays (
    WeekdayNum INT PRIMARY KEY,
    WeekdayName_PL NVARCHAR(20) NOT NULL
);
INSERT INTO Kubs.Helper_Weekdays (WeekdayNum, WeekdayName_PL) VALUES
(1, N'Niedziela'), (2, N'Poniedzialek'), (3, N'Wtorek'), (4, N'Sroda'),
(5, N'Czwartek'), (6, N'Piatek'), (7, N'Sobota');