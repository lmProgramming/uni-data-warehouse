import pandas as pd
from ydata_profiling import ProfileReport
from os import path

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
