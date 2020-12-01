#!/bin/sh

# Initializing globals
prefix=""

expand_prefix() {
    prefix="${prefix}| "
}

contract_prefix() {
    # Also, don't know why this works, just found it here: https://stackoverflow.com/questions/27658675/how-to-remove-last-n-characters-from-a-string-in-bash
    prefix=${prefix%| }
}

traverse() {
    for file in *; do
        if [ -d "$file" ]; then
            echo "${prefix}*  [${file}]"
            echo "${prefix}|\\"
            expand_prefix
            cd "$file"
            traverse
            cd ..
            contract_prefix
        else
            echo "${prefix}*  ${file}"
        fi
    done
}

# Main
echo "please enter a directory to traverse: "
read starting_path
cd "$starting_path"
echo
printf "Starting at: "; pwd
traverse
