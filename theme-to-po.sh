#!/bin/bash

# Script to generate a .po file from a Newscoop theme conf file.

# Set the name of the theme
THEME=Broadcaster

# Set the temporary directory to use for converting the files
BUILDPATH=/tmp

# Set the path to the Newscoop theme conf files
GITPATH=../theme-${THEME}/_conf/

# Set the language which has the master strings
LANGUAGE=English

echo "Cleaning up any previous builds..."

rm -rf ${BUILDPATH}/po/

echo "Creating the temporary build directory..."

mkdir -p ${BUILDPATH}/po/

echo "Copying the file to the temporary directory..."

cp -r ${GITPATH}${LANGUAGE}.tpl ${BUILDPATH}/po/

# Convert the file

cd ${BUILDPATH}/po/

echo "Changing the file to GNU gettext style..."

# insert an additional hash and space at the beginning of each line
sed -i 's/^/# /' ${LANGUAGE}.tpl

# insert a linebreak, msgstr and linebreak after each line ending with a double quote
sed -i 's/\(["]\)\s*$/"\nmsgstr ""\n/' ${LANGUAGE}.tpl

# replace equals signs with linebreak, msgid
sed -i 's/ = /\nmsgid /' ${LANGUAGE}.tpl

# insert a gettext header at the top of the file
sed -i '1s/# ###/msgid ""\
msgstr ""\
"Project-Id-Version: Newscoop\\n"\
"Content-Type: text\/plain; charset=UTF-8\\n"\
"Content-Transfer-Encoding: 8bit\\n"\
\n# # #/' ${LANGUAGE}.tpl

echo "Giving the file a .po extension..."

mv ${LANGUAGE}.tpl theme-${THEME}-${LANGUAGE}.po

echo "Size of the output file is:"

du -h ${BUILDPATH}/po/*
