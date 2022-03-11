#!/bin/bash

SCRIPT_DIR="$(/bin/cat /root/wl_lemp_lamp/globalVariable/SCRIPT_DIR.txt)"
if [[ -z "${SCRIPT_DIR}" ]]; then
  SCRIPT_DIR="$(readlink -f $(dirname ${BASH_SOURCE[0]}))"
  /bin/sudo /bin/echo "${SCRIPT_DIR}" >/root/wl_lemp_lamp/globalVariable/SCRIPT_DIR.txt
  if [[ -z "${SCRIPT_DIR}" ]]; then
    SCRIPT_DIR="$(/bin/cat /root/wl_lemp_lamp/globalVariable/SCRIPT_DIR.txt)"
    if [[ -z "${SCRIPT_DIR}" ]]; then
      /bin/echo "ERROR CRITIC $BASH_SOURCE: SCRIPT_DIR - empty"
      exit 1
      return 1
    else
      /bin/sudo /bin/echo "${SCRIPT_DIR}" >/root/wl_lemp_lamp/globalVariable/SCRIPT_DIR.txt
    fi
  fi
fi

/bin/sudo /bin/sh ${SCRIPT_DIR}/include/config/apache_add_vhost.sh "myPublicDomain"

apachectl configtest

/bin/sudo /bin/systemctl reset-failed httpd.service
/bin/sudo /bin/systemctl restart httpd.service
