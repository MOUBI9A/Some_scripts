#!/bin/bash

# This script removes a specific flag from multiple files listed in 'filtered_files_permissions.txt'.

# Define the flag to be removed
flag="# flagista"
while IFS= read -r line; do
    file=$(echo "$line" | awk '{print $2}')
    if [ -f "$file" ]; then
        sed -i "/$flag/d" "$file"
        echo "Flag removed from $file"
    else
        echo "Error: $file does not exist"
    fi
done < "filtered_files_permissions.txt"
