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
APACHE_VERSION="${2}"
if [[ -z "${APACHE_VERSION}" ]]; then
  APACHE_VERSION="$(/bin/cat ${SCRIPT_DIR}/globalVariable/APACHE_VERSION.txt)"
  /bin/echo "INFO $BASH_SOURCE: APACHE_VERSION"
  if [[ -z "${APACHE_VERSION}" ]]; then
    /bin/sudo /bin/echo "lastVersion" > ${SCRIPT_DIR}/globalVariable/APACHE_VERSION.txt
    APACHE_VERSION="$(/bin/cat ${SCRIPT_DIR}/globalVariable/APACHE_VERSION.txt)"
    /bin/echo "WARNING $BASH_SOURCE: APACHE_VERSION - empty"
  fi
fi
PARAMS_SSL="${3}"
if [[ -z "${PARAMS_SSL}" ]]; then
  PARAMS_SSL="$(/bin/cat ${SCRIPT_DIR}/globalVariable/PARAMS_SSL.txt)"
  if [[ -z "${PARAMS_SSL}" ]]; then
    PARAMS_SSL="80"
    /bin/sudo /bin/echo "80" > ${SCRIPT_DIR}/globalVariable/PARAMS_SSL.txt
  fi
fi
SERVER_NAME="$(/bin/cat ${SCRIPT_DIR}/globalVariable/SERVER_NAME.txt)"
if [[ -z "${SERVER_NAME}" ]]; then
  /bin/echo "WARNING $BASH_SOURCE: SERVER_NAME - empty"
  exit 1
  return 1
fi
SERVER_NAME_MAIN="$(/bin/cat ${SCRIPT_DIR}/globalVariable/SERVER_NAME_MAIN.txt)"
if [[ -z "${SERVER_NAME}" ]]; then
  /bin/echo "WARNING $BASH_SOURCE: SERVER_NAME_MAIN - empty"
  exit 1
  return 1
fi
SERVER_NAME_CERTBOT="$(/bin/cat ${SCRIPT_DIR}/globalVariable/SERVER_NAME_CERTBOT.txt)"
if [[ -z "${SERVER_NAME}" ]]; then
  /bin/echo "WARNING $BASH_SOURCE: SERVER_NAME_CERTBOT - empty"
  exit 1
  return 1
fi
case ${APACHE_VERSION} in
  "centosVersion")
    /bin/sudo /bin/yum -y -q --skip-broken install httpd httpd-tools > /dev/null 2>&1
    /bin/sudo /bin/yum -y -q --skip-broken install mod_ssl > /dev/null 2>&1
    /bin/sudo /bin/echo "centosVersion" > ${SCRIPT_DIR}/globalVariable/APACHE_VERSION.txt
    if ! rpm -qa | grep -q "httpd"; then
      /bin/echo "'httpd' is required, check your connection from port 443"
      exit 1
      return 1
    fi
  ;;
  *)
    /bin/sudo /bin/yum -y -q --skip-broken install httpd24u httpd24u-tools > /dev/null 2>&1
    /bin/sudo /bin/yum -y -q --skip-broken install httpd24u-mod_ssl httpd24u-mod_security2 > /dev/null 2>&1
    /bin/sudo /bin/sed -i 's/SecRequestBodyLimit 1.*/SecRequestBodyLimit 134217728/g' '/etc/httpd/conf.d/mod_security2.conf'
    /bin/sudo /bin/sed -i 's/SecRequestBodyNoFilesLimit 1.*/SecRequestBodyNoFilesLimit 134217728/g' '/etc/httpd/conf.d/mod_security2.conf'
    /bin/sudo /bin/sed -i 's/SecRequestBodyInMemoryLimit 1.*/SecRequestBodyInMemoryLimit 134217728/g' '/etc/httpd/conf.d/mod_security2.conf'
    /bin/sudo /bin/echo "lastVersion" > ${SCRIPT_DIR}/globalVariable/APACHE_VERSION.txt
    if ! rpm -qa | grep -q "httpd24u"; then
      /bin/echo "'httpd24u' is required, check your connection from port 443"
      exit 1
      return 1
    fi
  ;;
esac

/bin/sudo /bin/echo "#" > /etc/httpd/conf.d/welcome.conf

/bin/sudo /bin/sh ${SCRIPT_DIR}/include/config/apache_add_httpdconf.sh "${SERVER_NAME}"

/bin/sudo /bin/sh ${SCRIPT_DIR}/include/config/apache_add_vhost_80.sh "${SERVER_NAME}" "${SERVER_NAME_MAIN}" "${SCRIPT_DIR}" "${PARAMS_SSL}"

if [ "${PARAMS_SSL}" == "443" ]; then
  /bin/sudo /bin/sh ${SCRIPT_DIR}/include/config/apache_add_sslconf.sh
  /bin/sudo /bin/sh ${SCRIPT_DIR}/include/config/apache_add_vhost_443.sh "${SERVER_NAME}" "${SERVER_NAME_MAIN}" "${SCRIPT_DIR}" "${PARAMS_SSL}"
fi

/bin/sudo /bin/mv /var/www/html/ /var/www/${SERVER_NAME}/

if [ -d /var/www/html/ ]; then
  /bin/sudo rmdir /var/www/html/
fi

if [ "${PARAMS_SSL}" == "443" ]; then
  if [ ${SERVER_NAME_MAIN} != "localhost" ]; then
    if [ ! -d /etc/letsencrypt/live/${SERVER_NAME} ]; then
      /bin/sudo /bin/sh ${SCRIPT_DIR}/include/certbot.sh "${SCRIPT_DIR}" "Generate" "${SERVER_NAME_CERTBOT}"
    else
      /bin/sudo /bin/sh ${SCRIPT_DIR}/include/certbot.sh "${SCRIPT_DIR}" "Renew" "${SERVER_NAME_CERTBOT}"
    fi
  fi
fi

/bin/sudo /bin/systemctl enable httpd.service > /dev/null 2>&1

apachectl configtest

/bin/sudo /bin/systemctl reset-failed httpd.service
/bin/sudo /bin/systemctl start httpd.service
