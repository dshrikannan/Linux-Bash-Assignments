#!/bin/bash

# --------- Argument Check ----------
if [ $# -ne 3 ]; then
    echo "Usage: $0 <source_dir> <backup_dir> <file_extension>"
    exit 1
fi

SOURCE_DIR="$1"
BACKUP_DIR="$2"
EXTENSION="$3"

# --------- Check source directory ----------
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Source directory does not exist"
    exit 1
fi

# --------- Create backup directory if not exists ----------
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
    if [ $? -ne 0 ]; then
        echo "Failed to create backup directory"
        exit 1
    fi
fi

# --------- Globbing and Array ----------
FILES=("$SOURCE_DIR"/*"$EXTENSION")

# Check if no matching files
if [ ${#FILES[@]} -eq 0 ] || [ ! -e "${FILES[0]}" ]; then
    echo "No files found with extension $EXTENSION"
    exit 0
fi

# --------- Export variable ----------
export BACKUP_COUNT=0
TOTAL_SIZE=0

echo "Files to be backed up:"
for file in "${FILES[@]}"; do
    size=$(stat -c %s "$file")
    echo "$(basename "$file") - $size bytes"
done

# --------- Backup Process ----------
for file in "${FILES[@]}"; do
    filename=$(basename "$file")
    dest="$BACKUP_DIR/$filename"

    if [ -e "$dest" ]; then
        if [ "$file" -nt "$dest" ]; then
            cp "$file" "$dest"
            BACKUP_COUNT=$((BACKUP_COUNT + 1))
            TOTAL_SIZE=$((TOTAL_SIZE + $(stat -c %s "$file")))
        fi
    else
        cp "$file" "$dest"
        BACKUP_COUNT=$((BACKUP_COUNT + 1))
        TOTAL_SIZE=$((TOTAL_SIZE + $(stat -c %s "$file")))
    fi
done

# --------- Report ----------
REPORT_FILE="$BACKUP_DIR/backup_report.log"

{
    echo "Backup Summary Report"
    echo "----------------------"
    echo "Total files processed: $BACKUP_COUNT"
    echo "Total size backed up: $TOTAL_SIZE bytes"
    echo "Backup directory path: $BACKUP_DIR"
    echo "Backup completed on: $(date)"
} > "$REPORT_FILE"

echo "Backup completed successfully."
echo "Report saved at $REPORT_FILE"
