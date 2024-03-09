#!/bin/bash

#Check if the correct number of arguments are provided

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 source_directory destination_directory."
    exit 1
fi

#Check if source directory exists
if [ ! -d "$1" ]; then
    echo "Error: Source directory '$1' not found."
    exit 1
fi

#Create destination directory if it doesn't exist
if [ ! -d "$2" ]; then
    mkdir -p "$2"
fi

#Create a timestamp for the backup
timestamp=$(date +"%Y%m%d_%H%M%S")

#Create the backup tar archive
backup_filename="backup_$timestamp.tar.gz"
tar -czf "$2/$backup_filename" -C "$(dirname "$1")" "$(basename "$1")"

echo "Backup Created: $2/$backup_filename"

