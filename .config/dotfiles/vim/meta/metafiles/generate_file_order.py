import argparse
import re
from textwrap import dedent
from math import floor
from pprint import pprint as pp
from pathlib import Path
import os
# from pathlib import Path; root = Path(open('../data/vim_dotfiles_root.txt').readline().rstrip('\n'))

NONE_PATTERN = re.compile(r'.+none.+')
fil = '{}/../data/vim_dotfiles_root.txt'.format(os.path.dirname(os.path.realpath(__file__)))
ROOT_DIR = Path(Path(fil).read_text().rstrip('\n'))

FILE_ORDER = ['autocmds', 'functions', 'commands', 'mappings']

# print(f'current directory: {os.getcwd()}')


def get_files(directory,  file_pattern):
    return (
        fil
        for fil in directory.rglob(file_pattern)
        if fil.is_file() and not NONE_PATTERN.search(str(fil))
    )

def ordered_vim_files_in_dir(subdir_order, plugin_names=False):
    files = []
    file_pattern = '.plug_name' if plugin_names else '*.vim'
    for directory in (ROOT_DIR / dir for dir in subdir_order):
        if directory.exists():
            files += get_files(directory, file_pattern)
    return files


def no_plugin_order():
    subdir_order = ['vimrc', *FILE_ORDER, 'other', 'os_specific']
    return ordered_vim_files_in_dir(subdir_order)

def essential_plugin_order(role, just_plugin_names=False):
    subdir_order = ['no_dependencies'] if role == 'common' else ['one_dependency', 'few_dependencies']
    subdir_order = (f'plugins/essentials/{dir}' for dir in subdir_order)
    return ordered_vim_files_in_dir(subdir_order, just_plugin_names)

def other_plugin_order(just_plugin_names=False):
    subdir_order = ['plugins/others']
    return ordered_vim_files_in_dir(subdir_order, just_plugin_names)


def get_files_in_role(role):
    if role == 'minimal':
        return no_plugin_order(), []
    elif role in ('common', 'dev'):
        return essential_plugin_order(role), essential_plugin_order(role, just_plugin_names=True)
    else:
        return other_plugin_order(), other_plugin_order(just_plugin_names=True)


def get_header(header_fname):
    used_space = 2 + len(header_fname)
    len_side = floor((80 - used_space) / 2)
    side = '=' * len_side
    left = f'"# {side}'
    right = f'{side} #'
    full_row = left + ('=' * (len(header_fname))) + right
    return dedent(f"""
        {full_row}
        {full_row}
        {left}{header_fname}{right}
        {full_row}

    """)

def append_file_contents(written_to, file_name):
    written_to.write(get_header(f'  {file_name.relative_to(ROOT_DIR)}  '))
    written_to.write(Path(file_name).read_text())
    written_to.write('\n')

def create_plug_call_file(plugin_names):
    with open(ROOT_DIR / 'sourced/plug_names.vim', 'w') as f:
        print(ROOT_DIR)
        f.write("call plug#begin()\n\n")
        for plugin_name in plugin_names:
            tmp = str(plugin_name)
            tmp = tmp.replace(str(ROOT_DIR), '')
            print(tmp)
            f.write(Path(plugin_name).read_text())
        f.write("\ncall plug#end()")

def concat_files_for(curr_role, files_in_role):
    out_name = ROOT_DIR / f'sourced/{curr_role}.vim'
    print(out_name)
    with open(out_name, 'w') as f:
        for file_name in files_in_role:
            append_file_contents(f, file_name)

def generate_files(last_role):
    role_order = ['minimal', 'common', 'dev', 'desktop']
    all_files, plugin_names = [], []
    for curr_role in role_order:
        files, plug_names = get_files_in_role(curr_role)
        plugin_names += plug_names
        all_files += files
        concat_files_for(curr_role, files)
        if curr_role == last_role: break
    return all_files, plugin_names


def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('-r', '--role',
            choices=['minimal', 'common', 'dev', 'desktop'],
            dest='role',
            default='desktop'
    )
    parser.add_argument('-o', '--out-file', dest='out_file', required=False, default=None)
    # maybe add interactive plugin adder thing for selecting plugins
    #  -- bash script which calls this with a --plugin(s) arg
    return parser.parse_args()


if __name__ == "__main__":
    args = get_args()
    all_files, plugin_names = generate_files(last_role=args.role)
    # pp(plugin_names)
    if args.out_file:
        out_file = args.out_file
        Path(out_file).write_text('\n'.join(str(f) for f in all_files))
        Path(out_file + '_plugins').write_text('\n'.join(str(f) for f in plugin_names))
    else:
        out_file2 = str(ROOT_DIR / 'meta/data/ordered_concatenated_files.txt')
        Path(out_file2).write_text('\n'.join(str(f) for f in all_files))
        create_plug_call_file(plugin_names)
    #     # if output file not given, write 

