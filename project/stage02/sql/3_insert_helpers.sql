CREATE TABLE Helper_Months (
    MonthNum INT PRIMARY KEY,
    MonthName NVARCHAR(20) NOT NULL
);

INSERT INTO
    Helper_Months (MonthNum, MonthName)
VALUES
    (1, 'January'),
    (2, 'February'),
    (3, 'March'),
    (4, 'April'),
    (5, 'May'),
    (6, 'June'),
    (7, 'July'),
    (8, 'August'),
    (9, 'September'),
    (10, 'October'),
    (11, 'November'),
    (12, 'December');

CREATE TABLE Helper_Weekdays (
    WeekdayNum INT PRIMARY KEY,
    WeekdayName NVARCHAR(20) NOT NULL
);

INSERT INTO
    Helper_Weekdays (WeekdayNum, WeekdayName)
VALUES
    (1, 'Sunday'),
    (2, 'Monday'),
    (3, 'Tuesday'),
    (4, 'Wednesday'),
    (5, 'Thursday'),
    (6, 'Friday'),
    (7, 'Saturday');