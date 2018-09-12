#!/bin/sh

chown -R nobody /usr/local/squid/var

echo "Initialize cache if not already done"
if [ "$(ls -A /usr/local/squid/var/cache/squid)" ]; then
     echo "cache folder not empty"
else
    echo "cache folder empty ... Initializing cache"
    /usr/local/squid/sbin/squid $@ -z
    sleep 10
fi



#Start Squid
/usr/local/squid/sbin/squid -N $@
