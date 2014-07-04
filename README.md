newscoop-localization
=====================

Three sets of Bash scripts for making Newscoop localization easier...

1. A pair of scripts generate-po-files.sh and generate-php-files.sh which can convert Newscoop's legacy PHP translation format into GNU gettext .po files and back. 

2. A pair of scripts theme-to-po.sh and po-to-theme.sh for converting Smarty variables in Newscoop theme conf files to gettext .po files and back.

3. A script yaml-to-php.sh for converting Newscoop 4.3 YAML files to Newscoop legacy format. This latter script is useful for backporting current .yml files in the master branch on GitHub to Newscoop 4.2.x production servers.

*Usage*

Edit the script to set GITPATH to the location of the Newscoop source code, set LOCALES to the localizations you are interested in, then run the script. Files will be placed in BUILDPATH which by default is the /tmp directory. Watch the output for any PHP syntax errors (typically due to missing quotes) which should be fixed manually before deployment.

*Convert YAML format to PHP*

To generate the .yml files under Newscoop/newscoop/src/Newscoop/NewscoopBundle/Resources/translations/ mark the strings as 'reviewed' on [Transifex](https://www.transifex.com/projects/p/newscoop/) and they will be automatically committed to the GitHub master branch.

This means that before converting YAML to PHP with yaml-to-php.sh, you will need to do:

`git checkout master`

`git pull`

in your local copy of Newscoop git. After conversion is complete, copy the PHP files to your Newscoop 4.2.x or earlier installation, for example under the /var/lib/newscoop/admin-files/lang/ directory. You can then check the import of the strings was successful in the Localizer page of the admin interface.

*Convert theme conf files to Gettext po and back*

Set the THEME name and LANGUAGE of the source strings when converting to gettext. If converting back to Smarty format, set LANGUAGE to the destination language.

*Convert PHP to Gettext po and back*

If using generate-po-files.sh to convert files under the Newscoop/newscoop/admin-files/lang/ directory in Newscoop 4.2.x git, you will need to do:

`git checkout v4.2`

`git pull`

to sync with the latest strings available. 

The generate-php-files.sh script is for Newscoop 4.2.x, and is meant for use on individual .po files as converted by generate-po-files.sh. It will not work for the .po file that Transifex offers as 'download for use'. This is because Transifex concatenates all the different translation files into a single .po file on export, which is not what Newscoop needs.
