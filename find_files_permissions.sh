# This script is used to find files in the home directory and its subdirectories,
# check their permissions, and classify them into different categories based on
# the read and write permissions for the user. The classified results are then
# written to a specified output file.

# The script starts by setting the output file where the results will be written.
# If the file already exists, it will be cleared. If it doesn't exist, a new file
# will be created.

# The 'get_permissions_and_classify' function is defined to extract the file
# permissions and classify them based on the read and write permissions for the user.
# It takes a file path as an argument and uses the 'ls' command with the '-l' option
# to get the permissions. The permissions are then checked and the corresponding
# category is echoed along with the file path.

# The script then uses the 'find' command to search for all files (type 'f') in the
# home directory and its subdirectories. For each file found, the 'get_permissions_and_classify'
# function is called to classify the file based on its permissions. The classified
# results are then appended to the output file.

# Finally, a message is printed to indicate that the filtered file paths and categories
# have been written to the output file.



#!/bin/bash
output_file="filtered_files_permissions.txt"
> "$output_file"
get_permissions_and_classify() {
    local file="$1"
    local perms
    perms=$(ls -l "$file" | awk '{print $1}')
    local user_perms="${perms:1:2}"
    if [[ "$user_perms" == "rw" ]]; then
        echo "write_and_read $file"
    elif [[ "$user_perms" == "w-" ]]; then
        echo "only_write $file"
    elif [[ "$user_perms" == "r-" ]]; then
        echo "only_read $file"
    fi
}
find ~ -type f 2>/dev/null | while read file; do
    result=$(get_permissions_and_classify "$file")
    if [[ -n "$result" ]]; then
        echo "$result" >> "$output_file"
    fi
done
echo "Filtered file paths and categories have been written to '$output_file'."
