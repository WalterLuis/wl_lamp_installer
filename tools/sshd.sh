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
/bin/echo "###### SSH - Do you want to make the following changes?"
/bin/echo "######  - Change SSH port to 2244"
/bin/echo "######  - Lock login with root by SSH"
/bin/echo "######################################################################################"

select yn in "yes" "no"; do
  case $yn in
  yes)
    /bin/sudo /bin/sh ${SCRIPT_DIR}/include/sshd.sh "${SCRIPT_DIR}" "2244"
    break
    ;;
  no)
    exit 1
    return 1
    break
    ;;
  esac
done
