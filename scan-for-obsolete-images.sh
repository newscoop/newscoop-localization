#!/usr/bin/env bash

# set path to Newscoop source files
sourcefiles=~/64studio/git/newscoop/

# delete old output file
rm imagesnotfoundfile

# loop through the image files
for imgpath in $( find $sourcefiles -type f \( -name "*.png" -or -name "*.jpg" -or -name "*.gif" -or -name "*.pdf" \) )
do

printf "\nExamining $imgpath...\n"

# get the image filename without the full path
imgfile=$( echo $imgpath | xargs -n 1 basename )

# grep recursively in the sources for each image filename, but skip git directory and yml files
grep -rl --exclude-dir=.git --exclude=*.yml $imgfile $sourcefiles

# indicate if an image filename was found

if [ $? -eq 0 ]; then

    printf "Match found\n"

# if not found, delete the full path to that image

elif [ $? -eq 1 ]; then

    printf "Not found\n"
    printf "$imgpath\n" >> imagesnotfoundfile
    rm $imgpath
fi

done

# close the whole script
exit 0
