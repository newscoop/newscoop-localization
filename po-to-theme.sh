#!/bin/bash

# Script to generate a Newscoop theme conf file from a .po file.

# Set the name of the theme
THEME=Broadcaster

# Set the temporary directory to use for converting the files
BUILDPATH=/tmp

# Set the path to the Newscoop theme conf files
GITPATH=../theme-${THEME}/_conf/

# Set the language which you want to convert
LANGUAGE=fr

# Convert the file

cd ${BUILDPATH}/po/

echo "Changing the file to Smarty style..."

sed -i '/msgid/d' *_${LANGUAGE}.po

sed -i '/^"/d' *_${LANGUAGE}.po

sed -i 's/^# //' *_${LANGUAGE}.po

sed -i 's/msgstr/ =/' *_${LANGUAGE}.po

# strip the first four lines
sed -i '1,4d' *_${LANGUAGE}.po

sed -i '1s/# # English/###/' *_${LANGUAGE}.po

echo "Renaming the file to have a Smarty extension..."

mv *_${LANGUAGE}.po strings-${LANGUAGE}.tpl

echo "Size of the output file is:"

du -h ${BUILDPATH}/po/*.tpl
