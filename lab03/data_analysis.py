import pandas as pd
from ydata_profiling import ProfileReport

# Wczytanie pliku CSV
df = pd.read_csv("dane_lista3.csv")

# Tworzenie raportu
profile = ProfileReport(df, explorative=True)

# Zapis raportu do pliku HTML
profile.to_file("profilowanie_danych.html")
