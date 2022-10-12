#!/bin/bash
function fail {
    echo "check_required_column.sh: Error: $1" >&2
	exit 1
}

# Get the first line of the csv file.
column_headers=$(head -n 1 $1)
# Convert the comma-separated line to an array.
IFS=',' read -r -a headers <<< "$column_headers"
# Define required columns used to find missing columns.
required=(KEY VALUE DATE)
required_str=$( IFS=$','; echo "${required[*]}" )
missing=()
# Iterate over each required column.
for requiredcolumn in ${required[@]}; do
  if [[ ! " ${headers[*]} " =~ " ${requiredcolumn} " ]]; then
    missing_columns+=($requiredcolumn)
  fi
done
if [ ${#missing_columns[@]} -eq 0 ]; then
  echo "The file contains all required columns: $required_str"
else
  missing_columns_str=$( IFS=$','; echo "${missing_columns[*]}" )
  fail "The file does not contain these required columns: $missing_columns_str"
fi
