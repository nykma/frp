#!/bin/sh

if [ ! -f config/frps.ini ]; then
    echo "config/frps.ini not detected! Abort."
    exit 1
fi

if grep -q "FRP_TOKEN" config/frps.ini; then
    token=$([ -z "$FRP_TOKEN" ] && pwgen -n1 128 || echo "$FRP_TOKEN")
    [ -z "$FRP_TOKEN" ] && echo "FRP_TOKEN not found in ENV. Generated one." || echo "FRP_TOKEN found in ENV"

    sed -i "s/FRP_TOKEN/$token/" config/frps.ini
    echo "Token set in config/frps.ini"
else
    echo "token already set in config/frps.ini. Keep it."
fi

/frp/frps -c /frp/config/frps.ini
