
#! /bin/sh

do_start () {

PUID=${PUID:-911}
PGID=${PGID:-911}

if [ ! "$(id -u abc)" -eq "$PUID" ]; then usermod -o -u "$PUID" abc ; fi
if [ ! "$(id -g abc)" -eq "$PGID" ]; then groupmod -o -g "$PGID" abc ; fi

echo "
-------------------------------------
          _     _ _
         | |___| (_) ___
         | / __| | |/ _ \
         | \__ \ | | (_) |
         |_|___/ |_|\___/
               |_|

Brought to you by linuxserver.io
We do accept donations at:
https://www.linuxserver.io/donations
-------------------------------------
GID/UID
-------------------------------------
User uid:    $(id -u abc)
User gid:    $(id -g abc)
-------------------------------------
"
chown abc:abc /app
chown abc:abc /config
chown abc:abc /defaults
}

case "$1" in
  start|"")
        do_start
        ;;
  restart|reload|force-reload)
        echo "Error: argument '$1' not supported" >&2
        exit 3
        ;;
  stop)
        # No-op
        ;;
  status)
        # No-op
        ;;
  *)
        echo "Usage: wiuwiu.sh [start]" >&2
        exit 3
        ;;
esac

:
