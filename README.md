OpenSSH server
==============

Run a confined SSH server inside a Docker container - Made for ssh tunneling or backup apps which uses sftp (like Duplicati)

This container may not be for everybody as I have made a few decisions to suit my needs:

- Requires key based authentication (map a directory containing `.ssh/authorized` keys to `/config`) or setting a password from the environment.
- Either use the host's sshd keys or accept that new host keys will be generated when the container is regenerated (or generate a new, permanent, set of host keys and map them into the container)

### Usage

```docker run --name sshd -p 8022:22 -v /etc/ssh:/etc/ssh:ro -v ./ssh-home:/config ajoergensen/openssh-server```

#### Environment

- `APP_PASSWORD`: Set password for the app user. The variable is removed from inside the container once the password is set but it will be visible to anyone able to run `docker inspect` on the host
- `APP_PASSWORD_CRYPT`: Set password for the app user. Encrypted string. This takes precedence over `APP_PASSWORD`
- `DISABLE_KEYGEN`: To no attempt to generate ssh host keys. If the key(s) already exist they are never overwritten. Defaults to FALSE
- `DISABLE_CONFIG_GEN`: Do not generate sshd_config. Set this if you mount an external sshd_config into the container. Defaults to FALSE
- `SSH_PORT`: Port sshd is listening on. Useful if using `--net host`. Default is 22
- `SSH_PERMIT_ROOT_LOGIN`: Sets `PermitRootLogin`, possible values are `yes`, `no`, `forced-command-only`, `without-password`, `prohibit-password`. Default is `prohibit-password`
- `SSH_AUTHORIZED_KEYS_DIR`: Where sshd will look for the user's authorized_keys. Default is `.ssh/authorized_keys`
- `SSH_GATEWAY_PORTS`: Specifies whether remote hosts are allowed to connect to ports forwarded for the client. Default is no

The rest of the available environment variables are described [here](https://github.com/ajoergensen/baseimage-alpine#environment)

#### Volumes

The app user's $HOME is set to `/config` which is defined as a volume. ssh host keys can be placed in `/etc/ssh/keys`

### Security

As mentioned, the `APP_PASSWORD` variable will expose the app users password to anyone with access to Docker on the host machine. It is recommended to use either `APP_PASSWORD_CRYPT` or key based authentication.
