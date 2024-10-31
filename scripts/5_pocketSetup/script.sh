#!/bin/bash

TEMP_DIR=$(mktemp -d "$HOME/tempdir.XXX")

is_arduino_connected() {
    system_profiler SPUSBDataType | grep -q "Arduino Leonardo"
}

cleanup() {
    echo "Cleaning up!"
    rm -rf "$TEMP_DIR"
}

(
    while is_arduino_connected; do
        sleep 5
    done
    cleanup
) &
