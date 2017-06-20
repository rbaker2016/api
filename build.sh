#! /bin/sh
# appLariats generic Python build script
# Requirements - A valid requirements.txt file exists within the src_dir
# Copies the requirements.txt file from the src_dir and copies it into /usr/src/app/

#Log everything in /src/build.log
logfile=/src/build.log
exec > $logfile 2>&1
set -x

mkdir -p /usr/src/app

#Check for requirements.txt and throw exception if not present
if [ -e /src/requirements.txt ]
then
    cp -rf /src/requirements.txt /usr/src/app/
else
    echo "ERROR! requirements.txt not found"
    exit 1
fi

cp -rf /src/* /usr/src/app/
cd /usr/src/app/

pip install --no-cache-dir -r requirements.txt
