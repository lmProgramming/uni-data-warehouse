import pandas as pd

# Wczytaj plik Excel
file_path = r"C:\Users\Jantar\uni-data-warehouse\project\stage02\data\drivers.xlsx"
df = pd.read_excel(file_path)

# Zakładamy, że kolumna z narodowością nazywa się 'nationality'
# Jeśli ma inną nazwę, zmień poniżej
nationality_col = 'nationality'

# Wyodrębnij unikalne narodowości
unique_nationalities = df[nationality_col].dropna().unique()

# Posortuj alfabetycznie
unique_nationalities = sorted(unique_nationalities)

# Wyświetl lub zapisz do pliku
for nat in unique_nationalities:
    print(nat)
