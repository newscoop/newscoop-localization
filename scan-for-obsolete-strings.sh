#!/usr/bin/env bash

# set variables for Newscoop source and translation files

sourcefiles=~/64studio/git/newscoop/
ymlfiles=${sourcefiles}newscoop/src/Newscoop/NewscoopBundle/Resources/translations/*.en.yml

# delete old output files
rm matchnotfoundfile matchnotfoundreport

# loop through the yml files
for ymlfile in $ymlfiles
do

printf "\nExamining $ymlfile...\n"

# read in each line of the file
while read line
do

# strip the single quotes, double or triple dashes, colon and everything following colons
strippedline=$(echo $line|sed s/\'//g|sed s/--//g|sed s/---//g|sed s/:.*//)

# grep recursively in the sources for each stripped line from the yml
grep -rq --exclude=*.yml "$strippedline" $sourcefiles

# indicate if a stripped line was found
if [ $? -eq 1 ]; then

    printf "\nNot found: "
    printf "$strippedline\n" | tee -a matchnotfoundfile

fi

done < $ymlfile

#close the outer loop
done

# generate a report
printf "\nGenerating a report of strings missing from source...\n"
printf "\nDon't forget to check for false results!\n\n"

 while read line
 do

 grep -r --include=*.en.yml --exclude=*.yml "$line" $sourcefiles | tee -a matchnotfoundreport

 done < matchnotfoundfile

# close the whole script
exit 0
