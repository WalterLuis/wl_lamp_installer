#!/bin/bash

/bin/echo "#####################"
/bin/echo "####  MENU v3.2  ####"
/bin/echo "#####################"

/bin/yum -y -q --skip-broken install sudo >/dev/null 2>&1

# Check root
if [ "$EUID" -ne 0 ]; then
  /bin/echo "Please run as root"
  exit 1
  return 1
fi

/bin/sudo /bin/yum -y -q --skip-broken install grep rpm /bin/cat /bin/sed gawk bind-utils net-tools >/dev/null 2>&1

SCRIPT_DIR="$(readlink -f $(dirname ${BASH_SOURCE[0]}))"
if [[ -z "${SCRIPT_DIR}" ]]; then
  SCRIPT_DIR="$(/bin/cat /root/wl_lemp_lamp/globalVariable/SCRIPT_DIR.txt)"
  if [[ -z "${SCRIPT_DIR}" ]]; then
    /bin/echo "ERROR CRITIC $BASH_SOURCE: SCRIPT_DIR - empty"
    exit 1
    return 1
  fi
fi

/bin/sudo /bin/echo "#" >${SCRIPT_DIR}/debug.log

/bin/sudo /bin/echo "${SCRIPT_DIR}" >/root/wl_lemp_lamp/globalVariable/SCRIPT_DIR.txt

source "${SCRIPT_DIR}/inc.sh"

getHostname

# tput_menu: a menu driven system information program
BG_BLUE="$(/bin/tput setab 4)"
BG_BLACK="$(/bin/tput setab 0)"
FG_GREEN="$(/bin/tput setaf 2)"
FG_WHITE="$(/bin/tput setaf 7)"

# Save screen
/bin/tput smcup

# Display menu until selection == 0
while [[ $REPLY != 0 ]]; do
  /bin/echo -n ${BG_BLUE}${FG_WHITE}
  /bin/clear
  /bin/cat <<-_EOF_

  Please Select:

  A. Unattended installation (Apache 2.4.X, MariaDB 10.1.X, PHP 7.2.X)
  B. Unattended installation (NGINX 1.1.X, MariaDB 10.1.X, PHP 7.2.X)

  1. Change Apache version
  2. Change NGINX version
  3. Change PHP version
  4. Change MariaDB version

  5. Generate / Renew website certificate with Certbot
  6. Synchronize date and time with an ntp server

  10. Install Webmin
  11. Install Git
  12. Install MongoDB
  13. Install Node.JS

  0. Quit
_EOF_
  read -p "Enter selection: > " selection
  # Clear area beneath menu
  /bin/tput cup 20 0
  /bin/echo -n ${BG_BLACK}${FG_GREEN}
  /bin/tput ed
  /bin/tput cup 21 0
  # Act on selection
  case $selection in
  [Aa])
    /bin/echo "working..."
    /bin/sudo /bin/sh ${SCRIPT_DIR}/unattended/LAMP.sh "${SCRIPT_DIR}"
    ;;
  [Bb])
    /bin/echo "comming soon..."
    /bin/sudo /bin/sh ${SCRIPT_DIR}/unattended/LEMP.sh "${SCRIPT_DIR}"
    ;;
  1)
    /bin/echo "working..."
    /bin/sudo /bin/sh ${SCRIPT_DIR}/tools/apache.sh "${SCRIPT_DIR}"
    ;;
  2)
    /bin/echo "comming soon..."
    /bin/sudo /bin/sh ${SCRIPT_DIR}/tools/ngix.sh "${SCRIPT_DIR}"
    ;;
  3)
    /bin/echo "working..."
    /bin/sudo /bin/sh ${SCRIPT_DIR}/tools/php.sh "${SCRIPT_DIR}"
    ;;
  4)
    /bin/echo "working..."
    /bin/sudo /bin/sh ${SCRIPT_DIR}/tools/mariadb.sh "${SCRIPT_DIR}"
    ;;
  5)
    /bin/echo "comming soon..."
    /bin/sudo /bin/sh ${SCRIPT_DIR}/tools/certbot.sh "${SCRIPT_DIR}"
    ;;
  6)
    /bin/echo "working..."
    /bin/sudo /bin/sh ${SCRIPT_DIR}/tools/ntp.sh "${SCRIPT_DIR}"
    ;;
  10)
    /bin/echo "comming soon..."
    /bin/sudo /bin/sh ${SCRIPT_DIR}/extras/webmin.sh "${SCRIPT_DIR}"
    ;;
  11)
    /bin/echo "comming soon..."
    /bin/sudo /bin/sh ${SCRIPT_DIR}/extras/git.sh "${SCRIPT_DIR}"
    ;;
  12)
    /bin/echo "comming soon..."
    /bin/sudo /bin/sh ${SCRIPT_DIR}/extras/mongodb.sh "${SCRIPT_DIR}"
    ;;
  13)
    /bin/echo "comming soon..."
    /bin/sudo /bin/sh ${SCRIPT_DIR}/extras/node.sh "${SCRIPT_DIR}"
    ;;
  0)
    break
    ;;
  *)
    /bin/echo "Invalid entry."
    ;;
  esac
  /bin/printf "\n\nPress any key to continue."
  read -n 1
done
# Restore screen
/bin/tput rmcup
#/bin/echo "Program terminated."
