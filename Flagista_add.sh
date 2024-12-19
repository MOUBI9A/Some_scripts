#!/bin/bash

# This script adds a flag to the end of each file listed in the 'filtered_files_permissions.txt' file.
# The flag is defined by the variable 'flag' and is appended to each file if it exists.
# If a file does not exist, an error message is printed.

flag="# flagista"
while IFS= read -r line; do
    file=$(echo "$line" | awk '{print $2}')
    if [ -f "$file" ]; then
        echo "$flag" >> "$file"
        echo "Flag added to $file"
    else
        echo "Error: $file does not exist"
    fi
done < "filtered_files_permissions.txt"


