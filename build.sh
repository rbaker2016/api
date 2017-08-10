#! /bin/bash

#Log everything in /code/build.log
#logfile=/tmp/build.log
#exec > $logfile 2>&1
#set -x

#Mapping build ARGs
APL_API_TAG=develop
APL_COMMON_TAG=develop
BB_API_KEY=123456

echo "BB_API_KEY= $BB_API_KEY"

#Installing some tools
apt update && apt install -y wget bsdtar openssl libc-dev gcc

#Pulling apl-api repo
wget https://applariat:$BB_API_KEY@bitbucket.org/applariat/apl-api/get/$APL_API_TAG.zip

mkdir -p /usr/src/app
bsdtar -xf $APL_API_TAG.zip -s'|[^/]*/||' -C /usr/src/app
cd /usr/src/app/
ls -alh

Pulling down and installing apl-common code
pip install . \
    && pip install --upgrade https://applariat:$BB_API_KEY@bitbucket.org/applariat/apl-common/get/${APL_COMMON_TAG}.zip
