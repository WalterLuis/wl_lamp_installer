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
MARIADB_VERSION="$(/bin/cat ${SCRIPT_DIR}/globalVariable/MARIADB_VERSION.txt)"
if [[ -z "${MARIADB_VERSION}" ]]; then
  /bin/sudo /bin/echo "MariaDB104" > ${SCRIPT_DIR}/globalVariable/MARIADB_VERSION.txt
  MARIADB_VERSION="$(/bin/cat ${SCRIPT_DIR}/globalVariable/MARIADB_VERSION.txt)"
fi

case ${PHP_VERSION} in
  "MariaDB105")
    if [ ! -f /etc/yum.repos.d/MariaDB.repo ]; then
      /bin/sudo /bin/echo "[mariadb]" > /etc/yum.repos.d/MariaDB.repo
      /bin/sudo /bin/echo "name=MariaDB" >> /etc/yum.repos.d/MariaDB.repo
      /bin/sudo /bin/echo "baseurl=http://yum.mariadb.org/10.5/centos7-amd64" >> /etc/yum.repos.d/MariaDB.repo
      /bin/sudo /bin/echo "gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB" >> /etc/yum.repos.d/MariaDB.repo
      /bin/sudo /bin/echo "gpgcheck=1" >> /etc/yum.repos.d/MariaDB.repo
      /bin/sudo /bin/echo "" >> /etc/yum.repos.d/MariaDB.repo
    else
      /bin/sudo /bin/sed -i 's/ = /=/g' /etc/yum.repos.d/MariaDB.repo
      /bin/sudo /bin/sed -i 's/ =/=/g' /etc/yum.repos.d/MariaDB.repo
      /bin/sudo /bin/sed -i 's/= /=/g' /etc/yum.repos.d/MariaDB.repo
      /bin/sudo /bin/sed -i 's/baseurl.*/baseurl=http:\/\/yum.mariadb.org\/10.5\/centos7-amd64/g' /etc/yum.repos.d/MariaDB.repo
    fi
    /bin/sudo /bin/yum -y -q --skip-broken install MariaDB-server MariaDB-client > /dev/null 2>&1
    if ! rpm -qa | grep -q "MariaDB-server"; then
      /bin/echo "'MariaDB-server' is required, check your connection from port 443"
      exit 1
      return 1
    fi
  ;;
  "MariaDB104")
    if [ ! -f /etc/yum.repos.d/MariaDB.repo ]; then
      /bin/sudo /bin/echo "[mariadb]" > /etc/yum.repos.d/MariaDB.repo
      /bin/sudo /bin/echo "name=MariaDB" >> /etc/yum.repos.d/MariaDB.repo
      /bin/sudo /bin/echo "baseurl=http://yum.mariadb.org/10.4/centos7-amd64" >> /etc/yum.repos.d/MariaDB.repo
      /bin/sudo /bin/echo "gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB" >> /etc/yum.repos.d/MariaDB.repo
      /bin/sudo /bin/echo "gpgcheck=1" >> /etc/yum.repos.d/MariaDB.repo
      /bin/sudo /bin/echo "" >> /etc/yum.repos.d/MariaDB.repo
    else
      /bin/sudo /bin/sed -i 's/ = /=/g' /etc/yum.repos.d/MariaDB.repo
      /bin/sudo /bin/sed -i 's/ =/=/g' /etc/yum.repos.d/MariaDB.repo
      /bin/sudo /bin/sed -i 's/= /=/g' /etc/yum.repos.d/MariaDB.repo
      /bin/sudo /bin/sed -i 's/baseurl.*/baseurl=http:\/\/yum.mariadb.org\/10.4\/centos7-amd64/g' /etc/yum.repos.d/MariaDB.repo
    fi
    /bin/sudo /bin/yum -y -q --skip-broken install MariaDB-server MariaDB-client > /dev/null 2>&1
    if ! rpm -qa | grep -q "MariaDB-server"; then
      /bin/echo "'MariaDB-server' is required, check your connection from port 443"
      exit 1
      return 1
    fi
  ;;
  "MariaDB103")
    if [ ! -f /etc/yum.repos.d/MariaDB.repo ]; then
      /bin/sudo /bin/echo "[mariadb]" > /etc/yum.repos.d/MariaDB.repo
      /bin/sudo /bin/echo "name=MariaDB" >> /etc/yum.repos.d/MariaDB.repo
      /bin/sudo /bin/echo "baseurl=http://yum.mariadb.org/10.3/centos7-amd64" >> /etc/yum.repos.d/MariaDB.repo
      /bin/sudo /bin/echo "gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB" >> /etc/yum.repos.d/MariaDB.repo
      /bin/sudo /bin/echo "gpgcheck=1" >> /etc/yum.repos.d/MariaDB.repo
      /bin/sudo /bin/echo "" >> /etc/yum.repos.d/MariaDB.repo
    else
      /bin/sudo /bin/sed -i 's/ = /=/g' /etc/yum.repos.d/MariaDB.repo
      /bin/sudo /bin/sed -i 's/ =/=/g' /etc/yum.repos.d/MariaDB.repo
      /bin/sudo /bin/sed -i 's/= /=/g' /etc/yum.repos.d/MariaDB.repo
      /bin/sudo /bin/sed -i 's/baseurl.*/baseurl=http:\/\/yum.mariadb.org\/10.3\/centos7-amd64/g' /etc/yum.repos.d/MariaDB.repo
    fi
    /bin/sudo /bin/yum -y -q --skip-broken install MariaDB-server MariaDB-client > /dev/null 2>&1
    if ! rpm -qa | grep -q "MariaDB-server"; then
      /bin/echo "'MariaDB-server' is required, check your connection from port 443"
      exit 1
      return 1
    fi
  ;;
  *)
    /bin/echo "WARNING - A MariaDB version was not selected and will not be installed"
  ;;
esac

/bin/sudo /bin/systemctl enable mariadb.service > /dev/null 2>&1
/bin/sudo /bin/systemctl stop mariadb.service
/bin/sudo /bin/systemctl start mariadb.service

/bin/sudo /bin/sh ${SCRIPT_DIR}/include/config/mariadb.sh "${SCRIPT_DIR}"

# mysql_secure_installation
