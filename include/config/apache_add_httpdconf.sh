#!/bin/bash

printf "%(%H:%M:%S - Entrando en: $BASH_SOURCE)T\n" -1

if [ ! -d /etc/httpd/conf.vhosts.d ]; then
  /bin/sudo mkdir /etc/httpd/conf.vhosts.d >> ${SCRIPT_DIR}/debug.log
fi
SERVER_NAME="${1}"
if [[ -z "${SERVER_NAME}" ]]; then
  /bin/echo "ERROR CRITIC $BASH_SOURCE: SERVER_NAME = empty"
  exit 1
  return 1
fi
if [ ! -d /var/www/${SERVER_NAME} ]; then
  /bin/sudo mkdir /var/www/${SERVER_NAME} >> ${SCRIPT_DIR}/debug.log
  /bin/sudo mkdir /var/www/${SERVER_NAME}/public_html >> ${SCRIPT_DIR}/debug.log
fi

if [ ! -f /etc/httpd/conf/httpd.conf.itop_backup_first ]; then
  /bin/sudo /bin/cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.itop_backup_first
fi
/bin/sudo /bin/cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.itop_backup_last

/bin/sudo /bin/echo "ServerRoot            \"/etc/httpd\"" > /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "Listen                80" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "Include               conf.modules.d/*.conf" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "User                  apache" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "Group                 apache" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "ServerAdmin           root@${SERVER_NAME}" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "ServerName            ${SERVER_NAME}" >> /etc/httpd/conf/httpd.conf

/bin/sudo /bin/echo "<Directory />" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "  AllowOverride       none" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "  Require             all denied" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "</Directory>" >> /etc/httpd/conf/httpd.conf

/bin/sudo /bin/echo "DocumentRoot \"/var/www/${SERVER_NAME}/public_html\"" >> /etc/httpd/conf/httpd.conf

/bin/sudo /bin/echo "<Directory \"/var/www\">" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "  AllowOverride       all" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "  Require             all granted" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "</Directory>" >> /etc/httpd/conf/httpd.conf

/bin/sudo /bin/echo "<IfModule dir_module>" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "  DirectoryIndex      index.php index.html" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "</IfModule>" >> /etc/httpd/conf/httpd.conf

/bin/sudo /bin/echo '<Files "\.(.*|*.md|*.ps1|*.yml|*.dist|composer.json|package.json)$">' >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "  Require             all denied" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "</Files>" >> /etc/httpd/conf/httpd.conf

/bin/sudo /bin/echo "ErrorLog              \"logs/httpd.log\"" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "LogLevel              emerg" >> /etc/httpd/conf/httpd.conf

/bin/sudo /bin/echo "<IfModule log_config_module>" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo '  LogFormat           "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined' >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo '  LogFormat           "%h %l %u %t \"%r\" %>s %b" common' >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "  <IfModule logio_module>" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo '    LogFormat         "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\" %I %O" combinedio' >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "  </IfModule>" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo '  CustomLog           "logs/httpd_access.log" combined' >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "</IfModule>" >> /etc/httpd/conf/httpd.conf

/bin/sudo /bin/echo "<IfModule alias_module>" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "  ScriptAlias         /cgi-bin/ \"/var/www/cgi-bin/\"" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "</IfModule>" >> /etc/httpd/conf/httpd.conf

/bin/sudo /bin/echo "<Directory \"/var/www/cgi-bin\">" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "  AllowOverride       all" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "  Options             None" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "  Require             all granted" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "</Directory>" >> /etc/httpd/conf/httpd.conf

/bin/sudo /bin/echo "<IfModule mime_module>" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "  TypesConfig         /etc/mime.types" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "  AddType             application/x-compress .Z" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "  AddType             application/x-gzip .gz .tgz" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "  AddOutputFilter     INCLUDES .shtml" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "</IfModule>" >> /etc/httpd/conf/httpd.conf

/bin/sudo /bin/echo "AddDefaultCharset     UTF-8" >> /etc/httpd/conf/httpd.conf

/bin/sudo /bin/echo "<IfModule mime_magic_module>" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "  MIMEMagicFile       conf/magic" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "</IfModule>" >> /etc/httpd/conf/httpd.conf

/bin/sudo /bin/echo "#EnableMMAP           off" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "EnableSendfile        on" >> /etc/httpd/conf/httpd.conf

/bin/sudo /bin/echo "LimitRequestFields    100000" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "LimitRequestFieldSize 1342177280" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "LimitRequestLine      1342177280" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "LimitRequestBody      1342177280" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "ServerSignature       off" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "ServerTokens          prod" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "TraceEnable           off" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "FileETag              None" >> /etc/httpd/conf/httpd.conf

/bin/sudo /bin/echo "" >> /etc/httpd/conf/httpd.conf

# Method OLD
#/bin/sudo /bin/echo '<VirtualHost _default_:80>' >> /etc/httpd/conf/httpd.conf
#/bin/sudo /bin/echo "  RewriteEngine On" >> /etc/httpd/conf/httpd.conf
#/bin/sudo /bin/echo '  RewriteCond %{HTTPS} !=on [OR]' >> /etc/httpd/conf/httpd.conf
#/bin/sudo /bin/echo '  RewriteCond %{SERVER_PORT} !=443' >> /etc/httpd/conf/httpd.conf
#/bin/sudo /bin/echo '  RewriteRule ^(.*)$ https://%{SERVER_NAME}:443/ [R,L]' >> /etc/httpd/conf/httpd.conf
#/bin/sudo /bin/echo "</VirtualHost>" >> /etc/httpd/conf/httpd.conf

#/bin/sudo /bin/echo "" >> /etc/httpd/conf/httpd.conf

/bin/sudo /bin/echo "IncludeOptional conf.d/*.conf" >> /etc/httpd/conf/httpd.conf
/bin/sudo /bin/echo "IncludeOptional conf.vhosts.d/*.conf" >> /etc/httpd/conf/httpd.conf

/bin/sudo /bin/echo "" >> /etc/httpd/conf/httpd.conf
