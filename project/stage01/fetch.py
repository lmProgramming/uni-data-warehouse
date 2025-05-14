import kagglehub

path: str = kagglehub.dataset_download(
    "rohanrao/formula-1-world-championship-1950-2020")

print("Path to dataset files:", path)

path2: str = kagglehub.dataset_download(
    "quantumkaze/f1-weather-dataset-2018-2023")

print("Path to weather files:", path2)
