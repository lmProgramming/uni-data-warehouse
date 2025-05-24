import pandas as pd

names = ["circuits.csv", "circuits.csv", "constructors.csv", "drivers.csv", "lap_times.csv",
         "pit_stops.csv", "races.csv", "results.csv", "status.csv", "weather.csv",]

for n in names:
    # Read the CSV file
    df = pd.read_csv(r'c:\Users\Jantar\uni-data-warehouse\project\stage02\data\\' + n,
                     quotechar='"', skipinitialspace=True, engine='python')

    # Save as Excel file
    df.to_excel(
        r'c:\Users\Jantar\uni-data-warehouse\project\stage02\data\\' + n.replace(".csv", ".xlsx"), index=False)
