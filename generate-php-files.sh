#!/bin/bash

# Script to generate Newscoop translations from .po files.

# Set the temporary directory to use for converting the files
BUILDPATH=/tmp

# Set the locales you want to convert
LOCALES="ar be bn cs da de de_AT el en en_GB es fr he hr hu it ka ko ku nl pl pt pt_BR ro ru sh sq sr sv uk zh zh_TW"

cd ${BUILDPATH}/po/

# Begin function that converts the files

function convert2php {
  localization=$1

# Check that the target directory actually exists

if [ -d ${localization} ]; then

  echo "Changing the ${localization} files to Newscoop style..."

  sed -i '1s/msgid ""/<?php /' ${localization}/*.po
  sed -i '2s/msgstr ""//' ${localization}/*.po
  sed -i 's/"Project-Id-Version: Newscoop\\n\"//' ${localization}/*.po
  sed -i 's/"Content-Type: text\/plain; charset=UTF-8\\n"//' ${localization}/*.po
  sed -i 's/"Content-Transfer-Encoding: 8bit\\n"//' ${localization}/*.po

  sed -i ':q;N;s/\n/ /g;t q' ${localization}/*.po
  sed -i 's/ msgid "/\nregGS("/g' ${localization}/*.po
  sed -i 's/ msgstr "/, "/g' ${localization}/*.po
  sed -i '/<?php/!s/[ ]*$/);/g' ${localization}/*.po
  sed -i '$ a\?>' ${localization}/*.po

  echo " Stripping the final newline from the file..."

  for i in ${localization}/*.po; do
   awk '{q=p;p=$0}NR>1{print q}END{ORS = ""; print p}' $i > $i.tmp
   rm $i
  done

  echo " Giving the changed files a .php extension..."

  for i in ${localization}/*.${localization}.po.tmp; do
   mv "$i" "${i/.${localization}.po.tmp}".php
  done

  echo " Checking the syntax of the php files for errors..."

  for i in ${localization}/*.php; do
   php -l "$i"
  done

else

  echo "The ${localization} directory was not found."

fi

}

# Run the function for the specified locales

for localization in ${LOCALES}; do
 convert2php ${localization}
done

echo "Size of the output files is:"

du -h ${BUILDPATH}/po/*
