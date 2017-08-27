#!/usr/bin/with-contenv bash
set -eo pipefail
shopt -s nocasematch

: ${DISABLE_KEYGEN:="false"}
: ${DISABLE_CONFIG_GEN:="false"}

if [[ $DISABLE_KEYGEN == "false" ]]
 then
	for t in rsa dsa ecdsa ed25519
	 do
		f="/etc/ssh/keys/ssh_host_${t}_key"
		if [[ ! -f $f ]]
		 then
			ssh-keygen -t $t -f $f
		fi
	done
fi

if [[ $DISABLE_CONFIG_GEN != "true" ]]
 then
	dockerize -template /app/sshd_config.tmpl > /etc/ssh/sshd_config
fi

