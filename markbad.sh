#!/bin/bash
set -x

#level=$1
#ip="192.168.1.18"
ip="192.168.1.26"
#ip="$( ip -4 addr show enp0s9 | grep -oP '(?<=inet\s)\d+(\.\d+){3}' )"


qaFE() {
    level="qa"
    type="fe"
    destip="192.168.1.3" #Send the bundle to this IP
    username="ubuntu"
    password="njit123"
    markbad=`/usr/bin/php markbad.php $level $type`

}


qaBE() {
    level="qa"
    type="be"
    destip="192.168.1.3" #Send the bundle to this IP
    username="ubuntu"
    password="njit123"
    markbad=`/usr/bin/php markbad.php $level $type`
}

prodFE() {
    ip="192.168.1.25"
    level="qa"
    type="fe"
    destip="192.168.1.3" #Send the bundle to this IP
    deployip="192.168.1.3"
    username="ubuntu"
    password="njit123"
    markbad=`/usr/bin/php markbad.php $level $type`

    filename=`/usr/bin/php checkVer.php $ip $level $type`
    filenameFixed="$(echo -e "${filename}" | tr -d '[:space:]')" #Removes whitespace
    echo "$filenameFixed";

    # Create directory if not exists
    /usr/bin/sshpass -p $password ssh root@$destip "mkdir -p /var/www/html/490/490auth_and_website"

    # Delete directory if exists
    /usr/bin/sshpass -p $password ssh root@$destip "rm -rf /var/www/html/490/490auth_and_website/site"

    # Grab bundle and send to production
    /usr/bin/sshpass -p $password scp root@$deployip:/home/$username/bundles/$filenameFixed /home/$username/bundles/.

    /usr/bin/sshpass -p $password ssh root@$destip "tar -xvf /home/$username/bundles/$filenameFixed -C /var/www/html/490/490auth_and_website/"



}

prodBE() {
    ip="192.168.1.26"
    level="qa"
    type="be"
    destip="192.168.1.3" #Send the bundle to this IP
    deployip="192.168.1.3"
    username="ubuntu"
    password="njit123"
    markbad=`/usr/bin/php markbad.php $level $type`

    filename=`/usr/bin/php checkVer.php $ip $level $type`
    filenameFixed="$(echo -e "${filename}" | tr -d '[:space:]')" #Removes whitespace
    echo "$filenameFixed";

    # Create directory if not exists
    /usr/bin/sshpass -p $password ssh root@$destip "mkdir -p /var/www/html/490/490auth_and_website"

    # Delete directory if exists
    /usr/bin/sshpass -p $password ssh root@$destip "rm -rf /var/www/html/490/490auth_and_website/490_authsys"

    # Grab bundle and send to production
    /usr/bin/sshpass -p $password scp root@$deployip:/home/$username/bundles/$filenameFixed /home/$username/bundles/.

    /usr/bin/sshpass -p $password ssh root@$destip "tar -xvf /home/$username/bundles/$filenameFixed -C /var/www/html/490/490auth_and_website/"


}


if [ "$1" == "qa" ]; then
    if [ "$2" == "fe" ]; then
        qaFE
    elif [ "$2" == "be" ]; then
        qaBE
    fi
elif [ "$1" == "prod" ]; then
    if [ "$2" == "fe" ]; then
        prodFE
    elif [ "$2" == "be" ]; then
        prodBE
    fi
fi
