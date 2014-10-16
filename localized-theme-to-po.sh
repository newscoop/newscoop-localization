#!/bin/bash

# Script to generate .po files from localized Newscoop theme conf files.

# Set the name of the theme
THEME=Broadcaster

# Set the temporary directory to use for converting the files
BUILDPATH=/tmp

# Set the path to the Newscoop theme conf files
GITPATH=../theme-${THEME}/_conf/

# Set the locales you wish to convert
LOCALES="ar az da fr hr hu hy_AM it ka ru"

echo "Cleaning up any previous builds..."

rm -rf ${BUILDPATH}/po/

echo "Creating the temporary build directory..."

mkdir -p ${BUILDPATH}/po/

echo "Copying the locale files to the temporary directory..."

cp -r ${GITPATH}strings-*.tpl ${BUILDPATH}/po/

cd ${BUILDPATH}/po/

for LANGUAGE in ${LOCALES}; do

 # Convert the file
 echo "Changing the file to GNU gettext style..."

 # insert an additional hash and space at the beginning of each line
 sed -i 's/^/# /' strings-${LANGUAGE}.tpl

 # insert a linebreak after each line ending with a double quote
 sed -i 's/\(["]\)\s*$/"\n/' strings-${LANGUAGE}.tpl

 # replace equals sign with linebreak and msgstr
 sed -i 's/ = /\nmsgstr /' strings-${LANGUAGE}.tpl

 # insert English msgids
 sed -i '/^# editArticle$/ s:$: msgid "Edit Article":' strings-${LANGUAGE}.tpl
 sed -i '/^# editArticle$/ s:$: msgid "Edit Article":' strings-${LANGUAGE}.tpl
 sed -i '/^# premium$/ s:$: msgid "premium*":' strings-${LANGUAGE}.tpl
 sed -i '/^# comments$/ s:$: msgid "Comment(s)":' strings-${LANGUAGE}.tpl
 sed -i '/^# by$/ s:$: msgid "by":' strings-${LANGUAGE}.tpl
 sed -i '/^# readMore$/ s:$: msgid "Read More":' strings-${LANGUAGE}.tpl
 sed -i '/^# addComment$/ s:$: msgid "Add a Comment":' strings-${LANGUAGE}.tpl
 sed -i '/^# previous$/ s:$: msgid "previous":' strings-${LANGUAGE}.tpl
 sed -i '/^# next$/ s:$: msgid "next":' strings-${LANGUAGE}.tpl
 sed -i '/^# page$/ s:$: msgid "Page":' strings-${LANGUAGE}.tpl
 sed -i '/^# photo$/ s:$: msgid "photo\:":' strings-${LANGUAGE}.tpl
 sed -i '/^# welcome$/ s:$: msgid "Welcome":' strings-${LANGUAGE}.tpl

 sed -i '/^# language$/ s:$: msgid "language\:":' strings-${LANGUAGE}.tpl
 sed -i '/^# MakeYourOwnRadio$/ s:$: msgid "Make Your Own Radio":' strings-${LANGUAGE}.tpl
 sed -i '/^# CallForParticipation$/ s:$: msgid "Call For Participation":' strings-${LANGUAGE}.tpl
 sed -i '/^# Join$/ s:$: msgid "Join Us!":' strings-${LANGUAGE}.tpl

 sed -i '/^# articleGallery$/ s:$: msgid "Article <span>Gallery</span>":' strings-${LANGUAGE}.tpl
 sed -i '/^# storyPlaces$/ s:$: msgid "Story <span>Places</span>":' strings-${LANGUAGE}.tpl
 sed -i '/^# listenAudio$/ s:$: msgid "Listen <span>Audio</span>":' strings-${LANGUAGE}.tpl
 sed -i '/^# downloadAudioFile$/ s:$: msgid "Download audio file":' strings-${LANGUAGE}.tpl
 sed -i '/^# watchVideo$/ s:$: msgid "Watch <span>Video</span>":' strings-${LANGUAGE}.tpl
 sed -i '/^# download$/ s:$: msgid "Download":' strings-${LANGUAGE}.tpl
 sed -i '/^# file$/ s:$: msgid "file":' strings-${LANGUAGE}.tpl
 sed -i '/^# downloadFile$/ s:$: msgid "Download <span>File</span>":' strings-${LANGUAGE}.tpl
 sed -i '/^# fileOfType$/ s:$: msgid "File of type\:":' strings-${LANGUAGE}.tpl
 sed -i '/^# alsoIn$/ s:$: msgid "Also in":' strings-${LANGUAGE}.tpl
 sed -i '/^# relatedStories$/ s:$: msgid "Related <span>Stories</span>":' strings-${LANGUAGE}.tpl

 sed -i '/^# viewProfile$/ s:$: msgid "View Profile":' strings-${LANGUAGE}.tpl

 sed -i '/^# somethingToSay$/ s:$: msgid "Have something to say?":' strings-${LANGUAGE}.tpl
 sed -i '/^# writeComment$/ s:$: msgid "Write a Comment":' strings-${LANGUAGE}.tpl
 sed -i '/^# anonymous$/ s:$: msgid "(Anonymous)":' strings-${LANGUAGE}.tpl
 sed -i '/^# writeAComment$/ s:$: msgid "<span>Write</span> a Comment":' strings-${LANGUAGE}.tpl
 sed -i '/^# commentNotAccepted$/ s:$: msgid "Your comment has not been accepted.":' strings-${LANGUAGE}.tpl
 sed -i '/^# commentSentApproval$/ s:$: msgid "Your comment has been sent for approval.":' strings-${LANGUAGE}.tpl
 sed -i '/^# publish$/ s:$: msgid "Publish":' strings-${LANGUAGE}.tpl
 sed -i '/^# commentsLockedDisabled$/ s:$: msgid "Comments are locked / disabled for this article.":' strings-${LANGUAGE}.tpl
 sed -i '/^# haveToRegister$/ s:$: msgid "You have to be registered in order to comment on articles and send messages directly to the editorial team. Please login or create a free user account.":' strings-${LANGUAGE}.tpl
 sed -i '/^# commentPlaceholder$/ s:$: msgid "Put your comment text here":' strings-${LANGUAGE}.tpl
 sed -i '/^# nicknamePlaceholder$/ s:$: msgid "Your nickname":' strings-${LANGUAGE}.tpl
 sed -i '/^# emailPlaceholder$/ s:$: msgid "Your e-mail":' strings-${LANGUAGE}.tpl

 sed -i '/^# thisArticleIsLocked$/ s:$: msgid "This article is locked and is accessible only to <mark>registered</mark> and <mark>logged in</mark> users, sorry!":' strings-${LANGUAGE}.tpl

 sed -i '/^# articleRating$/ s:$: msgid "<span>Article</span> rating\:":' strings-${LANGUAGE}.tpl
 sed -i '/^# voteData$/ s:$: msgid "vote data":' strings-${LANGUAGE}.tpl
 sed -i '/^# voteS$/ s:$: msgid "vote(s).":' strings-${LANGUAGE}.tpl
 sed -i '/^# averageRating$/ s:$: msgid "Average rating\:":' strings-${LANGUAGE}.tpl

 sed -i '/^# debateVoting$/ s:$: msgid "Debate <span>voting</span>":' strings-${LANGUAGE}.tpl
 sed -i '/^# changeYourMind$/ s:$: msgid "You can change your mind unlimited number of times until the expiration of this debate, if arguments of the other side are more convincing.":' strings-${LANGUAGE}.tpl
 sed -i '/^# debateClosed$/ s:$: msgid "The debate is closed. The end result is decided.":' strings-${LANGUAGE}.tpl
 sed -i '/^# pleaseLoginVote$/ s:$: msgid "Please login to vote.":' strings-${LANGUAGE}.tpl

 sed -i '/^# proArgumentsBy$/ s:$: msgid "Pro arguments by\:":' strings-${LANGUAGE}.tpl
 sed -i '/^# contraArgumentsBy$/ s:$: msgid "Contra arguments by\:":' strings-${LANGUAGE}.tpl

 sed -i '/^# chartsTitle$/ s:$: msgid "Section\: <span>Charts Top 30</span>":' strings-${LANGUAGE}.tpl

 sed -i '/^# poweredBy$/ s:$: msgid "Powered by <a href=\"http://www.sourcefabric.org/en/newscoop/\" target=\"_blank\">Newscoop</a> and <a href=\"http://www.sourcefabric.org/en/airtime/\" target=\"_blank\">Airtime</a>":' strings-${LANGUAGE}.tpl

 sed -i '/^# latestLocations$/ s:$: msgid "Latest locations":' strings-${LANGUAGE}.tpl
 sed -i '/^# hotSpots$/ s:$: msgid "Hot <span>Spots</span>":' strings-${LANGUAGE}.tpl

 sed -i '/^# onAirNow$/ s:$: msgid "On Air Now":' strings-${LANGUAGE}.tpl
 sed -i '/^# aboutUs$/ s:$: msgid "About <span>Us</span>":' strings-${LANGUAGE}.tpl
 sed -i '/^# latestNews$/ s:$: msgid "Latest <span>News</span>":' strings-${LANGUAGE}.tpl

 sed -i '/^# content$/ s:$: msgid "Content":' strings-${LANGUAGE}.tpl
 sed -i '/^# logout$/ s:$: msgid "Logout":' strings-${LANGUAGE}.tpl
 sed -i '/^# login$/ s:$: msgid "Login":' strings-${LANGUAGE}.tpl
 sed -i '/^# followUs$/ s:$: msgid "Follow Us":' strings-${LANGUAGE}.tpl
 sed -i '/^# followAtTwitter$/ s:$: msgid "Follow us on Twitter":' strings-${LANGUAGE}.tpl
 sed -i '/^# likeOnFacebook$/ s:$: msgid "Like us on Facebook":' strings-${LANGUAGE}.tpl
 sed -i '/^# signupRSS$/ s:$: msgid "Sign up to RSS":' strings-${LANGUAGE}.tpl
 sed -i '/^# shareThis$/ s:$: msgid "Share This":' strings-${LANGUAGE}.tpl
 sed -i '/^# tweetOnTwitter$/ s:$: msgid "Tweet this":' strings-${LANGUAGE}.tpl
 sed -i '/^# postToFacebook$/ s:$: msgid "Post to Facebook":' strings-${LANGUAGE}.tpl
 sed -i '/^# shareGooglePlus$/ s:$: msgid "Share on Google+":' strings-${LANGUAGE}.tpl

 sed -i '/^# listenLive$/ s:$: msgid "Listen Live":' strings-${LANGUAGE}.tpl
 sed -i '/^# playNow$/ s:$: msgid "Play Now":' strings-${LANGUAGE}.tpl
 sed -i '/^# current$/ s:$: msgid "Current\:":' strings-${LANGUAGE}.tpl

 sed -i '/^# hostedBy$/ s:$: msgid "Hosted by\:":' strings-${LANGUAGE}.tpl
 sed -i '/^# podcast$/ s:$: msgid "Podcast":' strings-${LANGUAGE}.tpl
 sed -i '/^# show$/ s:$: msgid "Show":' strings-${LANGUAGE}.tpl
 sed -i '/^# archive$/ s:$: msgid "<span>Archive</span>":' strings-${LANGUAGE}.tpl

 sed -i '/^# programGrid$/ s:$: msgid "Program <span>Grid</span>":' strings-${LANGUAGE}.tpl

 sed -i '/^# year$/ s:$: msgid "year":' strings-${LANGUAGE}.tpl
 sed -i '/^# yearS$/ s:$: msgid "years":' strings-${LANGUAGE}.tpl
 sed -i '/^# month$/ s:$: msgid "month":' strings-${LANGUAGE}.tpl
 sed -i '/^# monthS$/ s:$: msgid "months":' strings-${LANGUAGE}.tpl
 sed -i '/^# day$/ s:$: msgid "day":' strings-${LANGUAGE}.tpl
 sed -i '/^# dayS$/ s:$: msgid "days":' strings-${LANGUAGE}.tpl
 sed -i '/^# hours$/ s:$: msgid "h":' strings-${LANGUAGE}.tpl
 sed -i '/^# minutes$/ s:$: msgid "min":' strings-${LANGUAGE}.tpl
 sed -i '/^# seconds$/ s:$: msgid "sec":' strings-${LANGUAGE}.tpl
 sed -i '/^# ago$/ s:$: msgid "ago":' strings-${LANGUAGE}.tpl

 sed -i '/^# searchResults$/ s:$: msgid "Search <span>results</span>":' strings-${LANGUAGE}.tpl
 sed -i '/^# noSearchResults$/ s:$: msgid "No search results were found for your query.":' strings-${LANGUAGE}.tpl

 sed -i '/^# section$/ s:$: msgid "Section\:":' strings-${LANGUAGE}.tpl
 sed -i '/^# moreStories$/ s:$: msgid "More <span>Stories</span>":' strings-${LANGUAGE}.tpl

 sed -i '/^# mostRead$/ s:$: msgid "Most <span>Read</span>":' strings-${LANGUAGE}.tpl
 sed -i '/^# communityFeed$/ s:$: msgid "Community <span>Feed</span>":' strings-${LANGUAGE}.tpl
 sed -i '/^# newCommentOn$/ s:$: msgid "New comment on\:":' strings-${LANGUAGE}.tpl

 sed -i '/^# topic$/ s:$: msgid "Topic\:":' strings-${LANGUAGE}.tpl
 sed -i '/^# moreThisTopic$/ s:$: msgid "More <span>On This Topic</span>":' strings-${LANGUAGE}.tpl

 sed -i '/^# articlesBy$/ s:$: msgid "Articles by":' strings-${LANGUAGE}.tpl

 sed -i '/^# moreVideos$/ s:$: msgid "More <span>Videos</span>":' strings-${LANGUAGE}.tpl

 sed -i '/^# issuesArchive$/ s:$: msgid "Issue <span>Archive</span>":' strings-${LANGUAGE}.tpl

 sed -i '/^# loginFailed$/ s:$: msgid "Login failed":' strings-${LANGUAGE}.tpl
 sed -i '/^# eitherEmailPassword$/ s:$: msgid "Either your email or password is wrong.":' strings-${LANGUAGE}.tpl
 sed -i '/^# tryAgain$/ s:$: msgid "Try again please!":' strings-${LANGUAGE}.tpl
 sed -i '/^# forgotPassword$/ s:$: msgid "Forgot your password?":' strings-${LANGUAGE}.tpl
 sed -i '/^# email$/ s:$: msgid "E-mail":' strings-${LANGUAGE}.tpl
 sed -i '/^# password$/ s:$: msgid "Password":' strings-${LANGUAGE}.tpl
 sed -i '/^# register$/ s:$: msgid "Register":' strings-${LANGUAGE}.tpl

 sed -i '/^# resetPassword$/ s:$: msgid "Reset <span>Password</span>":' strings-${LANGUAGE}.tpl
 sed -i '/^# emailNotCorrect$/ s:$: msgid "E-mail is not correct":' strings-${LANGUAGE}.tpl
 sed -i '/^# maybeRegisteredOn$/ s:$: msgid "Maybe you registered on":' strings-${LANGUAGE}.tpl
 sed -i '/^# withAnotherEmail$/ s:$: msgid "with another e-mail account?":' strings-${LANGUAGE}.tpl
 sed -i '/^# requestNewPassword$/ s:$: msgid "Request new password":' strings-${LANGUAGE}.tpl

 sed -i '/^# userAccount$/ s:$: msgid "User <span>Account</span>":' strings-${LANGUAGE}.tpl
 sed -i '/^# weSentEmail$/ s:$: msgid "We have sent you an e-mail.":' strings-${LANGUAGE}.tpl
 sed -i '/^# pleaseCheckInbox$/ s:$: msgid "Please check your inbox and click on the link in the email to reset your password.":' strings-${LANGUAGE}.tpl

 sed -i '/^# setNewPassword$/ s:$: msgid "Set New <span>Password</span>":' strings-${LANGUAGE}.tpl
 sed -i '/^# passCouldntChange$/ s:$: msgid "Your password could not be changed. Please follow the instructions and try again.":' strings-${LANGUAGE}.tpl
 sed -i '/^# newPassLabel$/ s:$: msgid "New Password":' strings-${LANGUAGE}.tpl
 sed -i '/^# pleaseEnterNewPass$/ s:$: msgid "Please enter your new password \(minimum 6 characters\)":' strings-${LANGUAGE}.tpl
 sed -i '/^# retypePassLabel$/ s:$: msgid "Retype your password":' strings-${LANGUAGE}.tpl
 sed -i '/^# confirmDoesntMatch$/ s:$: msgid "The confirmation of your password does not match your password.":' strings-${LANGUAGE}.tpl
 sed -i '/^# savePassButton$/ s:$: msgid "Save password":' strings-${LANGUAGE}.tpl

 sed -i '/^# mailHello$/ s:$: msgid "Hello,":' strings-${LANGUAGE}.tpl
 sed -i '/^# mailAutomaticalMessage$/ s:$: msgid "This is an automatically generated message from the":' strings-${LANGUAGE}.tpl
 sed -i '/^# mailPleaseConfirm$/ s:$: msgid "Please confirm your e-mail address by clicking on the link below\:":' strings-${LANGUAGE}.tpl
 sed -i '/^# mailOtherwise$/ s:$: msgid "Otherwise, if it wasnt you who submitted this email address for contact, please ignore this email.":' strings-${LANGUAGE}.tpl
 sed -i '/^# mailThanks$/ s:$: msgid "Thanks!":' strings-${LANGUAGE}.tpl

 sed -i '/^# confirmSent$/ s:$: msgid "Confirmation <span>has been sent</span>":' strings-${LANGUAGE}.tpl
 sed -i '/^# followEmailSteps$/ s:$: msgid "Follow the steps you will find in your email.":' strings-${LANGUAGE}.tpl
 sed -i '/^# thanksForRegistering$/ s:$: msgid "Thanks for registering.":' strings-${LANGUAGE}.tpl

 sed -i '/^# pleaseFillData$/ s:$: msgid "Please <span>fill your data</span>":' strings-${LANGUAGE}.tpl

 sed -i '/^# registerTitle$/ s:$: msgid "Register <span> </span>":' strings-${LANGUAGE}.tpl

 sed -i '/^# userPageTitle$/ s:$: msgid "DJs and <span>Editors</span>":' strings-${LANGUAGE}.tpl
 sed -i '/^# inputSearch$/ s:$: msgid "input search":' strings-${LANGUAGE}.tpl
 sed -i '/^# active$/ s:$: msgid "Active":' strings-${LANGUAGE}.tpl
 sed -i '/^# all$/ s:$: msgid "All":' strings-${LANGUAGE}.tpl
 sed -i '/^# editors$/ s:$: msgid "Editors":' strings-${LANGUAGE}.tpl
 sed -i '/^# memberFrom$/ s:$: msgid "member from\:":' strings-${LANGUAGE}.tpl
 sed -i '/^# postsNo$/ s:$: msgid "Number of comments\:":' strings-${LANGUAGE}.tpl
 sed -i '/^# viewFullProfile$/ s:$: msgid "View full profile":' strings-${LANGUAGE}.tpl

 sed -i '/^# userProfile$/ s:$: msgid "User <span>Profile</span>":' strings-${LANGUAGE}.tpl
 sed -i '/^# aboutProfile$/ s:$: msgid "About\:":' strings-${LANGUAGE}.tpl
 sed -i '/^# dateOfBirth$/ s:$: msgid "Date of birth\:":' strings-${LANGUAGE}.tpl
 sed -i '/^# commentsSent$/ s:$: msgid "Comments sent\:":' strings-${LANGUAGE}.tpl
 sed -i '/^# recommComm$/ s:$: msgid "Recommended comments\:":' strings-${LANGUAGE}.tpl
 sed -i '/^# gender$/ s:$: msgid "Gender\:":' strings-${LANGUAGE}.tpl
 sed -i '/^# organisation$/ s:$: msgid "Organisation\:":' strings-${LANGUAGE}.tpl
 sed -i '/^# website$/ s:$: msgid "Website\:":' strings-${LANGUAGE}.tpl

 sed -i '/^# pollTitle$/ s:$: msgid "Voting <span>Poll</span>":' strings-${LANGUAGE}.tpl
 sed -i '/^# thankYouPoll$/ s:$: msgid "Thank you for participating in this poll!":' strings-${LANGUAGE}.tpl
 sed -i '/^# alreadyVoted$/ s:$: msgid "You have already voted":' strings-${LANGUAGE}.tpl
 sed -i '/^# numberOfVotes$/ s:$: msgid "Total number of votes\:":' strings-${LANGUAGE}.tpl
 sed -i '/^# pollButton$/ s:$: msgid "Vote now":' strings-${LANGUAGE}.tpl

 # insert a linebreak before each msgid
 sed -i 's/ msgid /\nmsgid /' strings-${LANGUAGE}.tpl

 # insert a gettext header at the top of the file
 sed -i '1s/# ###/msgid ""\
msgstr ""\
"Project-Id-Version: Newscoop\\n"\
"Content-Type: text\/plain; charset=UTF-8\\n"\
"Content-Transfer-Encoding: 8bit\\n"\
\n# # #/' strings-${LANGUAGE}.tpl

 echo "Giving the file a .po extension..."

 mv strings-${LANGUAGE}.tpl theme-${THEME}-${LANGUAGE}.po

done

echo "Size of the output file is:"

du -h ${BUILDPATH}/po/*
