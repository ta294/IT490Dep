#!/bin/bash
set -x

#level=$1
#ip="192.168.1.7"
ip="$( ip -4 addr show enp0s9 | grep -oP '(?<=inet\s)\d+(\.\d+){3}' )"

devFE() {
    level="dev"
    type="fe"
    destip="192.168.1.3" #Send the bundle to this IP
    username="tekken"
    password="njit123"
    version=`/usr/bin/php checkVer.php $ip $level $type`
    versionFixed="$(echo -e "${version}" | tr -d '[:space:]')" #Removes whitespace
    #echo $versionFixed

    # Package the bundle
    FILE="bundles/bundle_dev_fe_$versionFixed.tar"  #this is the .tar file that will be made
    SRCDIR="/var/www/html/490/490auth_and_website"
    #tar -cPzf $FILE $SRCDIR/*
    tar -C $SRCDIR -cPzf $FILE site   #rename site to the folder you want to backup

    #folderVersion=`/usr/bin/php folderVer.php $ip`
    #folderVersionFixed="$(echo -e "${folderVersion}" | tr -d '[:space:]')" #Removes whitespace
    #echo $folderVersionFixed

    # Create directory if not exists
    #/usr/bin/sshpass -p $password ssh root@$deployip "mkdir -p /var/www/html/490/490auth_and_website"

    # Send the bundle 
    /usr/bin/sshpass -p $password scp $FILE $username@$destip:/home/$username/bundles/.
    #/usr/bin/sshpass -p $password scp $FILE root@$deployip:/var/www/html/490auth_and_website_$folderVersionFixed/.

    filename="bundle_dev_fe_$versionFixed.tar"

    #Untar the file so ready for development
    #/usr/bin/sshpass -p $password ssh root@$deployip "tar -xvf /var/www/html/490auth_and_website_$folderVersionFixed/$filename -C /var/www/html/490auth_and_website_$folderVersionFixed/."
    #/usr/bin/sshpass -p $password ssh root@$deployip "tar -xvf /home/$username/bundles/$filename -C /var/www/html/490/490auth_and_website/"

    #Rename the FE folder so it matches version number (DOES NOT WORK FOR BE BECAUSE FILENAME  HARD CODES)
    #/usr/bin/sshpass -p $password ssh root@$deployip "mv /var/www/html/490auth_and_website_$folderVersionFixed/site /var/www/html/490auth_and_website_$folderVersionFixed/site_$versionFixed"

    # Update the MySQL database
    # filename variable from above is also being used here
    updatedb=`/usr/bin/php devUpdate.php $ip $versionFixed $filename`


}


devBE() {
    level="dev"
    type="be"
    destip="192.168.1.3" #Send the bundle to this IP
    username="tekken"
    password="njit123"
    version=`/usr/bin/php checkVer.php $ip $level $type`
    versionFixed="$(echo -e "${version}" | tr -d '[:space:]')" #Removes whitespace
    echo $versionFixed

    # Package the bundle
    FILE="bundles/bundle_dev_be_$versionFixed.tar"  #this is the .tar file that will be made
    SRCDIR="/var/www/html/490/490auth_and_website"
    #tar -cPzf $FILE $SRCDIR/*
    tar -C $SRCDIR -cPzf $FILE 490_authsys   #rename site to the folder you want to backup

    #folderVersion=`/usr/bin/php folderVer.php $ip`
    #folderVersionFixed="$(echo -e "${folderVersion}" | tr -d '[:space:]')" #Removes whitespace

    # Create directory if not exists
    #/usr/bin/sshpass -p $password ssh root@$deployip "mkdir -p /var/www/html/490/490auth_and_website"

    # Send the bundle
    /usr/bin/sshpass -p $password scp $FILE $username@$destip:/home/$username/bundles/.

    filename="bundle_dev_be_$versionFixed.tar"

    # Untar the file 
    #/usr/bin/sshpass -p $password ssh root@$deployip "tar -xvf /var/www/html/490auth_and_website_$folderVersionFixed/$filename -C /var/www/html/490auth_and_website_$folderVersionFixed/."
    #/usr/bin/sshpass -p $password ssh root@$deployip "tar -xvf /home/$username/bundles/$filename -C /var/www/html/490/490auth_and_website/"

    #Rename the FE folder so it matches version number (DOES NOT WORK FOR BE BECAUSE FILENAME  HARD CODES)
    #/usr/bin/sshpass -p $password ssh root@$deployip "mv /var/www/html/490auth_and_website_$folderVersionFixed/490_authsys /var/www/html/490auth_and_website_$folderVersionFixed/490_authsys"
    
    #Update the MySQL database
    updatedb=`/usr/bin/php devUpdate.php $ip $versionFixed $filename`

}


