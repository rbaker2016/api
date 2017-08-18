#! /bin/bash

#Mapping build ARGs
APL_API_TAG=${APL_API_TAG}
APL_COMMON_TAG=${APL_COMMON_TAG}
BB_API_KEY=${BB_API_KEY}
SSH_PASSWD=${SSH_PASSWD}


#Installing some tools
apt update && apt install -y wget bsdtar openssl libc-dev gcc openssh-server supervisor

# clean packages
cp -rf /supervisord.conf /etc/supervisor/conf.d/supervisord.conf
apt clean
rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

#Setting up SSH server
mkdir /var/run/sshd
echo "root:$SSH_PASSWD" | chpasswd
sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd


#Pulling apl-api repo
wget https://applariat:$BB_API_KEY@bitbucket.org/applariat/apl-api/get/$APL_API_TAG.zip

mkdir -p /usr/src/app
bsdtar -xf $APL_API_TAG.zip -s'|[^/]*/||' -C /usr/src/app
cd /usr/src/app/
ls -alh

#Pulling down and installing apl-common code
pip install . \
    && pip install --upgrade https://applariat:$BB_API_KEY@bitbucket.org/applariat/apl-common/get/${APL_COMMON_TAG}.zip
