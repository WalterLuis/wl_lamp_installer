#!/bin/bash

printf "%(%H:%M:%S - Entrando en: $BASH_SOURCE)T\n" -1
if [ ! -f /etc/httpd/conf.d/ssl.conf.itop_backup_first ]; then
  /bin/sudo /bin/cp /etc/httpd/conf.d/ssl.conf /etc/httpd/conf.d/ssl.conf.itop_backup_first
fi
/bin/sudo /bin/cp /etc/httpd/conf.d/ssl.conf /etc/httpd/conf.d/ssl.conf.itop_backup_last

/bin/sudo /bin/echo "Listen 443 https" >/etc/httpd/conf.d/ssl.conf
/bin/sudo /bin/echo "SSLPassPhraseDialog    exec:/usr/libexec/httpd-ssl-pass-dialog" >>/etc/httpd/conf.d/ssl.conf
/bin/sudo /bin/echo "SSLSessionCache        shmcb:/run/httpd/sslcache(512000)" >>/etc/httpd/conf.d/ssl.conf
/bin/sudo /bin/echo "SSLSessionCacheTimeout 300" >>/etc/httpd/conf.d/ssl.conf
/bin/sudo /bin/echo "SSLRandomSeed          startup file:/dev/urandom 512" >>/etc/httpd/conf.d/ssl.conf
/bin/sudo /bin/echo "SSLRandomSeed          connect file:/dev/urandom 512" >>/etc/httpd/conf.d/ssl.conf
/bin/sudo /bin/echo "SSLCryptoDevice        builtin" >>/etc/httpd/conf.d/ssl.conf
/bin/sudo /bin/echo "SSLStaplingCache       shmcb:/var/run/ocsp(128000)" >>/etc/httpd/conf.d/ssl.conf

/bin/sudo /bin/echo "<FilesMatch \"\\.(cgi|shtml|phtml|php)$\">" >>/etc/httpd/conf.d/ssl.conf
# https://httpd.apache.org/docs/2.4/mod/mod_ssl.html#ssloptions
/bin/sudo /bin/echo "  SSLOptions           +StdEnvVars" >>/etc/httpd/conf.d/ssl.conf
/bin/sudo /bin/echo "</FilesMatch>" >>/etc/httpd/conf.d/ssl.conf

/bin/sudo /bin/echo "<Directory \"/var/www/cgi-bin\">" >>/etc/httpd/conf.d/ssl.conf
/bin/sudo /bin/echo "  SSLOptions           +StdEnvVars" >>/etc/httpd/conf.d/ssl.conf
/bin/sudo /bin/echo "</Directory>" >>/etc/httpd/conf.d/ssl.conf

/bin/sudo /bin/echo "BrowserMatch \"MSIE [2-5]\" \\" >>/etc/httpd/conf.d/ssl.conf
/bin/sudo /bin/echo "  nokeepalive          ssl-unclean-shutdown \\" >>/etc/httpd/conf.d/ssl.conf
/bin/sudo /bin/echo "  downgrade-1.0        force-response-1.0" >>/etc/httpd/conf.d/ssl.conf
/bin/sudo /bin/echo "" >>/etc/httpd/conf.d/ssl.conf
