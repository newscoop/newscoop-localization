#!/bin/bash

# Script to generate .po files from Newscoop translations.

# Set the temporary directory to use for converting the files
BUILDPATH=/tmp

# Set the path to the Newscoop localization files
GITPATH=newscoop/admin-files/lang/

# Set the path to the Newscoop plugins
PLUGINPATH=plugins/

# Set the locales you want to convert
LOCALES="ar be bn cs da de de_AT el en en_GB es fr he hr hu it ka ko ku nl pl pt pt_BR ro ru sh sq sr sv uk zh zh_TW"

# Set the plugins you want to convert
PLUGINS="debate poll recaptcha soundcloud"

echo "Cleaning up any previous builds..."

rm -rf ${BUILDPATH}/po/

echo "Creating the temporary build directory..."

mkdir -p ${BUILDPATH}/po/

echo "Copying the files to the temporary directory..."

for localization in ${LOCALES}; do
cp -r ${GITPATH}${localization} ${BUILDPATH}/po/

 for plugin in ${PLUGINS};
 do cp -r ${PLUGINPATH}${plugin}/admin-files/lang/${localization}/plugin_${plugin}.php ${BUILDPATH}/po/${localization}/;
 done

done

# Begin function that converts the files

function convert2po {
  localization=$1

cd ${BUILDPATH}/po/

echo "Changing the copied ${localization} files to GNU gettext style..."

sed -i 's/<?php /msgid ""\
msgstr ""\
"Project-Id-Version: Newscoop\\n"\
"Content-Type: text\/plain; charset=UTF-8\\n"\
"Content-Transfer-Encoding: 8bit\\n"\
/' ${localization}/*.php
sed -i 's/regGS(/msgid /g' ${localization}/*.php
sed -i 's/", "/"\nmsgstr "/g' ${localization}/*.php
sed -i 's/);/\n/g' ${localization}/*.php
sed -i 's/?>//g' ${localization}/*.php

echo " Giving the ${localization} files the .${localization}.po extension..."

for i in ${localization}/*.php; do mv "$i" "${i/.php}".${localization}.po; done

}

# Run the function for the specified locales

for localization in ${LOCALES}; do
	convert2po ${localization}
done

echo "Size of the output files is:"

du -h ${BUILDPATH}/po/*
