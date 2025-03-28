#!/bin/bash

subX=$1

case $subX in
    "192.168.2.0/27")
        ip_host="192.168.2.2"
        gateway="192.168.2.1"
        ;;
    "192.168.2.32/27")
        ip_host="192.168.2.34"
        gateway="192.168.2.33"
        ;;
    "192.168.2.64/27")
        ip_host="192.168.2.66"
        gateway="192.168.2.65"
        ;;
    "192.168.2.96/27")
        ip_host="192.168.2.98"
        gateway="192.168.2.97"
        ;;
    "192.168.2.128/27")
        ip_host="192.168.2.130"
        gateway="192.168.2.129"
        ;;
    "192.168.2.160/27")
        ip_host="192.168.2.162"
        gateway="192.168.2.161"
        ;;
    "192.168.2.192/27")
        ip_host="192.168.2.194"
        gateway="192.168.2.193"
        ;;

    *)
        echo "❌ Error: Subxarxa no reconeguda!"
        exit 1
        ;;
esac

ip addr add $ip_host/27 dev eth0
ip link set eth0 up

ip route add default via $gateway dev eth0

