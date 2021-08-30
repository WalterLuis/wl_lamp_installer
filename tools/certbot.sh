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
/bin/echo "######   CERTBOT - Letsencrypt"
/bin/echo "######################################################################################"

select yn in "Generate" "Renew" "nothing";do
  case "$yn" in
    Generate)
      /bin/echo "working..."
      METHOD_CERTBOT="Generate"
    break;;
    Renew)
      /bin/echo "working..."
      METHOD_CERTBOT="Renew"
    break;;
    nothing)
      exit 1
      return 1
    break;;
  esac
done

/bin/sudo /bin/sh ${SCRIPT_DIR}/include/certbot.sh "${SCRIPT_DIR}" "${METHOD_CERTBOT}"
