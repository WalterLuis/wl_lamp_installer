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

select yn in "Install_IPtables" "Install_Firewalld" "Disabled_Firewalls";do
  case $yn in
    Install_IPtables)
    FIREWALL="Install_IPtables"
    break;;
    Install_Firewalld)
    FIREWALL="Install_Firewalld"
    sudo systemctl restart firewalld.service
    break;;
    *)
    FIREWALL="Disabled_Firewalls"
    break;;
  esac
done

if [[ -z "${FIREWALL}" ]]; then
  FIREWALL="$(/bin/cat ${SCRIPT_DIR}/globalVariable/FIREWALL.txt)"
  /bin/echo "INFO $BASH_SOURCE: FIREWALL"
  if [[ -z "${FIREWALL}" ]]; then
    /bin/sudo /bin/echo "Install_Firewalld" > ${SCRIPT_DIR}/globalVariable/FIREWALL.txt
    FIREWALL="$(/bin/cat ${SCRIPT_DIR}/globalVariable/FIREWALL.txt)"
    /bin/echo "WARNING $BASH_SOURCE: FIREWALL - was empty - Assign default: 'Install_Firewalld'"
  fi
fi