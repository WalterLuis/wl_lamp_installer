#!/bin/bash

printf "%(%H:%M:%S - Entrando en: $BASH_SOURCE)T\n" -1

SCRIPT_DIR="${1}"
if [[ -z "${SCRIPT_DIR}" ]]; then
  SCRIPT_DIR="$(/bin/cat ${SCRIPT_DIR}/globalVariable/SCRIPT_DIR.txt)"
  if [[ -z "${SCRIPT_DIR}" ]]; then
    /bin/echo "ERROR CRITIC $BASH_SOURCE: SCRIPT_DIR - empty"
    exit 1
    return 1
  fi
fi
SERVER_NAME="${2}"
if [[ -z "${SERVER_NAME}" ]]; then
  SERVER_NAME="$(/bin/cat ${SCRIPT_DIR}/globalVariable/SERVER_NAME.txt)"
  if [[ -z "${SERVER_NAME}" ]]; then
    /bin/echo "ERROR CRITIC $BASH_SOURCE: SERVER_NAME = empty"
    exit 1
    return 1
  fi
fi
PARAMS_SSL="${3}"
if [[ -z "${PARAMS_SSL}" ]]; then
  PARAMS_SSL="$(/bin/cat ${SCRIPT_DIR}/globalVariable/PARAMS_SSL.txt)"
  if [[ -z "${PARAMS_SSL}" ]]; then
    PARAMS_SSL="80"
    /bin/sudo /bin/echo "80" > ${SCRIPT_DIR}/globalVariable/PARAMS_SSL.txt
  fi
fi

# https://scotthelme.co.uk/hardening-your-http-response-headers/

/bin/sudo /bin/echo "  Header unset Cache-Control" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  Header always set Cache-Control \"private, no-cache, no-store, must-revalidate, post-check=0, pre-check=0\"" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf

/bin/sudo /bin/echo "  Header unset Cache-Control" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  Header always set Pragma \"no-cache\"" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf

/bin/sudo /bin/echo "  Header unset Access-Control-Request-Method" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  Header always set Access-Control-Request-Method \"GET, POST, PUT, DELETE, HEAD\"" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf

/bin/sudo /bin/echo "  Header unset Access-Control-Request-Headers" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  Header always set Access-Control-Request-Headers \"Accept, Accept-Encoding, Accept-Language, Connection, Content-Length, Content-Type, Cookie, Host, Origin, User-Agent, X-Requested-With\"" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf

/bin/sudo /bin/echo "  Header unset Access-Control-Allow-Origin" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  Header always set Access-Control-Allow-Origin \"${SERVER_NAME}\"" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf

/bin/sudo /bin/echo "  Header unset Access-Control-Allow-Methods" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  Header always set Access-Control-Allow-Methods \"GET, POST, PUT, DELETE, HEAD\"" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf

/bin/sudo /bin/echo "  Header unset Access-Control-Allow-Headers" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  Header always set Access-Control-Allow-Headers \"Accept-Charset, Access-Control-Allow-Methods, Cache-Control, Connection, Content-Length, Content-Security-Policy, Content-Type, Date, Expect-CT, Expires, Feature-Policy, Keep-Alive, Pragma, Public-Key-Pins, Referrer-Policy, Server, Strict-Transport-Security, X-Content-Type-Options, X-Frame-Options, X-Permitted-Cross-Domain-Policies, X-Powered-By, X-Robots-Tag, X-XSS-Protection, X-API-KEY, X-ENCRYPTED, X-TOKEN, X-PARENT-ID, X-RAW-DATA, X-ROW-LIMIT, X-ROW-OFFSET, X-FIELDS, X-CONDITION\"" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf

/bin/sudo /bin/echo "  Header unset Access-Control-Max-Age" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  Header always set Access-Control-Max-Age \"43200\"" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf

/bin/sudo /bin/echo "  Header unset Accept-Charset" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  Header always set Accept-Charset \"utf-8, iso-8859-1\"" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf

