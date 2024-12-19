#!/bin/bash

# This script lists all the files that contain the flag defined by the variable 'flag'.

flag="# flagista"
while IFS= read -r line; do
    file=$(echo "$line" | awk '{print $2}')
    if [ -f "$file" ]; then
        if grep -q "$flag" "$file"; then
            echo "$file"
        fi
    fi
done < "filtered_files_permissions.txt"
