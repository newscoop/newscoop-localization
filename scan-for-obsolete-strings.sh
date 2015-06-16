#!/usr/bin/env bash

# set variables for Newscoop source and translation files

sourcefiles=~/64studio/git/newscoop/
ymlfiles=${sourcefiles}/newscoop/src/Newscoop/NewscoopBundle/Resources/translations/*.en.yml

# delete old output files
rm matchnotfoundfile matchnotfoundreport

# loop through the yml files
for ymlfile in $ymlfiles
do

printf "\n\nExamining $ymlfile...\n"

# read in each line of the file
while read line
do
printf "Line is: $line\n"

# strip the colon and everything following
strippedline=$(echo $line|sed 's/:.*//')
printf "Stripped line is: $strippedline\n"

# grep recursively in the sources for each stripped line from the yml
grep -rl --exclude=*.yml "$strippedline" $sourcefiles

# indicate if a stripped line was found
if [ $? -eq 0 ]; then
    printf "Match found for $strippedline\n\n "

    else

    # indicate if a stripped line was not found
    printf "***Match not found!*** "
    printf "$strippedline\n" | tee -a matchnotfoundfile
    printf "\n"

fi

done < $ymlfile

#close the outer loop
done

# generate a report
printf "\nGenerating a report of strings missing from source...\n"
printf "\nDon't forget to check for false results!\n"

 while read line
 do

 grep -r --include=*.en.yml --exclude=*.yml "$line" $sourcefiles | tee -a matchnotfoundreport

 done < matchnotfoundfile

 # filter false positives
 sed -i "/\\$/d" matchnotfoundreport

# close the whole script
exit 0
