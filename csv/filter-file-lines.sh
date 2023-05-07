# Read a CSV file and output only rows containing a given string.
# Usage: filter-csv.sh <file> <string>

# Check for correct number of arguments
if [ $# -ne 2 ]; then
    echo "Usage: filter-csv.sh <file> <string>"
    exit 1
fi

# Check that file exists
if [ ! -f $1 ]; then
    echo "File $1 does not exist."
    exit 1
fi

# Read file line by line
while read line; do
    # Check if line contains string
    if [[ $line == *$2* ]]; then
        echo $line
    fi
done < $1

exit 0
