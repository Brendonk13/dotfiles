#todo: move this file to test directory
#      AND make it read the env var: $dotbashdir

from os import environ

def examine_file_lists():
    # base_dir = environ['bash_dotfiles_root'] + '/'
    base_dir = '/home/brendon/new_dotfiles/bash/'

    # find . -name "*.sh" > find_output_sh_files.txt
    with open(base_dir + 'find_output_sh_files.txt', 'r') as from_find_cmd:
        find_cmd_contents = set(from_find_cmd.read().split('\n'))
    # bash main.sh
    with open(base_dir + '/meta/data/ordered_concatenated_files.txt', 'r') as from_main_sh:
        main_sh_contents = set(from_main_sh.read().split('\n'))

    # print(find_cmd_contents)
    print(f'find cmd files: {len(find_cmd_contents)}')
    print(f'main.sh  files: {len(main_sh_contents)}')

    print('files IN find command but NOT IN main.sh output:')
    for fil in find_cmd_contents - main_sh_contents:
        print('    ' + fil)

if __name__ == "__main__":
    examine_file_lists()
