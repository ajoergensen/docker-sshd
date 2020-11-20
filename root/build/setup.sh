#!/bin/bash
set -xeo pipefail

# Install OpenSSH
apk add --no-cache openssh-server openssh-sftp-server 

wget -qO - https://github.com/jwilder/dockerize/releases/download/v0.5.0/dockerize-alpine-linux-amd64-v0.5.0.tar.gz \
	| tar zxvf - -C /usr/local/bin


mkdir /etc/ssh/keys
chmod -v +x /etc/services.d/*/run /etc/cont-init.d/* 
