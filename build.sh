#! /bin/sh
# appLariats generic Python build script
# Requirements - A valid requirements.txt file exists within the code_dir
# Copies the requirements.txt file from the code_dir and copies it into /usr/src/app/

#Log everything in /code/build.log
logfile=/code/build.log
exec > $logfile 2>&1
set -x

TAG=${1:-develop}
APL_COMMON_TAG=${2:-develop}
BB_API_KEY=$3

mkdir -p /usr/src/app
cp -rf /code/* /usr/src/app/
cd /usr/src/app/

#pulling down and installing code
apk add --no-cache openssl libc-dev gcc \
	&& pip install . \
    && pip install --upgrade https://applariat:$BB_API_KEY@bitbucket.org/applariat/apl-common/get/${APL_COMMON_TAG}.zip

#cleaning after ourselves
rm -rf /code
