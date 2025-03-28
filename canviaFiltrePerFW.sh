#!/bin/bash

# Limpiar reglas previas
iptables -t mangle -F
ip rule flush

# Definir subredes y marcas
declare -A subX
subX["192.168.2.0/27"]=1
subX["192.168.2.32/27"]=2
subX["192.168.2.64/27"]=3
subX["192.168.2.96/27"]=4
subX["192.168.2.128/27"]=5
subX["192.168.2.160/27"]=6
subX["192.168.2.192/27"]=7

# Definir gateways asociados
declare -A gateways
gateways["192.168.2.0/27"]="192.168.2.1"
gateways["192.168.2.32/27"]="192.168.2.33"
gateways["192.168.2.64/27"]="192.168.2.65"
gateways["192.168.2.96/27"]="192.168.2.97"
gateways["192.168.2.128/27"]="192.168.2.129"
gateways["192.168.2.160/27"]="192.168.2.161"
gateways["192.168.2.192/27"]="192.168.2.193"

# Marcar paquetes según la subred de origen
for subXarxa in "${!subX[@]}"; do
    mark=${subX[$subXarxa]}
    iptables -t mangle -A PREROUTING -s $subXarxa -j MARK --set-mark $mark
done

# Configurar reglas de routing según la marca
for subXarxa in "${!subX[@]}"; do
    mark=${subX[$subXarxa]}
    gateway=${gateways[$subXarxa]}
    
    ip rule add fwmark $mark table $mark
    ip route add default via $gateway table $mark
done