depQAFE() {
    level="dev" # even though this is QA, grab latest of dev
    type="fe"
    sendto="qa"
    destip="192.168.1.4" #Send the bundle to this IP
    username="tekken"
    password="njit123"
    version=`/usr/bin/php checkVerQAPROD.php $ip $level $type $sendto`
    versionFixed="$(echo -e "${version}" | tr -d '[:space:]')" #Removes whitespace
    echo $versionFixed

    FILE="/home/$username/bundles/bundle_dev_fe_$versionFixed.tar"  #this is the .tar file that will be made
    #SRCDIR="~/bunbles/"
    #tar -cPzf $FILE $SRCDIR/*
    # tar -C $SRCDIR -cPzf $FILE site   #rename site to the folder you want to backup

    # Create directory if not exists
    /usr/bin/sshpass -p $password ssh root@$destip "mkdir -p /var/www/html/490/490auth_and_website"

    # Delete directory if exists
    /usr/bin/sshpass -p $password ssh root@$destip "rm -rf /var/www/html/490/490auth_and_website/site"

    # Send the bundle 
    /usr/bin/sshpass -p $password scp $FILE $username@$destip:/home/$username/bundles/.
    #/usr/bin/sshpass -p $password scp $FILE root@$destip:/var/www/html/490auth_and_website/.

    filename="bundle_dev_fe_$versionFixed.tar"

    # Untar the bundle
    #/usr/bin/sshpass -p $password ssh root@$deployip "tar -xvf /var/www/html/490auth_and_website_$folderVersionFixed/$filename -C /var/www/html/490auth_and_website_$folderVersionFixed/."
    /usr/bin/sshpass -p $password ssh root@$destip "tar -xvf /home/$username/bundles/$filename -C /var/www/html/490/490auth_and_website/"

    #Rename the FE folder so it matches version number (DOES NOT WORK FOR BE BECAUSE FILENAME  HARD CODES)
    #/usr/bin/sshpass -p $password ssh root@$deployip "mv /var/www/html/490auth_and_website_$folderVersionFixed/site /var/www/html/490auth_and_website_$folderVersionFixed/site_$versionFixed"

    # Update the MySQL database
    # filename variable from above is also being used here
    updatedb=`/usr/bin/php devUpdateQAPROD.php $ip $versionFixed $filename $type $sendto`



}


depQABE() {
    level="dev" # even though this is QA, grab latest of dev
    type="be"
    sendto="qa"
    destip="192.168.1.4" #Send the bundle to this IP
    username="tekken"
    password="njit123"
    version=`/usr/bin/php checkVerQAPROD.php $ip $level $type $sendto`
    versionFixed="$(echo -e "${version}" | tr -d '[:space:]')" #Removes whitespace
    echo $versionFixed

    FILE="/home/$username/bundles/bundle_dev_be_$versionFixed.tar"  #this is the .tar file that will be made
    #SRCDIR="~/bunbles/"
    #tar -cPzf $FILE $SRCDIR/*
    # tar -C $SRCDIR -cPzf $FILE site   #rename site to the folder you want to backup

    # Create directory if not exists
    /usr/bin/sshpass -p $password ssh root@$destip "mkdir -p /var/www/html/490/490auth_and_website"

    # Delete directory if exists
    /usr/bin/sshpass -p $password ssh root@$destip "rm -rf /var/www/html/490/490auth_and_website/490_authsys"

    # Send the bundle 
    /usr/bin/sshpass -p $password scp $FILE $username@$destip:/home/$username/bundles/.
    #/usr/bin/sshpass -p $password scp $FILE root@$destip:/var/www/html/490auth_and_website/.

    filename="bundle_dev_be_$versionFixed.tar"

    # Untar the bundle
    #/usr/bin/sshpass -p $password ssh root@$deployip "tar -xvf /var/www/html/490auth_and_website_$folderVersionFixed/$filename -C /var/www/html/490auth_and_website_$folderVersionFixed/."
    /usr/bin/sshpass -p $password ssh root@$destip "tar -xvf /home/$username/bundles/$filename -C /var/www/html/490/490auth_and_website/"

    #Rename the FE folder so it matches version number (DOES NOT WORK FOR BE BECAUSE FILENAME  HARD CODES)
    #/usr/bin/sshpass -p $password ssh root@$deployip "mv /var/www/html/490auth_and_website_$folderVersionFixed/site /var/www/html/490auth_and_website_$folderVersionFixed/site_$versionFixed"

    # Set permissions of log files
    /usr/bin/sshpass -p $password ssh root@$destip "chown -R www-data:www-data /var/www/html/490/490auth_and_website/490_authsys/*.log"

    # Update the MySQL database
    # filename variable from above is also being used here
    updatedb=`/usr/bin/php devUpdateQAPROD.php $ip $versionFixed $filename $type $sendto`



}


