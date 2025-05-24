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

CREATE TABLE Helper_CountryContinents (
    CountryName NVARCHAR(100) PRIMARY KEY,
    Continent NVARCHAR(50) NOT NULL
);

INSERT INTO
    Helper_CountryContinents (CountryName, Continent)
VALUES
    ('Australia', 'Oceania'),
    ('Malaysia', 'Asia'),
    ('Bahrain', 'Asia'),
    ('Spain', 'Europe'),
    ('Turkey', 'Asia'),
    ('Monaco', 'Europe'),
    ('Canada', 'North America'),
    ('France', 'Europe'),
    ('UK', 'Europe'),
    ('Germany', 'Europe'),
    ('Hungary', 'Europe'),
    ('Belgium', 'Europe'),
    ('Italy', 'Europe'),
    ('Singapore', 'Asia'),
    ('Japan', 'Asia'),
    ('China', 'Asia'),
    ('Brazil', 'South America'),
    ('USA', 'North America'),
    ('UAE', 'Asia'),
    ('Argentina', 'South America'),
    ('Portugal', 'Europe'),
    ('South Africa', 'Africa'),
    ('Mexico', 'North America'),
    ('Netherlands', 'Europe'),
    ('Sweden', 'Europe'),
    ('Korea', 'Asia'),
    ('Austria', 'Europe'),
    ('Morocco', 'Africa'),
    ('Switzerland', 'Europe'),
    ('India', 'Asia'),
    ('Russia', 'Europe'),
    ('Azerbaijan', 'Asia'),
    ('Saudi Arabia', 'Asia'),
    ('Qatar', 'Asia');

CREATE TABLE Helper_NationalityCountries (
    Nationality NVARCHAR(100) PRIMARY KEY,
    CountryName NVARCHAR(100) NOT NULL
);

INSERT INTO
    Helper_NationalityCountries (Nationality, CountryName)
VALUES
    ('British', 'UK'),
    ('German', 'Germany'),
    ('French', 'France'),
    ('Italian', 'Italy'),
    ('Japanese', 'Japan'),
    ('Austrian', 'Austria'),
    ('Indian', 'India'),
    ('Dutch', 'Netherlands'),
    ('Russian', 'Russia'),
    ('Swiss', 'Switzerland'),
    ('Irish', 'UK'),
    ('Hong Kong', 'China'),
    ('Brazilian', 'Brazil'),
    ('Canadian', 'Canada'),
    ('Mexican', 'Mexico'),
    ('American', 'USA'),
    ('Australian', 'Australia'),
    ('New Zealander', 'UK'),
    ('South African', 'South Africa'),
    ('Rhodesian', 'South Africa'),
    ('Belgian', 'Belgium'),
    ('Malaysian', 'Malaysia'),
    ('Spanish', 'Spain'),
    ('East German', 'Germany');