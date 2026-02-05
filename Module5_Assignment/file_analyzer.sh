#!/bin/bash

ERROR_LOG="errors.log"

log_error() {
    echo "$1" | tee -a "$ERROR_LOG"
}

show_help() {
cat << EOF
Usage: $0 [options]

Options:
  -d <directory>   Directory to search recursively
  -k <keyword>     Keyword to search
  -f <file>        File to search directly
  --help           Display this help menu

Examples:
  $0 -d logs -k error
  $0 -f script.sh -k TODO
EOF
}

recursive_search() {
    local dir="$1"
    local keyword="$2"

    for item in "$dir"/*; do
        if [ -f "$item" ]; then
            if grep -q "$keyword" "$item"; then
                echo "Keyword found in: $item"
            fi
        elif [ -d "$item" ]; then
            recursive_search "$item" "$keyword"
        fi
    done
}

if [ $# -eq 0 ]; then
    log_error "No arguments provided"
    exit 1
fi

while getopts ":d:k:f:-:" opt; do
    case $opt in
        d) SEARCH_DIR="$OPTARG" ;;
        k) KEYWORD="$OPTARG" ;;
        f) SEARCH_FILE="$OPTARG" ;;
        -)
            if [ "$OPTARG" = "help" ]; then
                show_help
                exit 0
            fi
            ;;
        *)
            log_error "Invalid option used"
            exit 1
            ;;
    esac
done

if [[ -z "$KEYWORD" || ! "$KEYWORD" =~ ^[a-zA-Z0-9_]+$ ]]; then
    log_error "Invalid or empty keyword"
    exit 1
fi

if [ -n "$SEARCH_DIR" ]; then
    if [ ! -d "$SEARCH_DIR" ]; then
        log_error "Directory does not exist: $SEARCH_DIR"
        exit 1
    fi
    recursive_search "$SEARCH_DIR" "$KEYWORD"
    echo "Exit status: $?"
elif [ -n "$SEARCH_FILE" ]; then
    if [ ! -f "$SEARCH_FILE" ]; then
        log_error "File does not exist: $SEARCH_FILE"
        exit 1
    fi
    grep "$KEYWORD" <<< "$(cat "$SEARCH_FILE")"
    echo "Exit status: $?"
else
    log_error "Either directory or file must be specified"
    exit 1
fi