/bin/sudo /bin/echo "  Header unset Server" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  Header always set Server \"\"" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf

/bin/sudo /bin/echo "  Header unset X-Powered-By" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  Header always set X-Powered-By \"\"" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf

/bin/sudo /bin/echo "  Header unset X-Frame-Options" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  Header always set X-Frame-Options \"SAMEORIGIN\"" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf

/bin/sudo /bin/echo "  Header unset X-XSS-Protection" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  Header always set X-XSS-Protection \"1; mode=block\"" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf

/bin/sudo /bin/echo "  Header unset X-Content-Type-Options" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  Header always set X-Content-Type-Options \"nosniff\"" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf

/bin/sudo /bin/echo "  Header unset X-Robots-Tag" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  Header always set X-Robots-Tag \"none\"" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf

/bin/sudo /bin/echo "  Header unset X-Permitted-Cross-Domain-Policies" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  Header always set X-Permitted-Cross-Domain-Policies \"none\"" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf

/bin/sudo /bin/echo "  Header unset Expect-CT" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  Header always set Expect-CT \"max-age=43200, enforce, report-uri='https://wtyypxwhbcxt3xggratvfwjcfyuzr.report-uri.com/r/d/ct/enforce'\"" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf

/bin/sudo /bin/echo "  Header unset Referrer-Policy" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  Header always set Referrer-Policy \"no-referrer\"" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf

/bin/sudo /bin/echo "  Header unset Strict-Transport-Security" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
/bin/sudo /bin/echo "  Header always set Strict-Transport-Security \"max-age=31536000; includeSubDomains; preload\"" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf

/bin/sudo /bin/echo "  Header unset Feature-Policy" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
# notifications '*.itop.es'; push '*.itop.es'; << This Feature-Policy header is not properly set.
# ; vibrate 'self'                             << no reconocido por Chrome
/bin/sudo /bin/echo "  Header always set Feature-Policy \"geolocation 'self'; midi 'self'; sync-xhr 'self'; microphone 'self'; camera 'self'; magnetometer 'self'; gyroscope 'self'; speaker 'self'; fullscreen 'self'; payment 'self'\"" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf

/bin/sudo /bin/echo "  Header unset Content-Security-Policy" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
#/bin/sudo /bin/echo "  Header always set Content-Security-Policy \"default-src ${SERVER_NAME} 'self' blob:; img-src 'self' data: a.tile.openstreetmap.org b.tile.openstreetmap.org c.tile.openstreetmap.org; style-src 'self' 'unsafe-inline'; script-src 'self' 'unsafe-inline'; form-action 'self'; worker-src blob:\"" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
# ; plugin-types 'self'                        << sin configurar: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy/plugin-types
# ; sandbox 'allow-same-origin'                << los navegadores no detectan la configuración: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy/sandbox
/bin/sudo /bin/echo "  Header always set Content-Security-Policy \"default-src 'none' *.itop.es *.curieplatform.com; base-uri ${SERVER_NAME}; connect-src 'self'; font-src 'self'; form-action 'self'; frame-ancestors 'self'; img-src 'self' data: a.tile.openstreetmap.org b.tile.openstreetmap.org c.tile.openstreetmap.org; manifest-src 'self'; media-src 'self'; object-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval'; style-src 'self' 'unsafe-inline'; worker-src 'self' blob:; frame-src 'self'\"" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf

if [ "${PARAMS_SSL}" == "443" ]; then
  if [[ ! "$SERVER_NAME_MAIN" =~ "localhost" ]]; then
    /bin/sudo /bin/echo "  Header unset Public-Key-Pins" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
    /bin/sudo /bin/echo "  Header always set Public-Key-Pins \"pin-sha256=''; pin-sha256=''; pin-sha256=''; includeSubdomains; max-age=7889400\"" >> /etc/httpd/conf.vhosts.d/${SERVER_NAME}.conf
  fi
fi
