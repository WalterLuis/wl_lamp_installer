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
METHOD_CERTBOT="${2}"
if [[ -z "${METHOD_CERTBOT}" ]]; then
  /bin/sudo /bin/echo "Generate" > ${SCRIPT_DIR}/globalVariable/METHOD_CERTBOT.txt
  METHOD_CERTBOT="$(/bin/cat ${SCRIPT_DIR}/globalVariable/METHOD_CERTBOT.txt)"
  /bin/echo "WARNING $BASH_SOURCE: METHOD_CERTBOT - empty"
fi

SERVER_NAME_CERTBOT="${3}"
if [[ -z "${SERVER_NAME_CERTBOT}" ]]; then
  SERVER_NAME_CERTBOT="$(/bin/cat ${SCRIPT_DIR}/globalVariable/SERVER_NAME_CERTBOT.txt)"
  /bin/echo "WARNING $BASH_SOURCE: SERVER_NAME_CERTBOT - MAIN"
fi
if [[ -z "${SERVER_NAME_CERTBOT}" ]]; then
  /bin/echo "ERROR CRITIC $BASH_SOURCE: SERVER_NAME_CERTBOT - empty"
  exit 1
  return 1
fi

SERVER_NAME="$(/bin/cat ${SCRIPT_DIR}/globalVariable/SERVER_NAME.txt)"
if [[ -z "${SERVER_NAME}" ]]; then
  /bin/echo "ERROR CRITIC $BASH_SOURCE: SERVER_NAME - empty"
  exit 1
  return 1
fi

SERVER_NAME_MAIN="$(/bin/cat ${SCRIPT_DIR}/globalVariable/SERVER_NAME_MAIN.txt)"
if [[ -z "${SERVER_NAME_MAIN}" ]]; then
  SERVER_NAME_MAIN="$(/bin/cat ${SCRIPT_DIR}/globalVariable/SERVER_NAME_MAIN.txt)"
  /bin/echo "WARNING $BASH_SOURCE: SERVER_NAME_MAIN - MAIN"
fi
if [[ -z "${SERVER_NAME_MAIN}" ]]; then
  /bin/echo "ERROR CRITIC $BASH_SOURCE: SERVER_NAME_MAIN - empty"
  exit 1
  return 1
fi

/bin/sudo /bin/systemctl stop httpd.service

case ${METHOD_CERTBOT} in
  "Generate")
    if rpm -qa | grep -q "certbot"; then
      /bin/sudo /bin/yum -y -q --skip-broken remove certbot > /dev/null 2>&1
      /bin/sudo /bin/yum -y -q --skip-broken remove python2-certbot* > /dev/null 2>&1
      /bin/sudo /bin/find / -name python2-certbot* -exec /bin/rm -rf {} \;
      /bin/sudo /bin/rm -Rf /usr/bin/letsencrypt* >> ${SCRIPT_DIR}/debug.log
      /bin/sudo /bin/rm -Rf /etc/letsencrypt* >> ${SCRIPT_DIR}/debug.log
    fi
    if ! rpm -qa | grep -q "certbot"; then
      /bin/echo "'certbot' is required, check your connection from port 443"
      exit 1
      return 1
    fi
    /bin/sudo /bin/yum -y -q --skip-broken install certbot python2-certbot* > /dev/null 2>&1
    if [[ ! "$SERVER_NAME_CERTBOT" =~ "localhost" ]]; then
      #For more than one domain use this example in globalVariable/SERVER_NAME_CERTBOT.txt: localhost1 -d localhost2 -d localhost3 -d localhost4
      /bin/sudo /bin/certbot certonly -d $SERVER_NAME_CERTBOT --standalone --non-interactive --register-unsafely-without-email --agree-tos --rsa-key-size 4096 --force-renew
    fi
  ;;
  *)
    if ! rpm -qa | grep -q "certbot"; then
      /bin/sudo /bin/yum -y -q --skip-broken install *certbot* > /dev/null 2>&1
    fi
    if [[ ! "$SERVER_NAME_CERTBOT" =~ "localhost" ]]; then
      /bin/certbot renew --rsa-key-size 4096
    fi
  ;;
esac

/bin/sudo /bin/sh ${SCRIPT_DIR}/include/config/certbot.sh "$SERVER_NAME" "$SERVER_NAME_MAIN"

/bin/sudo /bin/systemctl start httpd.service
