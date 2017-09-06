#!/usr/bin/with-contenv bash
set -eo pipefail
shopt -s nocasematch
if [[ $DEBUG == "true" ]]
 then
	set -x
fi

: ${DISABLE_KEYGEN:="false"}
: ${DISABLE_CONFIG_GEN:="false"}

if [[ $DISABLE_KEYGEN == "false" ]]
 then
	for t in rsa ed25519
	 do
		f="/etc/ssh/keys/ssh_host_${t}_key"
		if [[ ! -f $f ]]
		 then
			ssh-keygen -t $t -f $f -N '' < /dev/null
		fi
	done
fi

if [[ $DISABLE_CONFIG_GEN != "true" ]]
 then
	dockerize -template /app/sshd_config.tmpl > /etc/ssh/sshd_config
fi

