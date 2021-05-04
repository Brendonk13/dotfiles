import sys
import pathlib
from textwrap import dedent
from os import environ



# todo: make this take FINISHED destinations var as input
# then not read file
# and append extra dies
def get_directories(dest_base_dir, destinations):
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
    sources, destinations, dest_dirs = [], [], []
    with open(file_with_paths, 'r') as f:
        for src in f:
            src = src.rstrip('\n')
            dest = src.replace(src_base_dir, dest_base_dir)
            sources.append(src)
            destinations.append(dest)

    return sources, destinations, get_directories(dest_base_dir, destinations)


def create_variables(sources, destinations, dest_dirs):
    # Note: use append since this script is called multiple times
    with open('/tmp/src_file.txt', 'a') as f:
        # f.write('dotfile_sources:\n')
        for src in sources:
            f.write(f'  - {src}\n')
        # f.write('\n\n')
    with open('/tmp/dest_file.txt', 'a') as f:
        # f.write('dotfile_destinations:\n')
        for dest in destinations:
            f.write(f'  - {dest}\n')
        # f.write('\n\n')
    with open('/tmp/ansb_directories.txt', 'a') as f:
        # f.write('created_dirs:\n')
        for dest_dir in dest_dirs:
            f.write(f'  - {dest_dir}\n')
        # this one
        # f.write('\n\n')


    # with open(generated_file, 'a') as f:
    #     f.write(f'\n\n{src_name}:\n')
    #     for src in sources:
    #         f.write(f'  - {src}\n')
    #     f.write('\n\n')

    #     f.write(f'{dest_name}:\n')
    #     for dest in destinations:
    #         f.write(f'  - {dest}\n')
    #     f.write('\n\n')

        # f.write(f'{dir_name}:\n')
        # for dir_name in dest_dirs:
        #     f.write(f'  - {dir_name}\n')




if __name__ == "__main__":
    # print(sys.argv)
    dest_base_dir, file_with_paths = sys.argv[1:]
    create_variables(
        *get_src_and_dest(dest_base_dir, file_with_paths)
    )


    # gen_copy_file(
    #     '/home/brendon/.config/dotfiles/bash/files.txt',
    #     '/home/OTHER_USER/.config/brendon_dotfiles/bash',
    #     'minimal'
    # )



# def gen_copy_task(*args):
#     dest_base_dir, role, generated_file, file_with_paths = args
#     src_base_dir = environ['bash_dotfiles_root']
#     with open(generated_file, 'w') as generated_file:
#         with open(file_with_paths, 'r') as f:
#             for src in f:
#                 src = src.rstrip('\n')
#                 dest = src.replace(src_base_dir, dest_base_dir)
#                 generated_file.write(copy_task_template(src, dest))
#                 generated_file.write('\n')

# def gen_copy_task(generated_file, var_name, sources, destinations):
#     src_name, dest_name = f'{var_name}_sources', f'{var_name}_destinations'
#     with open(generated_file, 'w') as f:
#         f.write(f'---\n{src_name}:\n')
#         for src in sources:
#             f.write(f'  - {src}\n')
#         f.write('\n\n')

#         f.write(f'{dest_name}:\n')
#         for dest in destinations:
#             f.write(f'  - {dest}\n')


# def copy_task_template(src, dest):
#     return dedent("""
#         - name: copy {0} ===> {1}
#             copy:
#             src: {0}
#             dest: {1}
#         """).format(src, dest)


