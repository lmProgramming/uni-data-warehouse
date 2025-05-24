data = """
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
('Venezuelan', 'Venezuela')
"""

data_to_check = """
American
American-Italian
Argentine
Argentine-Italian
Argentinian
Australian
Austrian
Belgian
Brazilian
British
Canadian
Chilean
Chinese
Colombian
Czech
Danish
Dutch
East German
Finnish
French
German
Hungarian
Indian
Indonesian
Irish
Italian
Japanese
Liechtensteiner
Malaysian
Mexican
Monegasque
New Zealander
Polish
Portuguese
Rhodesian
Russian
South African
Spanish
Swedish
Swiss
Thai
Uruguayan
Venezuelan
    """

to_check_set = set(line.strip()
                   for line in data_to_check.strip().splitlines() if line.strip())

data_countries = set()
for line in data.strip().splitlines():
    parts = line.strip().strip(',').strip('()').split("', '")
    if len(parts) == 2:
        country = parts[0].strip().strip("'")
        data_countries.add(country)

missing = to_check_set - data_countries
present = to_check_set & data_countries

print("Present in data:")
for country in sorted(present):
    print(country)

print("\nMissing from data:")
for country in sorted(missing):
    print(country)
