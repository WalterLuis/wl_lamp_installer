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
NTP_SELECT="${2}"
if [[ -z "${NTP_SELECT}" ]]; then
  /bin/sudo /bin/echo "3.es" > ${SCRIPT_DIR}/globalVariable/NTP_SELECT.txt
  NTP_SELECT="$(/bin/cat ${SCRIPT_DIR}/globalVariable/NTP_SELECT.txt)"
fi

if ! rpm -qa | grep -q "ntp"; then
  /bin/sudo /bin/yum -y -q --skip-broken install ntp > /dev/null 2>&1
fi

#/bin/sudo chkconfig ntpd on
/bin/sudo /bin/systemctl enable ntpd.service > /dev/null 2>&1

/bin/sudo timedatectl set-timezone "Atlantic/Canary" >> ${SCRIPT_DIR}/debug.log

/bin/sudo /bin/systemctl stop ntpd.service
case ${NTP_SELECT} in
  "1.europe")
    /bin/sudo ntpdate 1.europe.pool.ntp.org >> ${SCRIPT_DIR}/debug.log
  ;;
  "3.europe")
    /bin/sudo ntpdate 3.europe.pool.ntp.org >> ${SCRIPT_DIR}/debug.log
  ;;
  *)
    /bin/sudo ntpdate 3.es.pool.ntp.org >> ${SCRIPT_DIR}/debug.log
  ;;
esac
/bin/sudo /bin/systemctl start ntpd.service
