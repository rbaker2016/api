#! /bin/bash
# appLariats generic Python build script
# Requirements - A valid requirements.txt file exists within the code_dir
# Copies the requirements.txt file from the code_dir and copies it into /usr/src/app/

#Log everything in /code/build.log
logfile=/tmp/build.log
exec > $logfile 2>&1
set -x

TAG=develop
APL_COMMON_TAG=develop
TEST=${TEST}

echo $TEST > /test.txt

mkdir -p /usr/src/app
cp -rf /code/* /usr/src/app/
cd /usr/src/app/

#pulling down and installing code
apt update \
    && apt install -y openssl libc-dev gcc \
	&& pip install . \
    && cp -rf /code/* . && pip install .

#cleaning after ourselves
rm -rf /code
