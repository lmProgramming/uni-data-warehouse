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
    ('Andorra', 'Europe'),
    ('Argentina', 'South America'),
    ('Australia', 'Oceania'),
    ('Austria', 'Europe'),
    ('Azerbaijan', 'Asia'),
    ('Bahrain', 'Asia'),
    ('Belgium', 'Europe'),
    ('Brazil', 'South America'),
    ('Bulgaria', 'Europe'),
    ('Canada', 'North America'),
    ('Chile', 'South America'),
    ('China', 'Asia'),
    ('Colombia', 'South America'),
    ('Croatia', 'Europe'),
    ('Czech Republic', 'Europe'),
    ('Denmark', 'Europe'),
    ('Estonia', 'Europe'),
    ('Finland', 'Europe'),
    ('France', 'Europe'),
    ('Georgia', 'Asia'),
    ('Germany', 'Europe'),
    ('Hungary', 'Europe'),
    ('India', 'Asia'),
    ('Indonesia', 'Asia'),
    ('Italy', 'Europe'),
    ('Japan', 'Asia'),
    ('Korea', 'Asia'),
    ('Liechtenstein', 'Europe'),
    ('Malaysia', 'Asia'),
    ('Malta', 'Europe'),
    ('Mexico', 'North America'),
    ('Monaco', 'Europe'),
    ('Morocco', 'Africa'),
    ('Netherlands', 'Europe'),
    ('New Zealand', 'Oceania'),
    ('Poland', 'Europe'),
    ('Portugal', 'Europe'),
    ('Qatar', 'Asia'),
    ('Russia', 'Europe'),
    ('Saudi Arabia', 'Asia'),
    ('Serbia', 'Europe'),
    ('Singapore', 'Asia'),
    ('Slovakia', 'Europe'),
    ('South Africa', 'Africa'),
    ('Spain', 'Europe'),
    ('Sweden', 'Europe'),
    ('Switzerland', 'Europe'),
    ('Thailand', 'Asia'),
    ('Turkey', 'Asia'),
    ('UAE', 'Asia'),
    ('UK', 'Europe'),
    ('USA', 'North America'),
    ('Ukraine', 'Europe'),
    ('Uruguay', 'South America'),
    ('Venezuela', 'South America'),
    ('Zimbabwe', 'Africa');

CREATE TABLE Helper_NationalityCountries (
    Nationality NVARCHAR(100) PRIMARY KEY,
    CountryName NVARCHAR(100) NOT NULL
);

INSERT INTO
    Helper_NationalityCountries (Nationality, CountryName)
VALUES
    ('American', 'USA'),
    ('American-Italian', 'USA'),
    ('Andorran', 'Andorra'),
    ('Argentine', 'Argentina'),
    ('Argentine-Italian', 'Argentina'),
    ('Argentinian', 'Argentina'),
    ('Australian', 'Australia'),
    ('Austrian', 'Austria'),
    ('Azerbaijani', 'Azerbaijan'),
    ('Belgian', 'Belgium'),
    ('Brazilian', 'Brazil'),
    ('British', 'UK'),
    ('Bulgarian', 'Bulgaria'),
    ('Canadian', 'Canada'),
    ('Chilean', 'Chile'),
    ('Chinese', 'China'),
    ('Colombian', 'Colombia'),
    ('Croatian', 'Croatia'),
    ('Czech', 'Czech Republic'),
    ('Danish', 'Denmark'),
    ('Dutch', 'Netherlands'),
    ('East German', 'Germany'),
    ('Emirati', 'UAE'),
    ('Estonian', 'Estonia'),
    ('Finnish', 'Finland'),
    ('French', 'France'),
    ('Georgian', 'Georgia'),
    ('German', 'Germany'),
    ('Hong Kong', 'China'),
    ('Hungarian', 'Hungary'),
    ('Indian', 'India'),
    ('Indonesian', 'Indonesia'),
    ('Irish', 'UK'),
    ('Italian', 'Italy'),
    ('Japanese', 'Japan'),
    ('Liechtensteiner', 'Liechtenstein'),
    ('Malaysian', 'Malaysia'),
    ('Maltese', 'Malta'),
    ('Mexican', 'Mexico'),
    ('Monegasque', 'Monaco'),
    ('New Zealander', 'New Zealand'),
    ('Polish', 'Poland'),
    ('Portuguese', 'Portugal'),
    ('Qatari', 'Qatar'),
    ('Rhodesian', 'South Africa'),
    ('Russian', 'Russia'),
    ('Saudi', 'Saudi Arabia'),
    ('Serbian', 'Serbia'),
    ('Slovakian', 'Slovakia'),
    ('South African', 'South Africa'),
    ('South Korean', 'Korea'),
    ('Spanish', 'Spain'),
    ('Swedish', 'Sweden'),
    ('Swiss', 'Switzerland'),
    ('Thai', 'Thailand'),
    ('Ukrainian', 'Ukraine'),
    ('Uruguayan', 'Uruguay'),
    ('Venezuelan', 'Venezuela');