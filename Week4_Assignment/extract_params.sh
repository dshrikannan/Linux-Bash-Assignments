#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 input.txt"
    exit 1
fi

INPUT_FILE="$1"
OUTPUT_FILE="output.txt"

> "$OUTPUT_FILE"

awk -F'"' '
/"frame.time"/ {
    print "\"frame.time\": \"" $4 "\"," >> "output.txt"
}
/"wlan.fc.type"/ {
    print "\"wlan.fc.type\": \"" $4 "\"," >> "output.txt"
}
/"wlan.fc.subtype"/ {
    print "\"wlan.fc.subtype\": \"" $4 "\"" >> "output.txt"
}
' "$INPUT_FILE"

echo "Output generated in output.txt"

