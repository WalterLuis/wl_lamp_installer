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
/bin/echo "######   APACHE"
/bin/echo "######################################################################################"

select yn in "centosVersion" "lastVersion" "nothing";do
  case "$yn" in
    centosVersion)
      /bin/echo "working..."
      /bin/sudo /bin/echo "centosVersion" > ${SCRIPT_DIR}/globalVariable/APACHE_VERSION.txt
      APACHE_VERSION="centosVersion"
    break;;
    lastVersion)
      /bin/echo "working..."
      /bin/sudo /bin/sh ${SCRIPT_DIR}/include/repo.sh "${SCRIPT_DIR}"
      /bin/sudo /bin/echo "lastVersion" > ${SCRIPT_DIR}/globalVariable/APACHE_VERSION.txt
      APACHE_VERSION="lastVersion"
    break;;
    nothing)
      exit 1
      return 1
    break;;
  esac
done

/bin/echo ""
/bin/echo "######################################################################################"
/bin/echo "######   Do you want to activate https with your certificate using Letsencrypt?"
/bin/echo "######################################################################################"

select yn in "SSL" "NO_SSL";do
  case "$yn" in
    SSL)
      PARAMS_SSL="443"
      /bin/sudo /bin/echo "443" > ${SCRIPT_DIR}/globalVariable/PARAMS_SSL.txt
    break;;
    NO_SSL)
      PARAMS_SSL="80"
      /bin/sudo /bin/echo "80" > ${SCRIPT_DIR}/globalVariable/PARAMS_SSL.txt
    break;;
  esac
done

if rpm -qa | grep -q "httpd"; then
  /bin/sudo /bin/yum -y -q --skip-broken remove httpd* > /dev/null 2>&1
  /bin/sudo /bin/rm -Rf /var/log/httpd/* >> ${SCRIPT_DIR}/debug.log
  /bin/sudo /bin/rm -Rf /etc/httpd/* >> ${SCRIPT_DIR}/debug.log
fi
if rpm -qa | grep -q "php"; then
  /bin/sudo /bin/yum -y -q --skip-broken remove mod_php* php* > /dev/null 2>&1
  /bin/sudo /bin/rm -Rf /etc/php* >> ${SCRIPT_DIR}/debug.log
fi

/bin/sudo /bin/sh ${SCRIPT_DIR}/include/apache.sh "${SCRIPT_DIR}" "${APACHE_VERSION}" "${PARAMS_SSL}"

/bin/sudo /bin/sh ${SCRIPT_DIR}/tools/php.sh "${SCRIPT_DIR}"

/bin/sudo /bin/systemctl stop httpd.service
/bin/sudo /bin/systemctl start httpd.service
