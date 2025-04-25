CREATE TABLE Kubs.Helper_Months (
    MonthNum INT PRIMARY KEY,
    MonthName_PL NVARCHAR(20) NOT NULL
);

INSERT INTO
    Kubs.Helper_Months (MonthNum, MonthName_PL)
VALUES
    (1, 'Styczen'),
    (2, 'Luty'),
    (3, 'Marzec'),
    (4, 'Kwiecien'),
    (5, 'Maj'),
    (6, 'Czerwiec'),
    (7, 'Lipiec'),
    (8, 'Sierpien'),
    (9, 'Wrzesien'),
    (10, 'Pazdziernik'),
    (11, 'Listopad'),
    (12, 'Grudzien');

CREATE TABLE Kubs.Helper_Weekdays (
    WeekdayNum INT PRIMARY KEY,
    WeekdayName_PL NVARCHAR(20) NOT NULL
);

INSERT INTO
    Kubs.Helper_Weekdays (WeekdayNum, WeekdayName_PL)
VALUES
    (1, 'Niedziela'),
    (2, 'Poniedzialek'),
    (3, 'Wtorek'),
    (4, 'Sroda'),
    (5, 'Czwartek'),
    (6, 'Piatek'),
    (7, 'Sobota');