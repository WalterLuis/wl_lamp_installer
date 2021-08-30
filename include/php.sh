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
PHP_VERSION="$(/bin/cat ${SCRIPT_DIR}/globalVariable/PHP_VERSION.txt)"
if [[ -z "${PHP_VERSION}" ]]; then
  /bin/sudo /bin/echo "php73" > ${SCRIPT_DIR}/globalVariable/PHP_VERSION.txt
  PHP_VERSION="$(/bin/cat ${SCRIPT_DIR}/globalVariable/PHP_VERSION.txt)"
fi

case ${PHP_VERSION} in
  "php56u")
    /bin/sudo /bin/yum -y -q --skip-broken install php56u-common > /dev/null 2>&1
    /bin/sudo /bin/yum -y -q --skip-broken install php56u php56u-mysqlnd php56u-pdo php56u-gd php56u-imap php56u-ldap php56u-xml php56u-intl php56u-soap php56u-mbstring php56u-pear php56u-opcache php56u-mcrypt php56u-pecl-apcu php56u-tidy php56u-cli php56u-bcmath php56u-debuginfo php56u-embedded php56u-xmlrpc php56u-fpm-httpd php56u-json > /dev/null 2>&1
    if ! rpm -qa | grep -q "php56u-common"; then
      /bin/echo "'php56u-common' is required, check your connection from port 443"
      exit 1
      return 1
    fi
  ;;
  "php71u")
    /bin/sudo /bin/yum -y -q --skip-broken install php71u-common > /dev/null 2>&1
    /bin/sudo /bin/yum -y -q --skip-broken install php71u-bcmath php71u-cli php71u-dba php71u-dbg php71u-debuginfo php71u-embedded php71u-enchant php71u-fpm php71u-fpm-httpd php71u-gd php71u-gmp php71u-imap php71u-interbase php71u-intl php71u-ioncube-loader php71u-json php71u-ldap php71u-mbstring php71u-mcrypt php71u-mysqlnd php71u-odbc php71u-opcache php71u-pdo php71u-pdo-dblib php71u-pecl-apcu php71u-pecl-apcu-panel php71u-pecl-geoip php71u-pecl-igbinary php71u-pecl-imagick php71u-pecl-memcached php71u-pecl-mongodb php71u-pecl-oauth php71u-pecl-redis php71u-process php71u-recode php71u-snmp php71u-soap php71u-tidy php71u-xml php71u-xmlrpc > /dev/null 2>&1
    if ! rpm -qa | grep -q "php71u-common"; then
      /bin/echo "'php71u-common' is required, check your connection from port 443"
      exit 1
      return 1
    fi
  ;;
  "php72u")
    /bin/sudo /bin/yum -y -q --skip-broken install php72u-common > /dev/null 2>&1
    /bin/sudo /bin/yum -y -q --skip-broken install php72u-bcmath php72u-cli php72u-dba php72u-dbg php72u-debuginfo php72u-embedded php72u-enchant php72u-fpm php72u-fpm-httpd php72u-gd php72u-gmp php72u-imap php72u-interbase php72u-intl php72u-ioncube-loader php72u-json php72u-ldap php72u-mbstring php72u-mysqlnd php72u-odbc php72u-opcache php72u-pdo php72u-pdo-dblib php72u-pecl-apcu php72u-pecl-apcu-panel php72u-pecl-geoip php72u-pecl-igbinary php72u-pecl-imagick php72u-pecl-memcached php72u-pecl-mongodb php72u-pecl-oauth php72u-pecl-redis php72u-process php72u-recode php72u-snmp php72u-soap php72u-sodium php72u-tidy php72u-xml php72u-xmlrpc > /dev/null 2>&1
    if ! rpm -qa | grep -q "php72u-common"; then
      /bin/echo "'php72u-common' is required, check your connection from port 443"
      exit 1
      return 1
    fi
  ;;
  "php73")
    # ALL with xdebug a devel -  php73-bcmath php73-cli php73-common php73-dba php73-dbg php73-devel php73-embedded php73-enchant php73-fpm php73-fpm-httpd php73-fpm-nginx php73-gd php73-gmp php73-imap php73-interbase php73-intl php73-json php73-ldap php73-mbstring php73-mysqlnd php73-odbc php73-opcache php73-pdo php73-pdo-dblib php73-pecl-amqp php73-pecl-apcu php73-pecl-apcu-devel php73-pecl-apcu-panel php73-pecl-geoip php73-pecl-igbinary php73-pecl-igbinary-devel php73-pecl-imagick php73-pecl-imagick-devel php73-pecl-lzf php73-pecl-memcached php73-pecl-mongodb php73-pecl-msgpack php73-pecl-msgpack-devel php73-pecl-redis php73-pecl-smbclient php73-pecl-xdebug php73-pecl-yaml php73-pgsql php73-process php73-pspell php73-recode php73-snmp php73-soap php73-sodium php73-tidy php73-xml php73-xmlrpc 

    /bin/sudo /bin/yum -y -q --skip-broken install php73-common > /dev/null 2>&1

    /bin/sudo /bin/yum -y -q --skip-broken install php73-bcmath php73-cli php73-dba php73-dbg php73-embedded php73-enchant php73-fpm php73-fpm-httpd php73-gd php73-gmp php73-imap php73-interbase php73-intl php73-json php73-ldap php73-mbstring php73-mysqlnd php73-odbc php73-opcache php73-pdo php73-pdo-dblib php73-pecl-amqp php73-pecl-apcu php73-pecl-apcu-panel php73-pecl-geoip php73-pecl-igbinary php73-pecl-imagick php73-pecl-lzf php73-pecl-memcached php73-pecl-mongodb php73-pecl-msgpack php73-pecl-redis php73-pecl-smbclient php73-pecl-yaml php73-process php73-pspell php73-recode php73-snmp php73-soap php73-sodium php73-tidy php73-xml php73-xmlrpc > /dev/null 2>&1
    if ! rpm -qa | grep -q "php73-common"; then
      /bin/echo "'php73-common' is required, check your connection from port 443"
      exit 1
      return 1
    fi
  ;;
  *)
    /bin/echo "WARNING - A php version was not selected and will not be installed"
  ;;
esac

/bin/sudo /bin/sh ${SCRIPT_DIR}/include/config/php.sh "${SCRIPT_DIR}"
