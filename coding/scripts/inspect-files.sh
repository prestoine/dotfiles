#!/bin/bash

# Function to print usage instructions
print_usage() {
    echo "Usage: $0 [-h] file1 file2 ... fileN"
    echo "  or:  $0 [-h] -f filelist.txt"
    echo
    echo "Options:"
    echo "  -h    Show this help message"
    echo "  -f    Read files from a text file (one file path per line)"
    echo
    echo "Example:"
    echo "  $0 src/App.tsx src/main.tsx"
    echo "  $0 -f files-to-inspect.txt"
}

# Process command line arguments
if [ "$1" == "-h" ]; then
    print_usage
    exit 0
fi

if [ "$1" == "-f" ]; then
    if [ -f "$2" ]; then
        # Read files from the provided file
        mapfile -t files < "$2"
    else
        echo "Error: File '$2' not found"
        exit 1
    fi
else
    # Use command line arguments as files
    files=("$@")
fi

# Check if we have any files to process
if [ ${#files[@]} -eq 0 ]; then
    echo "Error: No files specified"
    print_usage
    exit 1
fi

# Process each file
for file in "${files[@]}"; do
    echo -e "\n=== $file ===\n"
    if [ -f "$file" ]; then
        cat "$file"
    else
        echo "File not found"
    fi
done
