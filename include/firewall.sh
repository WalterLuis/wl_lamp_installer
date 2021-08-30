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

FIREWALL="${2}"
if [[ -z "${FIREWALL}" ]]; then
  FIREWALL="$(/bin/cat ${SCRIPT_DIR}/globalVariable/FIREWALL.txt)"
  /bin/echo "INFO $BASH_SOURCE: FIREWALL"
  if [[ -z "${FIREWALL}" ]]; then
    /bin/sudo /bin/echo "Install_Firewalld" > ${SCRIPT_DIR}/globalVariable/FIREWALL.txt
    FIREWALL="$(/bin/cat ${SCRIPT_DIR}/globalVariable/FIREWALL.txt)"
    /bin/echo "WARNING $BASH_SOURCE: FIREWALL - was empty - Assign default: 'Firewalld'"
  fi
fi

case $FIREWALL in
  Install_IPtables)
  echo "procesing..."
  sudo systemctl mask firewalld
  sudo service firewalld stop
  sudo systemctl disable firewalld
  sudo yum -y remove firewalld
  sudo yum -y --skip-broken install iptables-services
  sudo systemctl enable iptables
  sudo service iptables start
  # SSH = 2244
  sudo iptables -I INPUT -m state --state NEW -m tcp -p tcp -m multiport --dports 80,443,2244 -j ACCEPT
  # NTP
  #sudo iptables -I INPUT -m state --state NEW -m udp -p udp -m multiport --dports 123 -j ACCEPT
  sudo service iptables save
  sudo service iptables stop
  sudo service iptables start
  break;;
  Install_Firewalld)
  echo "procesing..."
  sudo service iptables stop
  sudo systemctl disable iptables
  sudo service ip6tables stop
  sudo systemctl disable ip6tables
  sudo yum -y remove iptables ip6tables
  sudo yum -y --skip-broken install firewalld
  sudo systemctl enable firewalld
  sudo systemctl start firewalld.service
  sudo firewall-cmd --permanent --add-port=80/tcp
  sudo firewall-cmd --permanent --add-service http
  sudo firewall-cmd --permanent --add-port=443/tcp
  sudo firewall-cmd --permanent --add-service https
  # SSH = 2244
  sudo firewall-cmd --permanent --add-port=2244/tcp
  # Webmin
  #sudo firewall-cmd --permanent --add-port=10000/tcp
  # NTP
  #sudo firewall-cmd --permanent --add-service=ntp
  sudo firewall-cmd --reload
  sudo systemctl restart firewalld.service
  break;;
  *)
  echo "procesing..."
  sudo service iptables stop
  sudo systemctl disable iptables
  sudo service ip6tables stop
  sudo systemctl disable ip6tables
  sudo service firewalld stop
  sudo systemctl disable firewalld
  break;;
esac