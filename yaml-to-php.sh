#!/bin/bash

# Script to generate Newscoop 4.2 translations from Newscoop 4.3 .yml files.

# Set the temporary directory to use for converting the files
BUILDPATH=/tmp

# Set the path to the Newscoop localization files
GITPATH=../newscoop/newscoop/src/Newscoop/NewscoopBundle/Resources/translations/

# Set the locales you want to convert
LOCALES="ar az be bn cs da de de_AT el en en_GB es fr he hr hu hy_AM it ka ko ku nb_NO nl pl pt pt_BR ro ru sq sr sr@latin sv tr uk zh zh_TW"

echo "Cleaning up any previous builds..."

rm -rf ${BUILDPATH}/yml/

echo "Copying the files to the temporary directory..."

for localization in ${LOCALES}; do
 mkdir -p ${BUILDPATH}/yml/${localization}
 cp -r ${GITPATH}*${localization}.yml ${BUILDPATH}/yml/${localization}/
done

# Begin function that converts the files

function yaml2php {
  localization=$1

cd ${BUILDPATH}/yml/${localization}/

# Delete the file copies that we don't want

rm plugins_manager.${localization}.yml || true
rm new_comments.${localization}.yml || true
rm templates.${localization}.yml || true
rm universal_list.${localization}.yml || true

# Check that the target files actually exist

FILESPRESENT=$(ls *.${localization}.yml || true)

if [ -n "$FILESPRESENT" ]; then

  echo "Changing the ${localization} files to Newscoop 4.2 style..."

  # fix the format of the system preferences file

  sed -i '/newscoop:/d' system_pref.${localization}.yml
  sed -i '/    btn:/d' system_pref.${localization}.yml
  sed -i "s/        save: /Save: /" system_pref.${localization}.yml
  sed -i '/    preferences:/d' system_pref.${localization}.yml
  sed -i '/        error:/d' system_pref.${localization}.yml
  sed -i "s/            cache: /'Invalid: You need PHP %cache% enabled in order to use the template caching system.': /" system_pref.${localization}.yml
  sed -i "s/            replication: /'Database Replication data incomplete': /" system_pref.${localization}.yml
  sed -i "s/            maxupload: /'Invalid Max Upload File Size value submitted': /" system_pref.${localization}.yml
  sed -i "s/            geolocation: /'Invalid Geolocation fields. Must contain numbers. Latitude can't be > 90 and < -90. Longitude can't be > 180 and < -180.': /" system_pref.${localization}.yml
  sed -i "s/            noaccess: /'You do not have the right to change system preferences.': /" system_pref.${localization}.yml
  sed -i "s/            latitude: /'Latitude field value is not valid.': /" system_pref.${localization}.yml
  sed -i "s/            longitude: /'Longitude field value is not valid.': /" system_pref.${localization}.yml
  sed -i "s/            cacheNotCleared: /'There was error with cache clearing': /" system_pref.${localization}.yml
  sed -i '/        success:/d' system_pref.${localization}.yml
  sed -i "s/            saved: /'System preferences updated.': /" system_pref.${localization}.yml
  sed -i "s/            cacheCleared: /'Cache was cleared': /" system_pref.${localization}.yml
  sed -i '/        menu:/d' system_pref.${localization}.yml
  sed -i "s/            general: /'General Settings': /" system_pref.${localization}.yml
  sed -i "s/            email: /'Email Settings': /" system_pref.${localization}.yml
  sed -i "s/            editor: /'Editor Settings': /" system_pref.${localization}.yml
  sed -i "s/            geolocation: /'Geolocation Settings': /" system_pref.${localization}.yml
  sed -i "s/            fb: /'Facebook Settings': /" system_pref.${localization}.yml
  sed -i "s/            media: /'Video Settings': /" system_pref.${localization}.yml
  sed -i "s/            cache: /'Cache Settings': /" system_pref.${localization}.yml
  sed -i "s/            other: /'Other Settings': /" system_pref.${localization}.yml
  sed -i "s/            recaptcha: /'reCAPTCHA Settings': /" system_pref.${localization}.yml
  sed -i '/        btn:/d' system_pref.${localization}.yml
  sed -i "s/            cleardatabasecache: /'Clear current driver cache': /" system_pref.${localization}.yml
  sed -i '/        label:/d' system_pref.${localization}.yml
  sed -i "s/            title: /'System Preferences': /" system_pref.${localization}.yml
  sed -i "s/            header: /'Preferences': /" system_pref.${localization}.yml
  sed -i "s/            siteonline: /'Site On-Line:': /" system_pref.${localization}.yml
  sed -i "s/            sitetitle: /'Site Title:': /" system_pref.${localization}.yml
  sed -i "s/            metakeywords: /'Site Meta Keywords:': /" system_pref.${localization}.yml
  sed -i "s/            metadescription: /'Site Meta Description:': /" system_pref.${localization}.yml
  sed -i "s/            timezone: /'Time Zone:': /" system_pref.${localization}.yml
  sed -i "s/            cacheengine: /'Database Cache Engine:': /" system_pref.${localization}.yml
  sed -i "s/            cacheenginehost: /'Database Cache Engine Host:': /" system_pref.${localization}.yml
  sed -i "s/            cacheengineport: /'Database Cache Engine Port:': /" system_pref.${localization}.yml
  sed -i "s/            cachetemplate: /'Template Cache Handler:': /" system_pref.${localization}.yml
  sed -i "s/            cacheimage: /'Imagecache Lifetime:': /" system_pref.${localization}.yml
  sed -i "s/            allowrecovery: /'Allow password recovery:': /" system_pref.${localization}.yml
  sed -i "s/            secretkey: /'Secret Key:': /" system_pref.${localization}.yml
  sed -i "s/            sessionlifetime: /'Session Lifetime:': /" system_pref.${localization}.yml
  sed -i "s/            sessionlifetimemsg: /'according to php.ini settings.': /" system_pref.${localization}.yml
  sed -i "s/            separator: /'Keyword separator:': /" system_pref.${localization}.yml
  sed -i "s/            captcha: /'Number of failed login attempts before showing CAPTCHA :': /" system_pref.${localization}.yml
  sed -i "s/            maxupload: /'Maximum upload file size:': /" system_pref.${localization}.yml
  sed -i "s/            maxuploadmsg: /'Enter a value between 0 and %max% (the maximum size is specified in \'php.ini\'). Please use \'K\' for kilobytes, \'M\' for megabytes and \'G\' for gigabytes, without white spaces between the value and the corresponding letter, e.g. \'3M\'.': /" system_pref.${localization}.yml
  sed -i "s/            stats: /'Automatic collection of statistics:': /" system_pref.${localization}.yml
  sed -i "s/            smtphost: /'SMTP Host:': /" system_pref.${localization}.yml
  sed -i "s/            smtpport: /'SMTP Port:': /" system_pref.${localization}.yml
  sed -i "s/            email: /'SMTP Email From address:': /" system_pref.${localization}.yml
  sed -i "s/            emailfrom: /'Email address for notifications from the system:': /" system_pref.${localization}.yml
  sed -i "s/            imageratio: /'Image Resizing Ratio:': /" system_pref.${localization}.yml
  sed -i "s/            imagewidth: /'Image Resizing Width:': /" system_pref.${localization}.yml
  sed -i "s/            imageheight: /'Image Resizing Height:': /" system_pref.${localization}.yml
  sed -i "s/            zoom: /'Zoom enabled for images in article content?': /" system_pref.${localization}.yml
  sed -i "s/            external: /'Reader subscriptions managed externally?': /" system_pref.${localization}.yml
  sed -i "s/            usereplication: /'Setting up a Newscoop Replication Server?': /" system_pref.${localization}.yml
  sed -i "s/            serverdb: /'Newscoop Online Server Database': /" system_pref.${localization}.yml
  sed -i "s/            replicationhost: /'Database Replication Host:': /" system_pref.${localization}.yml
  sed -i "s/            replicationuser: /'Database Replication User:': /" system_pref.${localization}.yml
  sed -i "s/            replicationpw: /'Database Replication Password:': /" system_pref.${localization}.yml
  sed -i "s/            replicationport: /'Database Replication Port:': /" system_pref.${localization}.yml
  sed -i "s/            filter: /'Templates filter mask (separated by comma)': /" system_pref.${localization}.yml
  sed -i "s/            cron: /'Run scheduled tasks externally?': /" system_pref.${localization}.yml
  sed -i "s/            mysqlpath: /'MySQL client command path': /" system_pref.${localization}.yml
  sed -i "s/            mysqlpathmsg: /'to load geo-names data': /" system_pref.${localization}.yml
  sed -i "s/            latitude: /'Map Center Latitude:': /" system_pref.${localization}.yml
  sed -i "s/            longitude: /'Map Center Longitude:': /" system_pref.${localization}.yml
  sed -i "s/            zoomlevel: /'Map Zoom Level:': /" system_pref.${localization}.yml
  sed -i "s/            defaultwidth: /'Map Default Width:': /" system_pref.${localization}.yml
  sed -i "s/            defaultheight: /'Map Default Height:': /" system_pref.${localization}.yml
  sed -i "s/            css: /'Include CSS file for map view': /" system_pref.${localization}.yml
  sed -i "s/            autofocus: /'Map auto-focusing as the default behavior:': /" system_pref.${localization}.yml
  sed -i "s/            zoomautofocus: /'Maximal zoom for auto-focusing:': /" system_pref.${localization}.yml
  sed -i "s/            borderautofocus: /'Map border for auto-focusing:': /" system_pref.${localization}.yml
  sed -i "s/            mapprovider: /'Allow Google Streets Map Provider:': /" system_pref.${localization}.yml
  sed -i "s/            mapquest: /'Allow MapQuest Map Provider:': /" system_pref.${localization}.yml
  sed -i "s/            openstreet: /'Allow OpenStreet Map Provider:': /" system_pref.${localization}.yml
  sed -i "s/            defaultmapprovider: /'Default Map Provider:': /" system_pref.${localization}.yml
  sed -i "s/            nominatimsearch: /'Use MapQuest Nominatim Search:': /" system_pref.${localization}.yml
  sed -i "s/            preflanguage: /'Preferred address language:': /" system_pref.${localization}.yml
  sed -i "s/            markerdir: /'Map Marker Directory:': /" system_pref.${localization}.yml
  sed -i "s/            defaultmarker: /'Map Marker Default:': /" system_pref.${localization}.yml
  sed -i "s/            popupwidth: /'Map Popup Minimal Width:': /" system_pref.${localization}.yml
  sed -i "s/            popupheight: /'Map Popup Minimal Height:': /" system_pref.${localization}.yml
  sed -i "s/            youtubewidth: /'Youtube Default Width:': /" system_pref.${localization}.yml
  sed -i "s/            youtubeheight: /'Youtube Default Height:': /" system_pref.${localization}.yml
  sed -i "s/            vimeowidth: /'Vimeo Default Width:': /" system_pref.${localization}.yml
  sed -i "s/            vimeoheight: /'Vimeo Default Height:': /" system_pref.${localization}.yml
  sed -i "s/            flashwidth: /'Flash Default Width:': /" system_pref.${localization}.yml
  sed -i "s/            flashheight: /'Flash Default Height:': /" system_pref.${localization}.yml
  sed -i "s/            flashserver: /'Local Flash Server:': /" system_pref.${localization}.yml
  sed -i "s/            flashdir: /'Local Flash Directory:': /" system_pref.${localization}.yml
  sed -i "s/            apikey: /'API Key:': /" system_pref.${localization}.yml
  sed -i "s/            appid: /'App ID:': /" system_pref.${localization}.yml
  sed -i "s/            fbsecret: /'App Secret:': /" system_pref.${localization}.yml
  sed -i "s/            recaptchapublickey: /'Public key': /" system_pref.${localization}.yml
  sed -i "s/            recaptchaprivatekey: /'Private key': /" system_pref.${localization}.yml
  sed -i "s/            recaptchasecure: /'Secure url for reCAPTCHA?': /" system_pref.${localization}.yml
  sed -i "s/            disabled: /'disabled': /" system_pref.${localization}.yml
  sed -i "s/            yesoption: /Yes: /" system_pref.${localization}.yml
  sed -i "s/            nooption: /No: /" system_pref.${localization}.yml
  sed -i "s/            geosearch: /'Use Local GeoNames Search:': /" system_pref.${localization}.yml
  sed -i "s/            usergarbage: /'Remove obsolete pending users data?': /" system_pref.${localization}.yml
  sed -i "s/            usergarbagedaysinfo: /'Define a certain number of days after which the pending users will be deleted.': /" system_pref.${localization}.yml
  sed -i "s/            usergarbagedays: /'Days number': /" system_pref.${localization}.yml
  sed -i "s/            smartyUseProtocol: /'Use protocol for absolute URLs generated by Smarty?': /" system_pref.${localization}.yml
  sed -i '/        popover:/d' system_pref.${localization}.yml
  sed -i "s/            cacheengine: /'Enables or disables system cache cache, which can improve Newscoop performance.': /" system_pref.${localization}.yml
  sed -i "s/            cacheenginehost: /'Provide cache host (for Memcache, Memcached or Redis)': /" system_pref.${localization}.yml
  sed -i "s/            cacheengineport: /'Provide cache host port (for Memcache, Memcached or Redis)': /" system_pref.${localization}.yml
  sed -i "s/            cacheimage: /'The time that images will be cached for, from 30 seconds to infinite.': /" system_pref.${localization}.yml
  sed -i "s/            cachetemplate: /'Select DB to enable the cache for templates.': /" system_pref.${localization}.yml
  sed -i "s/            recovery: /'Whether users can get a password reminder by email. Note that if this feature is enabled and your email account is compromised, your Newscoop publication can easily be compromised in turn.': /" system_pref.${localization}.yml
  sed -i "s/            secret: /'The security key that Newscoop can use for integration of web services and other advanced features.': /" system_pref.${localization}.yml
  sed -i "s/            separator: /'Specify the separator for Keywords in the Edit Article page (comma or hyphen).': /" system_pref.${localization}.yml
  sed -i "s/            stats: /'This option enables the collection of statistics on reader access to publications on the server. You may wish to click No if you use a third-party statistical service, as disabling the collection of statistics may reduce the load on your Newscoop server.': /" system_pref.${localization}.yml
  sed -i "s/            zoom: /'If is set to Yes, readers can enlarge article images in your publications pages by clicking on them. This zooming feature works for any images inserted inline with the article text.': /" system_pref.${localization}.yml
  sed -i "s/            ratio: /'The resizing ratio takes precedence over any Resizing Width or Resizing Height value which is set here. If Ratio is not set but both Width and Height are set, then Newscoop will use the value which results in a smaller image size. The default settings here can be overridden by the ratio, width or height settings for a specific inline image set on the Article Edit page.': /" system_pref.${localization}.yml
  sed -i "s/            replication: /'Enables you to set up Newscoop to operate on two servers at once, which is a safety feature in case of hardware or network problems.': /" system_pref.${localization}.yml
  sed -i "s/            filter: /'Enter keywords for templates that you wish to hide from the template editor accessible via the Theme Management page. For example, templates that are no longer in use, but you do not wish to delete from the server.': /" system_pref.${localization}.yml
  sed -i "s/            cron: /'Means to use the servers own cron scheduler for automated tasks, rather than the scheduler included in Newscoop.': /" system_pref.${localization}.yml
  sed -i "s/            video: /'The default width and height of both externally and locally hosted video files can be set in this section, to make sure that the videos are displayed correctly in your publications page templates.': /" system_pref.${localization}.yml
  sed -i "s/            emailfrom: /'The email address used for notifications from the system.': /" system_pref.${localization}.yml
  sed -i '/            recaptcha:/d' system_pref.${localization}.yml
  sed -i "s/                publickey: /'Use this in the JavaScript code that is served to your users.': /" system_pref.${localization}.yml
  sed -i "s/                privatekey: /'Use this when communicating between your server and reCAPTCHA server. Be sure to keep it a secret.': /" system_pref.${localization}.yml
  sed -i "s/                secure: /'If you use secure url for reCAPTCHA choose Yes option.': /" system_pref.${localization}.yml
  sed -i "s/            garbage: /'If enabled, this allows the publisher to define a certain number of days after which the pending users are being deleted. By default 90 days number is set.': /" system_pref.${localization}.yml
  sed -i "s/            lifetime: /'Session lifetime in seconds. Max: 86400 (24 hours). Min: 0 (until the browser is closed).': /" system_pref.${localization}.yml
  sed -i "s/            smartyuseprotocol: /'If enabled, the Smarty function url will create URLs with a protocol. By default this option is disabled to create protocol relative URLs. It is possble to override this behaviour with the useprotocol parameter for the Smarty function and specify a boolean for the desired behaviour.': /" system_pref.${localization}.yml

  # replace the quoted middle colon with a double quoted comma
  sed -i 's/\x27: \x27/\", \"/' *.${localization}.yml

  # replace the left quoted middle colon with a double quoted comma
  sed -i 's/\x27: /\", \"/' *.${localization}.yml

  # replace the right quoted middle colon with a double quoted comma
  sed -i 's/: \x27/\", \"/' *.${localization}.yml

  # replace remaining unquoted colons if the line starts with an alphanumeric character or left bracket (less risky!)
  sed -i '/^[a-zA-Z0-9(]/s/: /\", \"/' *.${localization}.yml

  # remove the leading single quote
  sed -i 's/^\x27//' *.${localization}.yml

  # add php line beginning
  sed -i 's/^/regGS(\"/' *.${localization}.yml

  # remove the trailing single quote
  sed -i 's/\x27$//' *.${localization}.yml

  # add the php line ending
  sed -i 's/$/\");/' *.${localization}.yml

  # strip out nulls
  sed -i 's/\"null\"/\"\"/' *.${localization}.yml

  # add php at the top of the file
  sed -i '1s/^/<?php \n/' *.${localization}.yml

  # strip unused lines

  sed -i '65,107d' api.${localization}.yml

  sed -i '189,223d' users.${localization}.yml

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

  echo " Moving renamed files..."

  mv messages.php globals.php

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

# Workaround for Serbian Latin code change

mv ${BUILDPATH}/yml/sr@latin ${BUILDPATH}/yml/sh

echo "Size of the output files is:"

du -h ${BUILDPATH}/yml/*
