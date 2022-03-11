#
getHostname() {
  IP_EXT="$(/bin/cat ${SCRIPT_DIR}/globalVariable/IP_EXT.txt)"
  if [[ -z "${IP_EXT}" ]]; then
    getIpExt
    IP_EXT="$(/bin/cat ${SCRIPT_DIR}/globalVariable/IP_EXT.txt)"
  fi
  SERVER_NAME="$(/bin/cat ${SCRIPT_DIR}/globalVariable/SERVER_NAME.txt)"
  if [[ -z "${SERVER_NAME}" ]]; then
    myHostname="$(nslookup ${IP_EXT} | grep name | awk '{print $4 }' | /bin/sed -e 's/.$//')"
    if [[ -z "${myHostname}" ]]; then
      /bin/echo "$(/bin/cat /proc/sys/kernel/hostname)" >${SCRIPT_DIR}/globalVariable/SERVER_NAME.txt
      SERVER_NAME_MAIN="$(/bin/cat ${SCRIPT_DIR}/globalVariable/SERVER_NAME_MAIN.txt)"
      if [[ -z "${SERVER_NAME_MAIN}" ]]; then
        /bin/echo "$(/bin/cat /proc/sys/kernel/hostname)" >${SCRIPT_DIR}/globalVariable/SERVER_NAME_MAIN.txt
      fi
      SERVER_NAME_CERTBOT="$(/bin/cat ${SCRIPT_DIR}/globalVariable/SERVER_NAME_CERTBOT.txt)"
      if [[ -z "${SERVER_NAME_CERTBOT}" ]]; then
        /bin/echo "$(/bin/cat /proc/sys/kernel/hostname)" >${SCRIPT_DIR}/globalVariable/SERVER_NAME_CERTBOT.txt
      fi
    elif [[ "${myHostname}" =~ "localhost.localdomain" ]]; then
      /bin/echo "localhost" >${SCRIPT_DIR}/globalVariable/SERVER_NAME.txt
      SERVER_NAME_MAIN="$(/bin/cat ${SCRIPT_DIR}/globalVariable/SERVER_NAME_MAIN.txt)"
      if [[ -z "${SERVER_NAME_MAIN}" ]]; then
        /bin/echo "localhost" >${SCRIPT_DIR}/globalVariable/SERVER_NAME_MAIN.txt
      fi
      SERVER_NAME_CERTBOT="$(/bin/cat ${SCRIPT_DIR}/globalVariable/SERVER_NAME_CERTBOT.txt)"
      if [[ -z "${SERVER_NAME_CERTBOT}" ]]; then
        /bin/echo "localhost" >${SCRIPT_DIR}/globalVariable/SERVER_NAME_CERTBOT.txt
      fi
    elif [[ "${myHostname}" =~ ".red-" || "${myHostname}" =~ ".speedy" || "${myHostname}" =~ ".telkom" || "${myHostname}" =~ "dynamic" || "${myHostname}" =~ "static" || "${myHostname}" =~ "dynamic" || "${myHostname}" =~ "static" || "${myHostname}" =~ ".arpa" || "${myHostname}" =~ ".dyn" || "${myHostname}" =~ ".ono" ]]; then
      /bin/echo "$(/bin/cat /proc/sys/kernel/hostname)" >${SCRIPT_DIR}/globalVariable/SERVER_NAME.txt
      SERVER_NAME_MAIN="$(/bin/cat ${SCRIPT_DIR}/globalVariable/SERVER_NAME_MAIN.txt)"
      if [[ -z "${SERVER_NAME_MAIN}" ]]; then
        /bin/echo "$(/bin/cat /proc/sys/kernel/hostname)" >${SCRIPT_DIR}/globalVariable/SERVER_NAME_MAIN.txt
      fi
      SERVER_NAME_CERTBOT="$(/bin/cat ${SCRIPT_DIR}/globalVariable/SERVER_NAME_CERTBOT.txt)"
      if [[ -z "${SERVER_NAME_CERTBOT}" ]]; then
        /bin/echo "$(/bin/cat /proc/sys/kernel/hostname)" >${SCRIPT_DIR}/globalVariable/SERVER_NAME_CERTBOT.txt
      fi
    else
      /bin/echo "${myHostname}" >${SCRIPT_DIR}/globalVariable/SERVER_NAME.txt
      SERVER_NAME_MAIN="$(/bin/cat ${SCRIPT_DIR}/globalVariable/SERVER_NAME_MAIN.txt)"
      if [[ -z "${SERVER_NAME_MAIN}" ]]; then
        /bin/echo "${myHostname}" >${SCRIPT_DIR}/globalVariable/SERVER_NAME_MAIN.txt
      fi
      SERVER_NAME_CERTBOT="$(/bin/cat ${SCRIPT_DIR}/globalVariable/SERVER_NAME_CERTBOT.txt)"
      if [[ -z "${SERVER_NAME_CERTBOT}" ]]; then
        /bin/echo "${myHostname}" >${SCRIPT_DIR}/globalVariable/SERVER_NAME_CERTBOT.txt
      fi
    fi
  fi
  return
}
