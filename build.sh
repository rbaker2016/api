#! /bin/bash
# appLariats generic Python build script
# Requirements - A valid requirements.txt file exists within the code_dir
# Copies the requirements.txt file from the code_dir and copies it into /usr/src/app/

#Log everything in /code/build.log
logfile=/code/build.log
exec > $logfile 2>&1
set -x

TAG=${TAG}
APL_COMMON_TAG=${APL_COMMON_TAG}
BB_API_KEY=${BB_API_KEY}

mkdir -p /usr/src/app
cp -rf /code/* /usr/src/app/
cd /usr/src/app/

#pulling down and installing code
apt update \
    && apt install -y openssl libc-dev gcc \
	&& pip install . \
    && pip install --upgrade https://applariat:$BB_API_KEY@bitbucket.org/applariat/apl-common/get/${APL_COMMON_TAG}.zip

#cleaning after ourselves
rm -rf /code
