# <span style="color: red;">DEPRECATED - CURRENTLY NOT WORKING!</span>

## Opcional - pre-install for "VirtualBox Guest Additions"

    /bin/sudo yum -y groupinstall "Development Tools"
    /bin/sudo mkdir -p /media/cdrom/
    /bin/sudo mount /dev/cdrom /media/cdrom/
    /bin/sudo KERN_DIR=/usr/src/kernels/3.??.?-???.??.?.???.x86_64/ sh /media/cdrom/VBoxLinuxAdditions.run

## Start menu

    /bin/sudo yum -y -q install git
    /bin/sudo rm -Rf wl_lemp_lamp
    git clone -b master https://WalterLuis@bitbucket.org/WalterLuis/wl_lemp_lamp.git

    /bin/sudo chmod 777 wl_lemp_lamp/*
    /bin/sudo sh wl_lemp_lamp/menu.sh

## Permission apache

    /bin/sudo chown -hR apache:apache /var/www/*

## <<<<< NOTES >>>>>

### RPM: Install

    /bin/sudo rpm -ivh --replacepkgs <url_from: https://www.rpmfind.net>

### RPM: Unistall

    rpm -qa | grep -i <package name>
    rpm -e <package name>

### dual ethernet

    route add default gw 192.168.xxx.1 enp0s3 #ip router
    route del default gw 192.168.xxx.1        #ip virtualbox host-only
