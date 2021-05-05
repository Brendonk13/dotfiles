import sys
import pathlib
from textwrap import dedent
from os import environ




def get_directories(dest_base_dir, destinations):
    """ Return directories of destinations plus some other dirs
        not found in destinations but needed
    """
    def most_dirs():
        return [
            pathlib.Path(dest).parents[0]
            for dest in destinations
        ]
    return set(
        most_dirs() + [
                f'{dest_base_dir}/meta/data',
                f'{dest_base_dir}/sourced',
            ]
        )


def get_src_and_dest(dest_base_dir, file_with_paths):
    src_base_dir = environ['bash_dotfiles_root']
    sources, destinations = [], []
    with open(file_with_paths, 'r') as f:
        for src in f:
            src = src.rstrip('\n')
            dest = src.replace(src_base_dir, dest_base_dir)
            sources.append(src)
            destinations.append(dest)

    return sources, destinations, get_directories(dest_base_dir, destinations)


def write_variable(file_name, var_names):
    # Note: use append since this script is called multiple times
    with open(file_name, 'a') as f:
        for var_name in var_names:
            f.write(f'  - {var_name}\n')


# def create_variables(sources, destinations, dest_dirs):
def create_variables(*args):
    file_names = ('/tmp/src_file.txt', '/tmp/dest_file.txt', '/tmp/ansb_directories.txt')
    for file_name, var_names in zip(file_names, args):
        write_variable(file_name, var_names)




if __name__ == "__main__":
    dest_base_dir, file_with_paths = sys.argv[1:]
    create_variables(
        *get_src_and_dest(dest_base_dir, file_with_paths)
    )


    # gen_copy_file(
    #     '/home/brendon/.config/dotfiles/bash/files.txt',
    #     '/home/OTHER_USER/.config/brendon_dotfiles/bash',
    #     'minimal'
    # )



