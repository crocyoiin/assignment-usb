#!/bin/bash

cleanup() {
    echo "Cleaning up..."
    kill "$SERVER_PID" 2>/dev/null  # Kill the background server process
    cd ..
    rm -rf hosted_files
}

trap cleanup EXIT INT

if [ -d hosted_files ]; then
    rm -rf hosted_files
fi

mkdir hosted_files
cp hosted_payload.sh hosted_files
cd hosted_files

python3 -m http.server 8000 &
SERVER_PID=$!

wait "$SERVER_PID"