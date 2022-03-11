#!/bin/bash

printf "%(%H:%M:%S - Entrando en: $BASH_SOURCE)T\n" -1

if [ ! -d /etc/httpd/conf.vhosts.d ]; then
  /bin/sudo mkdir /etc/httpd/conf.vhosts.d >>${SCRIPT_DIR}/debug.log
fi
SCRIPT_DIR="${3}"
if [[ -z "${SCRIPT_DIR}" ]]; then
  SCRIPT_DIR="$(/bin/cat /root/wl_lemp_lamp/globalVariable/SCRIPT_DIR.txt)"
  if [[ -z "${SCRIPT_DIR}" ]]; then
    /bin/echo "ERROR CRITIC $BASH_SOURCE: SCRIPT_DIR - empty"
    exit 1
    return 1
  fi
fi
SERVER_NAME="${1}"
if [[ -z "${SERVER_NAME}" ]]; then
  SERVER_NAME="$(/bin/cat /root/wl_lemp_lamp/globalVariable/SERVER_NAME.txt)"
  if [[ -z "${SERVER_NAME}" ]]; then
    /bin/echo "ERROR CRITIC $BASH_SOURCE: SERVER_NAME = empty"
    exit 1
    return 1
  fi
fi
SERVER_NAME_MAIN="${2}"
if [[ -z "${SERVER_NAME_MAIN}" ]]; then
  SERVER_NAME_MAIN="$(/bin/cat /root/wl_lemp_lamp/globalVariable/SERVER_NAME_MAIN.txt)"
  if [[ -z "${SERVER_NAME_MAIN}" ]]; then
    /bin/echo "ERROR CRITIC $BASH_SOURCE: SERVER_NAME_MAIN = empty"
    exit 1
    return 1
  fi
fi
PARAMS_SSL="${4}"
if [[ -z "${PARAMS_SSL}" ]]; then
  PARAMS_SSL="$(/bin/cat ${SCRIPT_DIR}/globalVariable/PARAMS_SSL.txt)"
  if [[ -z "${PARAMS_SSL}" ]]; then
    PARAMS_SSL="80"
    /bin/sudo /bin/echo "80" >${SCRIPT_DIR}/globalVariable/PARAMS_SSL.txt
  fi
fi
if [ ! -d /var/www/${SERVER_NAME} ]; then
  /bin/sudo mkdir /var/www/${SERVER_NAME} >>${SCRIPT_DIR}/debug.log
  /bin/sudo mkdir /var/www/${SERVER_NAME}/public_html >>${SCRIPT_DIR}/debug.log
fi

/bin/sudo /bin/echo "" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "<VirtualHost *:443>" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  ServerName                       ${SERVER_NAME}:443" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  ServerAlias                      ${SERVER_NAME}" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  DocumentRoot                     \"/var/www/${SERVER_NAME}/public_html\"" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  SSLEngine                        on" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  SSLProtocol                      all -SSLv3 -TLSv1 -TLSv1.1" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  SSLProxyProtocol                 all -SSLv3 -TLSv1 -TLSv1.1" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  SSLCipherSuite                   ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
if [[ ! "$SERVER_NAME_MAIN" =~ "localhost" ]]; then
  /bin/sudo /bin/echo "  SSLCertificateFile               /etc/letsencrypt/live/${SERVER_NAME_MAIN}/cert.pem" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
  /bin/sudo /bin/echo "  #SSLCertificateFile               /etc/letsencrypt/live/${SERVER_NAME_MAIN}/fullchain.pem" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
  /bin/sudo /bin/echo "  SSLCertificateKeyFile            /etc/letsencrypt/live/${SERVER_NAME_MAIN}/privkey.pem" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
  /bin/sudo /bin/echo "  SSLCertificateChainFile          /etc/letsencrypt/live/${SERVER_NAME_MAIN}/chain.pem" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
else
  /bin/sudo /bin/echo "  SSLCertificateFile               /etc/pki/tls/certs/localhost.crt" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
  /bin/sudo /bin/echo "  SSLCertificateKeyFile            /etc/pki/tls/private/localhost.key" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
fi
/bin/sudo /bin/echo "  SSLHonorCipherOrder              on" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  SSLCompression                   off" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  SSLSessionTickets                off" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  SSLUseStapling                   on" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  SSLStaplingResponderTimeout      5" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  SSLStaplingReturnResponderErrors off" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  ErrorLog                         \"logs/${SERVER_NAME}_ssl.log\"" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  TransferLog                      \"logs/${SERVER_NAME}_access_ssl.log\"" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  LogLevel                         notice" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  CustomLog                        \"logs/${SERVER_NAME}_request_ssl.log\" \\" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "                                   \"%t %h %{SSL_PROTOCOL}x %{SSL_CIPHER}x \\\"%r\\\" %b\"" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  RewriteEngine                    On" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  <Directory \"/var/www/${SERVER_NAME}/public_html\">" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "    Options                        -Indexes -MultiViews" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "    AllowOverride                  all" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "    SetOutputFilter                DEFLATE" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo '    SetEnvIfNoCase                 Request_URI  \' >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo '                                   \.(?:gif|jpe?g|png)$ no-gzip dont-vary' >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo '    SetEnvIfNoCase                 Request_URI  \' >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo '                                   \.(?:exe|t?gz|zip|gz2|sit|rar|swf|flv|mp3|mov)$ no-gzip dont-vary' >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "    <Limit PUT DELETE CONNECT OPTIONS CUSTOM TRACK PATCH COPY LINK UNLINK PURGE LOCK UNLOCK PROPFIND VIEW >" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "      Order                        deny,allow" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "      Deny                         from all" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "    </Limit>" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "    <LimitExcept GET POST HEAD >" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "      Order                        deny,allow" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "      Deny                         from all" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "    </LimitExcept>" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  </Directory>" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf

/bin/sudo /bin/sh ${SCRIPT_DIR}/include/config/apache_add_headers.sh "${SCRIPT_DIR}" "${SERVER_NAME}" "443"

/bin/sudo /bin/echo "</VirtualHost>" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "" >>/etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
