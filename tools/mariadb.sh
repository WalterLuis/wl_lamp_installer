#!/bin/bash

printf "%(%H:%M:%S - Entrando en: $BASH_SOURCE)T\n" -1

SCRIPT_DIR="${1}"
if [[ -z "${SCRIPT_DIR}" ]]; then
  SCRIPT_DIR="$(/bin/cat /root/wl_lemp_lamp/globalVariable/SCRIPT_DIR.txt)"
  if [[ -z "${SCRIPT_DIR}" ]]; then
    /bin/echo "ERROR CRITIC $BASH_SOURCE: SCRIPT_DIR - empty"
    exit 1
    return 1
  fi
fi

/bin/echo ""
/bin/echo "######################################################################################"
/bin/echo "###### MariaDB"
/bin/echo "######################################################################################"

select yn in "MariaDB104" "MariaDB103" "EXIT"; do
  case $yn in
  MariaDB104)
    /bin/echo "working..."
    /bin/sudo /bin/echo "MariaDB104" >${SCRIPT_DIR}/globalVariable/MARIADB_VERSION.txt
    break
    ;;
  MariaDB103)
    /bin/echo "working..."
    /bin/sudo /bin/echo "MariaDB103" >${SCRIPT_DIR}/globalVariable/MARIADB_VERSION.txt
    break
    ;;
  EXIT)
    exit 1
    return 1
    break
    ;;
  esac
done

if rpm -qa | grep -q "MariaDB-server"; then
  /bin/sudo /bin/yum -y -q --skip-broken remove MariaDB* >/dev/null 2>&1
  /bin/sudo /bin/rm -Rf /etc/php* >>${SCRIPT_DIR}/debug.log
fi

/bin/sudo /bin/sh ${SCRIPT_DIR}/include/mariadb.sh "${SCRIPT_DIR}"

/bin/sudo /bin/systemctl stop httpd.service
/bin/sudo /bin/systemctl start httpd.service

mysql_secure_installation

#'/usr/bin/mysqladmin' -u root password 'new-password'
#'/usr/bin/mysqladmin' -u root -h localhost.localdomain password 'new-password'

# Accesible desde fuera
# create user 'root'@'%' identified by 'Passw0rd' ;
# grant all privileges on *.* to 'root'@'%' identified by 'Passw0rd' ;
# flush privileges ;
