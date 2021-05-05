from pathlib import Path
import sys
from collections import defaultdict
from pprint import pprint as pp


def get_template(distro, role, packages):
    big_string = f'{distro}_{role}:\n'
    for package in packages:
        big_string += f'  - {package}\n'
    return big_string

if __name__ == "__main__":
    role = sys.argv[1]
    installs_per_role = defaultdict(dict)
    for fil in Path('../data/installed_files_per_role/distros').rglob('*txt'):
        # last entry in split is empty string
        installs_per_role[fil.parent.stem][fil.stem] = fil.read_text().split('\n')[:-1]
    # pp(installs_per_role)
    for distro, roles in installs_per_role.items():
        for role, packages in roles.items():
            print(get_template(distro, role, packages))
