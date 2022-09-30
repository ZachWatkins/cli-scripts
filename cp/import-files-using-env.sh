#!/bin/bash
# Helps separate files from a project into their own project.
# Path to this running file.
binpath="$( dirname -- "$0"; )";
# Path to this project folder.
rootpath="${binpath}/../"
# Path to directory shared by this project and the source project.
userpath="${rootpath}../../../"
# Import local .env file variables
. .env
# Path to source folder
srcpath="${userpath}${DIRSH}"
# Remove previous copy.
if [ -d src ]
then rm -r src
fi
# Import files from source project to this project.
cp -r "${srcpath}" src
# Replace text in files.
find src/* \( -type d -name .git -prune \) -o -type f -print0 | xargs -0 sed -i -e "s/${PROJECT}/ActualNamespace/g" -e "s/ActualNamespace\\\Src/ActualNamespace/g"
