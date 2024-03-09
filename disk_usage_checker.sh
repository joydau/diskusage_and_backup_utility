#!/bin/bash

#Function usage instructions
usage() {
    echo "Usage: $0 [-d] [-n N] directory"
    echo "options:"
    echo " -d List both directories and files"
    echo " -n N     Return the top N entries (default is 8)"
    exit 1
}


# Parse command line options
while getopts ":dn:" opt; do
    case $opt in 
        d)
            list_all=true
            ;;
        n)
            num_entries=$OPTARG
            ;;
        \?)
            echo "Invalid option: $OPTARG" >&2
            usage
            ;;
        :)
            echo "OPtion -$OPTARG requires an argument." >&2
            usage
            ;;
    esac
done    

#Shift options so that $1 is the directory argument
shift $((OPTIND - 1))

#Check if directory argument is provided
if [ -z "$1" ]; then
    echo "Error: Directory argument is missing"
    usage
fi

#Set default number of entries to 8 if not provided
num_entries=${num_entries:-8}

#Check disk usage
if [ "$list_all" = true]; then
    du -ah "$1" | sort -rh | head -n "$num_entries"
else
    du -h "$1" | sort -rh | head -n "$num_entries"
fi
