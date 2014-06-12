#!/bin/bash

# Script to generate Newscoop 4.2 translations from Newscoop 4.3 .yml files.

# Set the temporary directory to use for converting the files
BUILDPATH=/tmp

# Set the path to the Newscoop localization files
GITPATH=../newscoop/newscoop/src/Newscoop/NewscoopBundle/Resources/translations/

# Set the locales you want to convert
LOCALES="ar be bn cs da de de_AT el en en_GB es fr he hr hu it ka ko ku nl pl pt pt_BR ro ru sh sq sr sv uk zh zh_TW"

echo "Cleaning up any previous builds..."

rm -rf ${BUILDPATH}/yml/

echo "Creating the temporary build directory..."

mkdir -p ${BUILDPATH}/yml/

echo "Copying the files to the temporary directory..."

for localization in ${LOCALES}; do
 cp -r ${GITPATH}*${localization}.yml ${BUILDPATH}/yml/
done

cd ${BUILDPATH}/yml/

# Begin function that converts the files

function yaml2php {
  localization=$1

# Check that the target files actually exist

FILESPRESENT=$(ls *.${localization}.yml || true)

if [ -n "$FILESPRESENT" ]; then

  echo "Changing the ${localization} files to Newscoop style..."

  # remove the leading single quote
  sed -i 's/\x27//' *.${localization}.yml

  # add php line beginning
  sed -i 's/^/regGS(\"/' *.${localization}.yml

  # replace the quoted middle colon with a comma
  sed -i 's/\x27: \x27/\", \"/' *.${localization}.yml

  # replace the unquoted middle colon with a comma
  sed -i 's/: /\", \"/' *.${localization}.yml

  # remove the trailing single quote
  sed -i 's/\x27$//' *.${localization}.yml

  # add the php line ending
  sed -i 's/$/\");/' *.${localization}.yml

  # strip out nulls 
  sed -i 's/\"null\"/\"\"/' *.${localization}.yml

  # add php at the top of the file
  sed -i '1s/^/<?php \n/' *.${localization}.yml

  # close the file in php style
  sed -i '$a ?>' *.${localization}.yml

  echo " Stripping the final newline from the file..."

  for i in *.${localization}.yml; do
   awk '{q=p;p=$0}NR>1{print q}END{ORS = ""; print p}' $i > $i.tmp
   rm $i
  done

  echo " Giving the changed files a .php extension..."

  for i in *.${localization}.yml.tmp; do
   mv "$i" "${i/.${localization}.yml.tmp}".php
  done

  echo " Checking the syntax of the php files for errors..."

  for i in *.php; do
   php -l "$i"
  done

else

  echo "The ${localization} files were not found."

fi

}

# Run the function for the specified locales

for localization in ${LOCALES}; do
 yaml2php ${localization}
done

echo "Size of the output files is:"

du -h ${BUILDPATH}/yml/*
