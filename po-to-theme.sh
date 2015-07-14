#!/bin/bash

# Script to generate Newscoop theme conf files from .po files.

# Set the name of the theme
THEME=Broadcaster

# Set the temporary directory to use for converting the files
BUILDPATH=/tmp

# Set the path to the Newscoop theme conf files
GITPATH=~/64studio/git/theme-${THEME}/_conf/

# Set the language which you want to convert
LOCALES="ar az da fr hr hu hy_AM it ka pt ru zh"

# Convert the file

cd ${BUILDPATH}/po/

for LANGUAGE in ${LOCALES}; do

 echo "Changing the ${LANGUAGE} file to Smarty style..."

 # strip lines containing msgid
 sed -i '/msgid/d' *_${LANGUAGE}.po

 # strip lines beginning with double quotes
 sed -i '/^"/d' *_${LANGUAGE}.po

 # remove the first leading hashes
 sed -i 's/^# //' *_${LANGUAGE}.po

 # replace msgstr with equals sign
 sed -i 's/msgstr/ =/' *_${LANGUAGE}.po

 # strip newlines before the equals sign
 sed -i ':a;N;$!ba;s/\n =/ =/g' *_${LANGUAGE}.po

 # delete empty lines
 sed -i '/^$/d' *_${LANGUAGE}.po

 # put a newline before each stanza
 sed -i 's/# /\n# /' *_${LANGUAGE}.po

 # put a newline before each plugin section
 sed -i 's/\[/\n\[/' *_${LANGUAGE}.po

 # strip the first two lines
 sed -i '1,2d' *_${LANGUAGE}.po

 # update the header
 sed -i "s/# # en/### ${LANGUAGE}/" *_${LANGUAGE}.po
 sed -i "s/# # English/### ${LANGUAGE}/" *_${LANGUAGE}.po

 echo "Renaming the ${LANGUAGE} file to have a Smarty extension..."

 mv *_${LANGUAGE}.po strings-${LANGUAGE}.tpl

 echo "Size of the output file is:"

 du -h strings-${LANGUAGE}.tpl

done

 mv *.tpl ${GITPATH}

exit 0
