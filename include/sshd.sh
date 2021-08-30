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

# Default port: 2244
SSHD_PORT="${2}"
if [[ -z "${SSHD_PORT}" ]]; then
  /bin/sudo /bin/echo "${SSHD_PORT}" > ${SCRIPT_DIR}/globalVariable/SSHD_PORT.txt
  SSHD_PORT="$(/bin/cat ${SCRIPT_DIR}/globalVariable/SSHD_PORT.txt)"
else
  /bin/sudo /bin/echo "${SSHD_PORT}" > ${SCRIPT_DIR}/globalVariable/SSHD_PORT.txt
fi

if [ ! -f /etc/ssh/sshd_config.itop_backup_first ]; then
  /bin/sudo /bin/cp /etc/ssh/sshd_config /etc/ssh/sshd_config.itop_backup_first
fi
/bin/sudo /bin/cp /etc/ssh/sshd_config /etc/ssh/sshd_config.itop_backup_last

/bin/echo "Cambiando puerto del SSH al ${SSHD_PORT}\n"
/bin/sudo /bin/sed -i "s/#Port 2.*/Port ${SSHD_PORT}/g" /etc/ssh/sshd_config
/bin/sudo /bin/sed -i "s/Port 2.*/Port ${SSHD_PORT}/g" /etc/ssh/sshd_config
#/bin/echo "Deshabilidando Login con root desde SSH\n"
#/bin/sudo /bin/sed -i 's/#PermitRootLogin .*/PermitRootLogin no/g' /etc/ssh/sshd_config
#/bin/sudo /bin/sed -i 's/PermitRootLogin .*/PermitRootLogin no/g' /etc/ssh/sshd_config

/bin/echo ""
/bin/echo "######################################################################################"
/bin/echo "######   validate PORT from sshd with NANO?"
/bin/echo "######################################################################################"
select yn in "Yes" "No";do
  case "$yn" in
    Yes)
nano /etc/ssh/sshd_config
#bin/sudo /bin/systemctl restart sshd.service
    break;;
    No)
    break;;
  esac
done

/bin/echo "/bin/sudo /bin/systemctl restart sshd.service\n"

