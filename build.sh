#! /bin/bash

#Log everything in /code/build.log
#logfile=/tmp/build.log
#exec > $logfile 2>&1
#set -x

#Mapping build ARGs
APL_API_TAG=${APL_API_TAG}
APL_COMMON_TAG=${APL_COMMON_TAG}
APL_API_ADMIN_TAG=${APL_API_ADMIN_TAG}
BB_API_KEY=${BB_API_KEY}


#echo "BB_API_KEY= $BB_API_KEY"
echo "APL_COMMON_TAG= $APL_COMMON_TAG"
echo "APL_API_TAG= $APL_API_TAG"
echo "APL_API_ADMIN_TAG=" $APL_API_ADMIN_TAG

#Installing some tools
apt update && apt install -y wget bsdtar openssl libc-dev gcc

#This repo is used for building api and api-admin, based on build vars different code base will be pulled down

#Pulling apl-api repo
if [ ! -z $APL_API_TAG ]
then
  wget https://applariat:$BB_API_KEY@bitbucket.org/applariat/apl-api/get/$APL_API_TAG.zip
  mkdir -p /usr/src/app
  bsdtar -xf $APL_API_TAG.zip -s'|[^/]*/||' -C /usr/src/app
  cd /usr/src/app/
  ls -alh
fi

#Pulling apl-api-admin repo
if [ ! -z $APL_API_ADMIN_TAG ]
then
  wget https://applariat:$BB_API_KEY@bitbucket.org/applariat/apl-admin-api/get/$APL_API_ADMIN_TAG.zip
  mkdir -p /usr/src/app
  bsdtar -xf $APL_API_ADMIN_TAG.zip -s'|[^/]*/||' -C /usr/src/app
  cd /usr/src/app/
  ls -alh
fi


Pulling down and installing apl-common code
pip install . \
    && pip install --upgrade https://applariat:$BB_API_KEY@bitbucket.org/applariat/apl-common/get/${APL_COMMON_TAG}.zip
