import pandas as pd
from ydata_profiling import ProfileReport
from os import path

pd.set_option('display.max_columns', None)
pd.set_option('display.width', None)
pd.set_option('display.colheader_justify', 'left')

dir_path: str = path.dirname(path.realpath(__file__))

df: pd.DataFrame = pd.read_csv(path.join(dir_path, "dane_lista3.csv"))

profile = ProfileReport(df, explorative=True)

profile.to_file(path.join(dir_path, "python_results.html"))

df['Transaction ID'] = df['Transaction ID'].astype('str')
df['Item'] = df['Item'].astype('str')
df['Quantity'] = pd.to_numeric(df['Quantity'], errors='coerce')
df['Price Per Unit'] = pd.to_numeric(df['Price Per Unit'], errors='coerce')
df['Total Spent'] = pd.to_numeric(df['Total Spent'], errors='coerce')
df['Payment Method'] = df['Payment Method'].astype('str')
df['Location'] = df['Location'].astype('str')
df['Transaction Date'] = pd.to_datetime(
    df['Transaction Date'], errors='coerce')

profile = ProfileReport(df, explorative=True)

profile.to_file(path.join(dir_path, "python_results_good_data_types.html"))

df["Wrong Total"] = (
    df["Quantity"].notnull() &
    df["Price Per Unit"].notnull() &
    df["Total Spent"].notnull() &
    (df["Quantity"] * df["Price Per Unit"] != df["Total Spent"])
)
print(f"Liczba źle policzonych Total Spent: {df['Wrong Total'].sum()}")
print(df[df["Wrong Total"]])
