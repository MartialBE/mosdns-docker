#!/bin/sh

TMP_GEOIP="geoip_$RANDOM.dat"
TMP_GEOSITE="geosite_$RANDOM.dat"

wget -q $GEOIP -O /etc/mosdns/$TMP_GEOIP.dat
if [ $? -eq 0 ];then
    mv /etc/mosdns/$TMP_GEOIP.dat /etc/mosdns/geoip.dat
    echo "[NOTICE] update geoip.dat successfully!"
else
    rm -f /etc/mosdns/$TMP_GEOIP.dat 
    echo "[NOTICE] update geoip.dat failed! please check your network!"
fi

wget -q $GEOSITE -O /etc/mosdns/$TMP_GEOSITE.dat
if [ $? -eq 0 ];then
    mv /etc/mosdns/$TMP_GEOSITE.dat /etc/mosdns/geosite.dat
    echo "[NOTICE] update geosite.dat successfully!"
else
    rm -f /etc/mosdns/$TMP_GEOSITE.dat
    echo "[NOTICE] update geosite.dat failed! please check your network!"
fi