import pandas as pd
import os
from ydata_profiling import ProfileReport

data_folder_path = './data/'
reports_folder_path = './profiling_reports/'

csv_files = [
    "circuits.csv",
    "constructors.csv",
    "constructor_results.csv",
    "constructor_standings.csv",
    "drivers.csv",
    "driver_standings.csv",
    "lap_times.csv",
    "pit_stops.csv",
    "qualifying.csv",
    "races.csv",
    "results.csv",
    "seasons.csv",
    "sprint_results.csv",
    "status.csv",
    "weather.csv"
]


def generate_profiling_report(file_path, file_name, output_folder):
    """
    Generuje raport profilowania dla pojedynczego pliku CSV i zapisuje go jako HTML.
    """
    print(f"\n{'='*30} Generowanie raportu dla: {file_name} {'='*30}")
    try:
        df = pd.read_csv(file_path, low_memory=False, na_values=[
                         '\\N'])

        profile = ProfileReport(df,
                                title=f"Raport Profilowania Danych - {file_name}",
                                explorative=True)

        output_file_name = f"{os.path.splitext(file_name)[0]}_profiling_report.html"
        output_file_path = os.path.join(output_folder, output_file_name)

        profile.to_file(output_file_path)
        print(
            f"Raport dla '{file_name}' został zapisany jako: {output_file_path}")

    except FileNotFoundError:
        print(f"BŁĄD: Plik {file_name} nie został znaleziony w {file_path}")
    except Exception as e:
        print(
            f"BŁĄD: Wystąpił problem podczas generowania raportu dla {file_name}: {e}")


if __name__ == "__main__":
    if not os.path.exists(reports_folder_path):
        try:
            os.makedirs(reports_folder_path)
            print(f"Utworzono folder na raporty: {reports_folder_path}")
        except OSError as e:
            print(
                f"BŁĄD KRYTYCZNY: Nie można utworzyć folderu na raporty '{reports_folder_path}': {e}")
            exit()

    if not os.path.exists(data_folder_path):
        print(
            f"BŁĄD KRYTYCZNY: Folder danych '{data_folder_path}' nie istnieje. Proszę poprawić ścieżkę.")
    else:
        for file_name in csv_files:
            full_file_path = os.path.join(data_folder_path, file_name)
            generate_profiling_report(
                full_file_path, file_name, reports_folder_path)
        print(f"\n{'='*30} Koniec generowania wszystkich raportów {'='*30}")
