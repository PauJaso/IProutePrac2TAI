#!/bin/bash

sudo/proc/sys/net/ipv4/ip_forward 

interfaces=("eth2" "eth3" "eth4" "eth5" "eth6" "eth7" "eth8")
subX=("192.168.2.1/27" "192.168.2.33/27" "192.168.2.65/27" "192.168.2.97/27"
      "192.168.2.129/27" "192.168.2.161/27" "192.168.2.193/27")

for i in "${!interfaces[@]}"; do
    ip addr add ${subX[$i]} dev ${interfaces[$i]}
    ip link set ${interfaces[$i]} up
done
