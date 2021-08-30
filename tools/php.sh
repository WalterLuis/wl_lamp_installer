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
/bin/echo "###### PHP"
/bin/echo "######################################################################################"

select yn in "php56u" "php71u" "php72u" "php73" "EXIT";do
  case $yn in
    php56u)
      /bin/echo "working..."
      /bin/sudo /bin/echo "php56u" > ${SCRIPT_DIR}/globalVariable/PHP_VERSION.txt
    break;;
    php71u)
      /bin/echo "working..."
      /bin/sudo /bin/echo "php71u" > ${SCRIPT_DIR}/globalVariable/PHP_VERSION.txt
    break;;
    php72u)
      /bin/echo "working..."
      /bin/sudo /bin/echo "php72u" > ${SCRIPT_DIR}/globalVariable/PHP_VERSION.txt
    break;;
    php73)
      /bin/echo "working..."
      /bin/sudo /bin/echo "php73" > ${SCRIPT_DIR}/globalVariable/PHP_VERSION.txt
    break;;
    EXIT)
      exit 1
      return 1
    break;;
  esac
done

if rpm -qa | grep -q "php"; then
  /bin/sudo /bin/rm -f /etc/php.ini >> ${SCRIPT_DIR}/debug.log
  /bin/sudo /bin/yum -y -q --skip-broken remove mod_php* php* > /dev/null 2>&1
  /bin/sudo /bin/rm -Rf /etc/php* >> ${SCRIPT_DIR}/debug.log
fi

/bin/sudo /bin/sh ${SCRIPT_DIR}/include/php.sh "${SCRIPT_DIR}"

/bin/sudo /bin/systemctl stop httpd.service
/bin/sudo /bin/systemctl start httpd.service
