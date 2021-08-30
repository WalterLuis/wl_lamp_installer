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
SERVER_NAME="${1}"
if [[ -z "${SERVER_NAME}" ]]; then
  SERVER_NAME="$(/bin/cat ${SCRIPT_DIR}/globalVariable/SERVER_NAME.txt)"
  /bin/echo "WARNING $BASH_SOURCE: SERVER_NAME - empty"
fi
if [[ -z "${SERVER_NAME}" ]]; then
  /bin/echo "ERROR CRITIC $BASH_SOURCE: SERVER_NAME - empty"
  exit 1
  return 1
fi
SERVER_NAME_MAIN="${2}"
if [[ -z "${SERVER_NAME_MAIN}" ]]; then
  SERVER_NAME_MAIN="$(/bin/cat ${SCRIPT_DIR}/globalVariable/SERVER_NAME_MAIN.txt)"
  /bin/echo "WARNING $BASH_SOURCE: SERVER_NAME_MAIN - empty"
  if [[ -z "${SERVER_NAME_MAIN}" ]]; then
    SERVER_NAME_MAIN="$(/bin/cat ${SCRIPT_DIR}/globalVariable/SERVER_NAME.txt)"
    /bin/echo "WARNING $BASH_SOURCE: SERVER_NAME - MAIN - empty"
  fi
fi
if [[ -z "${SERVER_NAME_MAIN}" ]]; then
  /bin/echo "ERROR CRITIC $BASH_SOURCE: SERVER_NAME_MAIN - empty"
  exit 1
  return 1
fi

if [[ ! "$SERVER_NAME_MAIN" =~ "localhost" ]]; then
  pinCert="$(/bin/sudo openssl x509 -in /etc/letsencrypt/live/${SERVER_NAME_MAIN}/cert.pem -pubkey -noout | /bin/sudo openssl rsa -pubin -outform der | /bin/sudo openssl dgst -sha256 -binary | /bin/sudo openssl enc -base64)"
  pinChain="$(/bin/sudo openssl x509 -in /etc/letsencrypt/live/${SERVER_NAME_MAIN}/chain.pem -pubkey -noout | /bin/sudo openssl rsa -pubin -outform der | /bin/sudo openssl dgst -sha256 -binary | /bin/sudo openssl enc -base64)"
  pinPrivate="$(/bin/sudo openssl rsa -in /etc/letsencrypt/live/${SERVER_NAME_MAIN}/privkey.pem -outform der | /bin/sudo openssl dgst -sha256 -binary | /bin/sudo openssl enc -base64)"
  /bin/sudo /bin/sed -i "s#Header always set Public-Key-Pins .*#Header always set Public-Key-Pins 'pin-sha256=\"${pinCert}\"; pin-sha256=\"${pinChain}\"; pin-sha256=\"${pinPrivate}\"; max-age=7889400; includeSubDomains'#g" "/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf"
  /bin/echo "Header always set Public-Key-Pins 'pin-sha256=\"${pinCert}\"; pin-sha256=\"${pinChain}\"; pin-sha256=\"${pinPrivate}\"; max-age=7889400; includeSubDomains'" >> /etc/httpd/Public-Key-Pins.history
fi
