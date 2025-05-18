import os
import glob


def get_file_first_x_lines(x: int, directory: str) -> None:
    file_list: list[str] = glob.glob(os.path.join(directory, '*'))

    for file_path in file_list:
        if os.path.isfile(file_path):
            with open(file_path, 'r', encoding='utf-8') as f:
                print(os.path.basename(file_path))
                for i, line in enumerate(f):
                    if i >= x:
                        break
                    print(line.rstrip())
                print()


if __name__ == "__main__":
    directory: str = os.path.join(os.path.dirname(__file__), 'data')

    get_file_first_x_lines(3, directory)
