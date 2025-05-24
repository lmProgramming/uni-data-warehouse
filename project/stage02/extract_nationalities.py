import pandas as pd

file_path = r"C:\Users\Jantar\uni-data-warehouse\project\stage02\data\drivers.xlsx"
df: pd.DataFrame = pd.read_excel(file_path)

nationality_col = 'nationality'

unique_nationalities = df[nationality_col].dropna().unique()

unique_nationalities = sorted(unique_nationalities)

for nat in unique_nationalities:
    print(nat)
