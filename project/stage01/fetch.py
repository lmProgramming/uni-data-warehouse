import kagglehub

path: str = kagglehub.dataset_download(
    "rohanrao/formula-1-world-championship-1950-2020", path="/data")

print("Path to dataset files:", path)
