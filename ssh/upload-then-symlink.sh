#!/bin/bash
filepathdata="data/${1}"
today=$(date +"%Y-%m-%d")
# Assuming the new .csv is in ~/Downloads/
echo "Looking for file in ~/Downloads/${1} to move to ./data/${1}"
if [ -f ~/Downloads/$1 ]; then
    cp ~/Downloads/$1 data
elif [ -f data/$1 ]; then
    echo "File not found in ~/Downloads, using existing file in ./data"
else
    echo "File $1 not found in ~/Downloads nor in ./data." >&2
    exit 2
fi
# prepare your local machine for development using latest.json
cd data
echo "Creating a symbolic link between the given file and './data/latest.json'"
if [ -L latest.json ]
then
    rm latest.json
fi
ln -s $1 latest.json
echo "Data updated and symbolic link recreated."
cd ../
# Log the change.
if [ ! -f updates.log ]; then
    touch updates.log
fi
echo "$today $1" >> updates.log
# deploy files to production server
rsync -ruv -e "ssh -F .sshconfig" --exclude-from='.deployignore' ./* production:site/wwwroot > upload-then-symlink.log
echo "File deployed"
