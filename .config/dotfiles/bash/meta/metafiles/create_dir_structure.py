import sys
import pathlib


"""
Plan:
    other python scripts append to two different files each time

    then bash script comes along and concatenates everything into one file
    -- 1 variable for all source/destinations
    -- 1 variable for all dirs created
"""


def dir_name(file_name):
    return file_name.rstrip('\n').replace(src_base_dir, dest_base_dir)

def get_directories(file_with_paths):
    with open(file_with_paths, 'r') as f:
        return [
            pathlib.Path(dir_name(line)).parents[0]
            for line in f
        ]



if __name__ == '__main__':
    dest_base_dir, generated_file, file_with_paths, var_name = sys.argv[1:]
    # todo: make this take both generated_files as input so that all are put
    with open(generated_file, 'a') as f:
        for directory in get_directories(file_with_paths):

