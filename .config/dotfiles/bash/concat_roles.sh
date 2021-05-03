#!/usr/bin/env bash

# export bash_dotfiles_root="$HOME/.config/dotfiles/bash"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "$SCRIPT_DIR"/export_dotfiles_root.sh

DEBUG="false"
# DEBUG="true"

if [ "$DEBUG" = 'true' ]; then
    source "$bash_dotfiles_root"/generate_file_order.sh && gen_files
else
    source "$bash_dotfiles_root"/generate_file_order.sh && gen_files > /dev/null 2>&1
fi

FILE_ORDER="$bash_dotfiles_root"/meta/data/ordered_concatenated_files.txt

# ================= create ROLES array =========================================
LAST_ROLE="$(cat "$bash_dotfiles_root/meta/data/last_role.txt")"
# LAST_ROLE="$(cat "$bash_dotfiles_root/sourced/last_role.txt")"
[ "$DEBUG" = 'true' ] && echo "last is: $LAST_ROLE"
all_roles=('minimal' 'common' 'dev' 'desktop')
declare -a ROLES=()
for role in "${all_roles[@]}"; do
    ROLES+=("$role")
    [ "$role" = "$LAST_ROLE" ] && break
done
[ "$DEBUG" = 'true' ] && echo "the roles array is: ${ROLES[@]}"
# ================= create ROLES array =========================================


# clear file contents
for role in "${ROLES[@]}"; do
    echo -e "#!/usr/bin/env bash\n" > "$bash_dotfiles_root/sourced/$role".sh
done


counter=0
ROLE="${ROLES[$counter]}"
prefix_len="$((${#bash_dotfiles_root} + 1))"
out_name="$bash_dotfiles_root/sourced/$ROLE".sh

while IFS="" read -r file_name || [ -n "$file_name" ]
do
    # iterate over roles
    if ! grep -q "$ROLE" <<< "$file_name"; then
        counter=$(($counter + 1))
        ROLE="${ROLES[$counter]}"
        out_name="$bash_dotfiles_root/sourced/$ROLE".sh
    fi

    # remove $bash_dotfiles_root prefix from $file_name
    without_dot_file_name="${file_name:$prefix_len}"
    # add 4 cuz $without_dot_file_name is surrounded by 2 spaces on each side
    f_name_len="$((${#without_dot_file_name} + 4))"
    # f_name_len=$((f_name_len + 4))

    printf -v topp "=%.0s" $(seq $f_name_len)
    sides='==============='

    # write $file_name surrounded by a box of '='
    echo -e "\n\n" >> "$out_name"
    echo    "# ${sides}${topp}${sides} #" >> "$out_name"
    echo    "# ${sides}${topp}${sides} #" >> "$out_name"
    echo    "# $sides  $without_dot_file_name  $sides #" >> "$out_name"
    echo -e "# ${sides}${topp}${sides} #\n" >> "$out_name"

    # debug flag allows me to echo name of each file when script executes to help me
    # track down where errors occur
    [ "$DEBUG" = "true" ] && echo "echo 'sourcing $without_dot_file_name...'" >> "$out_name"

    # Todo: check that  the script has a shebang first !
    # don't add shebang in each script
    tail -n+2 "$file_name" >> "$out_name"

# done < "$bash_dotfiles_root"/files.txt
done < "$FILE_ORDER"
