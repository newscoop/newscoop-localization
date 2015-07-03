#!/usr/bin/env bash

# set variables for Newscoop source and image files

sourcefiles=~/64studio/git/newscoop/
imgfiles=${sourcefiles}newscoop/admin-style/images/custom-theme/

# delete old output file
rm imagesnotfoundfile

# loop through the image files
for imgfile in $( ls ${imgfiles}* | xargs -n 1 basename )
do

printf "\nExamining $imgfile...\n"

# grep recursively in the sources for each image filename, but skip git directory and yml files
grep -rl --exclude-dir=.git --exclude=*.yml $imgfile $sourcefiles

# indicate if an image filename was found or not

if [ $? -eq 0 ]; then

    printf "Match found\n"

elif [ $? -eq 1 ]; then

    printf "Not found\n"
    printf "$imgfile\n" >> imagesnotfoundfile
    rm ${imgfiles}$imgfile
fi

done

# close the whole script
exit 0