depPRODFE() {
    level="qa" # Grab the latest version of qa because prod row hasn't been made yet
    type="fe"
    sendto="prod"
    destip="192.168.1.5" #Send the bundle to this IP
    username="tekken"
    password="njit123"
    version=`/usr/bin/php checkVerQAPROD.php $ip $level $type $sendto`
    versionFixed="$(echo -e "${version}" | tr -d '[:space:]')" #Removes whitespace
    echo $versionFixed

    FILE="/home/$username/bundles/bundle_dev_fe_$versionFixed.tar"  #this is the .tar file that will be made
    #SRCDIR="~/bunbles/"
    #tar -cPzf $FILE $SRCDIR/*
    # tar -C $SRCDIR -cPzf $FILE site   #rename site to the folder you want to backup

    # Create directory if not exists
    /usr/bin/sshpass -p $password ssh root@$destip "mkdir -p /var/www/html/490/490auth_and_website"

    # Delete directory if exists
    /usr/bin/sshpass -p $password ssh root@$destip "rm -rf /var/www/html/490/490auth_and_website/site"

    # Send the bundle 
    /usr/bin/sshpass -p $password scp $FILE $username@$destip:/home/$username/bundles/.
    #/usr/bin/sshpass -p $password scp $FILE root@$destip:/var/www/html/490auth_and_website/.

    filename="bundle_dev_fe_$versionFixed.tar"

    # Untar the bundle
    #/usr/bin/sshpass -p $password ssh root@$deployip "tar -xvf /var/www/html/490auth_and_website_$folderVersionFixed/$filename -C /var/www/html/490auth_and_website_$folderVersionFixed/."
    /usr/bin/sshpass -p $password ssh root@$destip "tar -xvf /home/$username/bundles/$filename -C /var/www/html/490/490auth_and_website/"

    #Rename the FE folder so it matches version number (DOES NOT WORK FOR BE BECAUSE FILENAME  HARD CODES)
    #/usr/bin/sshpass -p $password ssh root@$deployip "mv /var/www/html/490auth_and_website_$folderVersionFixed/site /var/www/html/490auth_and_website_$folderVersionFixed/site_$versionFixed"

    # Update the MySQL database
    # filename variable from above is also being used here
    updatedb=`/usr/bin/php devUpdateQAPROD.php $ip $versionFixed $filename $type $sendto`

}

depPRODBE() {
    level="qa" # Grab the latest version of qa because prod row hasn't been made yet
    type="be"
    sendto="prod"
    destip="192.168.1.10" #Send the bundle to this IP
    username="tekken"
    password="njit123"
    version=`/usr/bin/php checkVerQAPROD.php $ip $level $type $sendto`
    versionFixed="$(echo -e "${version}" | tr -d '[:space:]')" #Removes whitespace
    echo $versionFixed

    FILE="/home/$username/bundles/bundle_dev_be_$versionFixed.tar"  #this is the .tar file that will be made
    #SRCDIR="~/bunbles/"
    #tar -cPzf $FILE $SRCDIR/*
    # tar -C $SRCDIR -cPzf $FILE site   #rename site to the folder you want to backup

    # Create directory if not exists
    /usr/bin/sshpass -p $password ssh root@$destip "mkdir -p /var/www/html/490/490auth_and_website"

    # Delete directory if exists
    /usr/bin/sshpass -p $password ssh root@$destip "rm -rf /var/www/html/490/490auth_and_website/490_authsys"

    # Send the bundle 
    /usr/bin/sshpass -p $password scp $FILE $username@$destip:/home/$username/bundles/.
    #/usr/bin/sshpass -p $password scp $FILE root@$destip:/var/www/html/490auth_and_website/.

    filename="bundle_dev_be_$versionFixed.tar"

    # Untar the bundle
    #/usr/bin/sshpass -p $password ssh root@$deployip "tar -xvf /var/www/html/490auth_and_website_$folderVersionFixed/$filename -C /var/www/html/490auth_and_website_$folderVersionFixed/."
    /usr/bin/sshpass -p $password ssh root@$destip "tar -xvf /home/$username/bundles/$filename -C /var/www/html/490/490auth_and_website/"

    #Rename the FE folder so it matches version number (DOES NOT WORK FOR BE BECAUSE FILENAME  HARD CODES)
    #/usr/bin/sshpass -p $password ssh root@$deployip "mv /var/www/html/490auth_and_website_$folderVersionFixed/site /var/www/html/490auth_and_website_$folderVersionFixed/site_$versionFixed"

    # Set permissions of log files
    /usr/bin/sshpass -p $password ssh root@$destip "chown -R www-data:www-data /var/www/html/490/490auth_and_website/490_authsys/*.log"


    # Update the MySQL database
    # filename variable from above is also being used here
    updatedb=`/usr/bin/php devUpdateQAPROD.php $ip $versionFixed $filename $type $sendto`

}

# Deploy Server is 192.168.1.3
if [ "$ip" == "192.168.1.6" ]; then
        echo "The IP is 192168.1.6 - dev FE"
	devFE
elif [ "$ip" == "192.168.1.7" ]; then
        echo "The IP is 192.168.1.7 - dev BE"
	devBE
elif [ "$ip" == "192.168.1.3" ]; then
	echo "The IP is 192.168.1.3 - Deploy Server"
        if [ "$1" == "qa" ]; then
           if [ "$2" == "fe" ]; then
		depQAFE
	   elif [ "$2" == "be" ]; then
		depQABE
	   fi
	elif [ "$1" == "prod" ]; then
	   if [ "$2" == "fe" ]; then
		depPRODFE
	   elif [ "$2" == "be" ]; then
		depPRODBE
	   fi
        fi
fi
