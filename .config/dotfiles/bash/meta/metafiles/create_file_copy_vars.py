import sys
import pathlib
from textwrap import dedent
from os import environ



def get_directories(file_with_paths):
    with open(file_with_paths, 'r') as f:
        return [
            pathlib.Path(line).parents[0]
            for line in f
        ]


def get_src_and_dest(dest_base_dir, file_with_paths):
    src_base_dir = environ['bash_dotfiles_root']
    sources, destinations, dest_dirs = [], [], []
    # sources, destinations = [], []
    directories = get_directories(file_with_paths)
    with open(file_with_paths, 'r') as f:
        for src in f:
            src = src.rstrip('\n')
            dest = src.replace(src_base_dir, dest_base_dir)
            dest_dir = pathlib.Path(dest).parents[0]
            sources.append(src)
            destinations.append(dest)
            dest_dirs.append(dest_dir)

    return sources, destinations, set(dest_dirs)
    # return sources, destinations


def get_var_names(var_name):
    return f'{var_name}_sources', f'{var_name}_destinations', f'{var_name}_dirs'


def create_variables(generated_file, var_name, sources, destinations, dest_dirs):
# def create_variables(generated_file, var_name, sources, destinations):
    src_name, dest_name, dir_name = get_var_names(var_name)
    with open('/tmp/src_file.txt', 'a') as f:
        for src in sources:
            f.write(f'  - {src}\n')
    with open('/tmp/dest_file.txt', 'a') as f:
        for dest in destinations:
            f.write(f'  - {dest}\n')
    with open('/tmp/ansb_directories.txt', 'a') as f:
        for dest_dir in dest_dirs:
            f.write(f'  - {dest_dir}\n')


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
    dest_base_dir, generated_file, file_with_paths, var_name = sys.argv[1:]
    create_variables(
        generated_file,
        var_name,
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


