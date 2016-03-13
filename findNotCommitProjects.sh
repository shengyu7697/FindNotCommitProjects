#!/bin/bash

#Black        0;30     Dark Gray     1;30
#Red          0;31     Light Red     1;31
#Green        0;32     Light Green   1;32
#Brown/Orange 0;33     Yellow        1;33
#Blue         0;34     Light Blue    1;34
#Purple       0;35     Light Purple  1;35
#Cyan         0;36     Light Cyan    1;36
#Light Gray   0;37     White         1;37

RED='\033[0;31m'
NC='\033[0m' # No Color
function showGitModified()
{
    RESULT=$(git ls --modified)
    if [ "$RESULT" != "" ]; then
        echo -e "$RED""$RESULT""$NC"
    fi
}

function showGitOthers()
{
    RESULT=$(git ls --others)
    if [ "$RESULT" != "" ]; then
        echo -e "$RED""$RESULT""$NC"
    fi
}

if [ "$1" == "" ]; then
    echo "Usage: $0 path"
    exit
fi

find "$1" -name ".git" > /tmp/gitproject.txt

while read line
do
    FILEPATH=$(echo "$line" | sed "s/\.git//g") # osx
    echo "cd $FILEPATH"
    cd "$FILEPATH" && showGitModified && cd - > /dev/null
    #cd "$FILEPATH" && showGitOthers && cd - > /dev/null
done < /tmp/gitproject.txt
rm -rf /tmp/gitproject.txt
