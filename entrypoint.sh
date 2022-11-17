#!/bin/sh

if [ ! -d "/etc/mosdns/rules" ]
then
    mkdir -p /etc/mosdns/rules
    echo "[NOTICE] rules dir inited."
fi

if [ ! -f "/etc/mosdns/config.yaml" ]
then
    cp /root/config.yaml /etc/mosdns
    echo "[NOTICE] config.yaml inited."
fi

if [ ! -f "/etc/mosdns/geoip.dat" ]
then
    cp /root/geoip.dat /etc/mosdns
    echo "[NOTICE] geoip.dat inited."
fi

if [ ! -f "/etc/mosdns/geosite.dat" ]
then
    cp /root/geosite.dat /etc/mosdns
    echo "[NOTICE] geosite.dat inited."
fi

if [ ! -f "/etc/mosdns/rules/custom_hosts.txt" ]
then
    touch /etc/mosdns/rules/custom_hosts.txt
    echo "[NOTICE] custom_hosts.txt inited."
fi

if [ ! -f "/etc/mosdns/rules/custom_local_domain.txt" ]
then
    touch /etc/mosdns/rules/custom_local_domain.txt
    echo "[NOTICE] custom_local_domain.txt inited."
fi

if [ ! -f "/etc/mosdns/rules/custom_remote_domain.txt" ]
then
    touch /etc/mosdns/rules/custom_remote_domain.txt
    echo "[NOTICE] custom_remote_domain.txt inited."
fi

if [ ! -f "/etc/mosdns/rules/custom_blocklist.txt" ]
then
    touch /etc/mosdns/rules/custom_blocklist.txt
    echo "[NOTICE] custom_blocklist.txt inited."
fi

if [ ! -f "/etc/mosdns/rules/custom_redirect.txt" ]
then
    touch /etc/mosdns/rules/custom_redirect.txt
    echo "[NOTICE] custom_redirect.txt inited."
fi

/usr/bin/mosdns start --dir /etc/mosdns  > /etc/mosdns/mosdns.log 2>&1 &
crond && tail -F /etc/mosdns/mosdns.log