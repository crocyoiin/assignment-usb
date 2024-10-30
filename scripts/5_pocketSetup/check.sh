#!/bin/bash

DEVICE_NAME="Arduino Leonardo"

while true; do
    if ! system_profiler SPUSBDataType | grep -q "$DEVICE_NAME"; then
        echo "$DEVICE_NAME has been unplugged."
        break
    fi
    sleep 5
done