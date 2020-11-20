#!/usr/bin/with-contenv bash
set -eo pipefail 

chown -R app:app /config
usermod -d /config -s /bin/bash app

if [[ -n $APP_PASSWORD_CRYPT ]]
 then
	echo "app:$APP_PASSWORD_CRYPT" | chpasswd -e 
elif [[ -n $APP_PASSWORD ]]
 then
	echo "app:$APP_PASSWORD" | chpasswd -c SHA512 
else
	passwd -d app
fi
