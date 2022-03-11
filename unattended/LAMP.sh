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
/bin/echo "######   Select the state of SELINUX that you want"
/bin/echo "######   NOTE: value 'all' is recommended, but this process takes about 1 hour"
/bin/echo "######################################################################################"
select yn in "enforcing" "permissive" "disabled" "all"; do
  case "$yn" in
  enforcing)
    SESTATUS="enforcing"
    /bin/sudo /bin/echo "${SESTATUS}" >${SCRIPT_DIR}/globalVariable/SESTATUS.txt
    break
    ;;
  permissive)
    SESTATUS="permissive"
    /bin/sudo /bin/echo "${SESTATUS}" >${SCRIPT_DIR}/globalVariable/SESTATUS.txt
    break
    ;;
  disabled)
    SESTATUS="disabled"
    /bin/sudo /bin/echo "${SESTATUS}" >${SCRIPT_DIR}/globalVariable/SESTATUS.txt
    break
    ;;
  all)
    SESTATUS="all"
    /bin/sudo /bin/echo "${SESTATUS}" >${SCRIPT_DIR}/globalVariable/SESTATUS.txt
    break
    ;;
  esac
done

/bin/echo ""
/bin/echo "######################################################################################"
/bin/echo "######   you're sure you want to erase everything (APACHE, PHP, MariaDB)?"
/bin/echo "######   NOTE: remember to make a backup of the database"
/bin/echo "######################################################################################"
select yn in "Accept" "EXIT"; do
  case "$yn" in
  Accept)
    /bin/echo ""
    /bin/echo "######################################################################################"
    /bin/echo "######   Do you want to activate https with your certificate using Letsencrypt?"
    /bin/echo "######################################################################################"
    select yn in "Yes" "No"; do
      case "$yn" in
      Yes)
        PARAMS_SSL="443"
        break
        ;;
      No)
        PARAMS_SSL="80"
        break
        ;;
      esac
    done
    /bin/sudo /bin/echo "${PARAMS_SSL}" >${SCRIPT_DIR}/globalVariable/PARAMS_SSL.txt
    /bin/echo "working..."
    if rpm -qa | grep -q "httpd"; then
      /bin/sudo /bin/rm -f /etc/httpd/conf.d/ssl.conf >>${SCRIPT_DIR}/debug.log
      /bin/sudo /bin/rm -f /etc/httpd/conf.d/mod_security2.conf >>${SCRIPT_DIR}/debug.log
      /bin/sudo /bin/rm -f /etc/httpd/conf/httpd.conf >>${SCRIPT_DIR}/debug.log
      /bin/sudo /bin/rm -f /etc/httpd/conf.d/welcome.conf >>${SCRIPT_DIR}/debug.log
      /bin/sudo /bin/yum -y -q --skip-broken remove httpd* >/dev/null 2>&1
      /bin/sudo /bin/rm -Rf /var/log/httpd/* >>${SCRIPT_DIR}/debug.log
      /bin/sudo /bin/rm -Rf /etc/httpd/* >>${SCRIPT_DIR}/debug.log
    fi
    if rpm -qa | grep -q "php"; then
      /bin/sudo /bin/rm -f /etc/php.ini >>${SCRIPT_DIR}/debug.log
      /bin/sudo /bin/yum -y -q --skip-broken remove mod_php* php* >/dev/null 2>&1
      /bin/sudo /bin/rm -Rf /etc/php* >>${SCRIPT_DIR}/debug.log
    fi
    #if rpm -qa | grep -q "mysql"; then
    #  /bin/sudo /bin/yum -y -q --skip-broken remove mysql* > /dev/null 2>&1
    #fi
    #if rpm -qa | grep -q "mariadb"; then
    #  /bin/sudo /bin/yum -y -q --skip-broken remove mariadb* > /dev/null 2>&1
    #  /bin/sudo /bin/rm -Rf /var/log/mariadb/* >> ${SCRIPT_DIR}/debug.log
    #  /bin/sudo /bin/rm -f /var/log/mariadb/mariadb.log >> ${SCRIPT_DIR}/debug.log
    #fi
    break
    ;;
  EXIT)
    /bin/echo "exiting..."
    exit 1
    return 1
    break
    ;;
  esac
done

/bin/sudo /bin/sh ${SCRIPT_DIR}/include/selinux.sh "${SCRIPT_DIR}" "${SESTATUS}"

/bin/sudo /bin/sh ${SCRIPT_DIR}/include/ntp.sh "${SCRIPT_DIR}" "3.es"

/bin/sudo /bin/sh ${SCRIPT_DIR}/include/repo.sh "${SCRIPT_DIR}"

/bin/sudo /bin/sh ${SCRIPT_DIR}/include/apache.sh "${SCRIPT_DIR}" "lastVersion" "${PARAMS_SSL}"

/bin/sudo /bin/sh ${SCRIPT_DIR}/include/mariadb.sh "${SCRIPT_DIR}"

/bin/sudo /bin/sh ${SCRIPT_DIR}/include/php.sh "${SCRIPT_DIR}"

/bin/sudo /bin/sh ${SCRIPT_DIR}/include/firewall.sh "${SCRIPT_DIR}" "Install_Firewalld"

/bin/sudo /bin/sh ${SCRIPT_DIR}/include/fail2ban.sh "${SCRIPT_DIR}"

/bin/sudo /bin/sh ${SCRIPT_DIR}/include/composer.sh "${SCRIPT_DIR}"

/bin/sudo /bin/sh ${SCRIPT_DIR}/include/node.sh "${SCRIPT_DIR}"

/bin/sudo /bin/sh ${SCRIPT_DIR}/include/yarn.sh "${SCRIPT_DIR}"

/bin/sudo /bin/sh ${SCRIPT_DIR}/include/sshd.sh "${SCRIPT_DIR}" "2244"

/bin/sudo /bin/systemctl stop httpd.service
/bin/sudo /bin/systemctl start httpd.service
#/bin/sudo /bin/systemctl stop mariadb.service
#/bin/sudo /bin/systemctl start mariadb.service
