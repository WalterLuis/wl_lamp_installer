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
/bin/echo "######   NTP"
/bin/echo "######################################################################################"

select yn in "3.es" "1.europe" "3.europe";do
  case "$yn" in
    3.es)
      NTP_SELECT="3.es"
    break;;
    1.europe)
      NTP_SELECT="1.europe"
    break;;
    3.europe)
      NTP_SELECT="3.europe"
    break;;
  esac
done
/bin/echo "working..."

/bin/sudo /bin/sh ${SCRIPT_DIR}/include/ntp.sh "${SCRIPT_DIR}" "${NTP_SELECT}"
