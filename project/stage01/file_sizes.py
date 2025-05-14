import os
import glob


def get_file_sizes(directory: str) -> None:
    file_list: list[str] = glob.glob(os.path.join(directory, '*'))

    for file_path in file_list:
        if os.path.isfile(file_path):
            file_size_bytes: int = os.path.getsize(file_path)
            file_size_mb: float = file_size_bytes / (1024 * 1024)
            print(f"File: {file_path}, Size: {file_size_mb:.2f} MB")


if __name__ == "__main__":
    directory: str = os.path.join(os.path.dirname(__file__), 'data')

    get_file_sizes(directory)
