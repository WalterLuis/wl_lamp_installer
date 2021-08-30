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

if ! rpm -qa | grep -q "epel-release"; then
  /bin/sudo /bin/yum -y -q --skip-broken install epel-release > /dev/null 2>&1
fi
if ! rpm -qa | grep -q "epel-release"; then
  /bin/echo "'epel-release' is required, check your connection from port 443"
  exit 1
  return 1
fi
#if ! rpm -qa | grep -q "webtatic-release"; then
# /bin/sudo rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm >> ${SCRIPT_DIR}/debug.log
#fi
#if ! rpm -qa | grep -q "webtatic-release"; then
# /bin/echo "'webtatic-release' is required, check your connection from port 443"
# exit 1
# return 1
#fi
if ! rpm -qa | grep -q "ius-release"; then
  /bin/sudo rpm -Uvh https://centos7.iuscommunity.org/ius-release.rpm >> ${SCRIPT_DIR}/debug.log
fi
if ! rpm -qa | grep -q "ius-release"; then
  /bin/echo "'ius-release' is required, check your connection from port 443"
  exit 1
  return 1
fi

if rpm -qa | grep -q "nodejs"; then
  /bin/sudo /bin/yum -y -q --skip-broken remove nodejs > /dev/null 2>&1
fi

/bin/sudo curl -sL https://rpm.nodesource.com/setup_10.x | bash -

/bin/sudo /bin/yum clean all > /dev/null 2>&1
/bin/sudo /bin/rm -Rf /var/cache/yum/ >> ${SCRIPT_DIR}/debug.log

/bin/echo "######################################################################################"
/bin/echo "######   NOTE:"
/bin/echo "######   If this is the first time you update the system, this process may be delayed"
/bin/echo "######################################################################################"
printf "%(%H:%M:%S - UPDATING........)T\n" -1
/bin/sudo /bin/yum -y -q --skip-broken update > /dev/null 2>&1
printf "%(%H:%M:%S - UPGRADING........)T\n" -1
/bin/sudo /bin/yum -y -q --skip-broken upgrade > /dev/null 2>&1

if ! rpm -qa | grep -q "git"; then
  /bin/sudo /bin/yum -y -q --skip-broken install git > /dev/null 2>&1
fi
if ! rpm -qa | grep -q "git"; then
  /bin/echo "'git' is required, check your connection from port 443"
  exit 1
  return 1
fi
if ! rpm -qa | grep -q "pwgen"; then
  /bin/sudo /bin/yum -y -q --skip-broken install pwgen > /dev/null 2>&1
fi
if ! rpm -qa | grep -q "pwgen"; then
  /bin/echo "'pwgen' is required, check your connection from port 443"
  exit 1
  return 1
fi
if ! rpm -qa | grep -q "iftop"; then
  /bin/sudo /bin/yum -y -q --skip-broken install iftop > /dev/null 2>&1
fi
if ! rpm -qa | grep -q "iftop"; then
  /bin/echo "'iftop' is required, check your connection from port 443"
  exit 1
  return 1
fi
if ! rpm -qa | grep -q "libzip"; then
  /bin/sudo /bin/yum -y -q --skip-broken install libzip > /dev/null 2>&1
fi
if ! rpm -qa | grep -q "libzip"; then
  /bin/echo "'libzip' is required, check your connection from port 443"
  exit 1
  return 1
fi
if ! rpm -qa | grep -q "unzip"; then
  /bin/sudo /bin/yum -y -q --skip-broken install unzip > /dev/null 2>&1
fi
if ! rpm -qa | grep -q "unzip"; then
  /bin/echo "'unzip' is required, check your connection from port 443"
  exit 1
  return 1
fi
if ! rpm -qa | grep -q "bind-utils"; then
  /bin/sudo /bin/yum -y -q --skip-broken install bind-utils > /dev/null 2>&1
fi
if ! rpm -qa | grep -q "bind-utils"; then
  /bin/echo "'bind-utils' is required, check your connection from port 443"
  exit 1
  return 1
fi
if ! rpm -qa | grep -q "curl"; then
  /bin/sudo /bin/yum -y -q --skip-broken install curl > /dev/null 2>&1
fi
if ! rpm -qa | grep -q "curl"; then
  /bin/echo "'curl' is required, check your connection from port 443"
  exit 1
  return 1
fi
if ! rpm -qa | grep -q "net-tools"; then
  /bin/sudo /bin/yum -y -q --skip-broken install net-tools > /dev/null 2>&1
fi
if ! rpm -qa | grep -q "net-tools"; then
  /bin/echo "'net-tools' is required, check your connection from port 443"
  exit 1
  return 1
fi
if ! rpm -qa | grep -q "memcached"; then
  /bin/sudo /bin/yum -y -q --skip-broken install memcached > /dev/null 2>&1
fi
if ! rpm -qa | grep -q "memcached"; then
  /bin/echo "'memcached' is required, check your connection from port 443"
  exit 1
  return 1
fi
if ! rpm -qa | grep -q "nano"; then
  /bin/sudo /bin/yum -y -q --skip-broken install nano > /dev/null 2>&1
fi
if ! rpm -qa | grep -q "nano"; then
  /bin/echo "'nano' is required, check your connection from port 443"
  exit 1
  return 1
fi
if ! rpm -qa | grep -q "gcc-c++"; then
  /bin/sudo /bin/yum -y -q --skip-broken install gcc-c++ > /dev/null 2>&1
fi
if ! rpm -qa | grep -q "gcc-c++"; then
  /bin/echo "'gcc-c++' is required, check your connection from port 443"
  exit 1
  return 1
fi
if ! rpm -qa | grep -q "make"; then
  /bin/sudo /bin/yum -y -q --skip-broken install make > /dev/null 2>&1
fi
if ! rpm -qa | grep -q "make"; then
  /bin/echo "'make' is required, check your connection from port 443"
  exit 1
  return 1
fi
if ! rpm -qa | grep -q "nodejs"; then
  /bin/sudo /bin/yum -y -q --skip-broken install nodejs > /dev/null 2>&1
fi
if ! rpm -qa | grep -q "nodejs"; then
  /bin/echo "'nodejs' is required, check your connection from port 443"
  exit 1
  return 1
fi

#ip addr == ifconfig
