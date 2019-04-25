#!/bin/bash
set -x

#level=$1
#ip="192.168.1.18"
ip="192.168.1.20"
#ip="$( ip -4 addr show enp0s9 | grep -oP '(?<=inet\s)\d+(\.\d+){3}' )"


qaFE() {
    level="qa"
    type="fe"
    destip="192.168.1.3" #Send the bundle to this IP
    username="tekken"
    password="njit123"
    markgood=`/usr/bin/php markgood.php $level $type`

}


qaBE() {
    level="qa"
    type="be"
    destip="192.168.1.3" #Send the bundle to this IP
    username="tekken"
    password="njit123"
    markgood=`/usr/bin/php markgood.php $level $type`

}

if [ "$1" == "fe" ]; then
     qaFE
elif [ "$1" == "be" ]; then
     qaBE
fi
