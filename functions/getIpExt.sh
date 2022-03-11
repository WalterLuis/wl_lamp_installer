#
getIpExt() {
  myIP="$(curl -s ifconfig.co)"
  /bin/echo "${myIP}" >${SCRIPT_DIR}/globalVariable/IP_EXT.txt
  return
}
