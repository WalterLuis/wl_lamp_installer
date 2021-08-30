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

SESTATUS="${2}"
if [[ -z "${SESTATUS}" ]]; then
  SESTATUS="$(/bin/cat ${SCRIPT_DIR}/globalVariable/SESTATUS.txt)"
  if [[ -z "${SESTATUS}" ]]; then
    SESTATUS="permissive"
    /bin/sudo /bin/echo "permissive" > ${SCRIPT_DIR}/globalVariable/SESTATUS.txt
  fi
fi

case ${SESTATUS} in
  "enforcing")
    /bin/echo "SELinux security policy is enforced"
    /bin/sudo setenforce 1
    /bin/sudo /bin/sed -i 's/SELINUX=disabled/SELINUX=enforcing/g' '/etc/selinux/config'
    /bin/sudo /bin/sed -i 's/SELINUX=permissive/SELINUX=enforcing/g' '/etc/selinux/config'
    /bin/sudo setsebool -P httpd_can_network_connect 1
    /bin/sudo setsebool -P httpd_can_network_connect_db 1
    /bin/sudo setsebool -P httpd_unified 1
    /bin/sudo setsebool -P polyinstantiation_enabled 1
  ;;
  "permissive")
    /bin/echo "SELinux prints warnings instead of enforcing"
    /bin/sudo setenforce 1
    /bin/sudo /bin/sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' '/etc/selinux/config'
    /bin/sudo /bin/sed -i 's/SELINUX=disabled/SELINUX=permissive/g' '/etc/selinux/config'
    /bin/sudo setsebool -P httpd_can_network_connect 1
    /bin/sudo setsebool -P httpd_can_network_connect_db 1
    /bin/sudo setsebool -P httpd_unified 1
    /bin/sudo setsebool -P polyinstantiation_enabled 1
  ;;
  "disabled")
    /bin/echo "No SELinux policy is loaded"
    /bin/sudo setsebool -P httpd_can_network_connect 1
    /bin/sudo setsebool -P httpd_can_network_connect_db 1
    /bin/sudo setsebool -P httpd_unified 1
    /bin/sudo setsebool -P polyinstantiation_enabled 1
    /bin/sudo setenforce 0
    /bin/sudo /bin/sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' '/etc/selinux/config'
    /bin/sudo /bin/sed -i 's/SELINUX=permissive/SELINUX=disabled/g' '/etc/selinux/config'
  ;;
  "all")
    /bin/echo "Default values"
    /bin/sudo setenforce 1
    /bin/sudo /bin/sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' '/etc/selinux/config'
    /bin/sudo /bin/sed -i 's/SELINUX=disabled/SELINUX=permissive/g' '/etc/selinux/config'
    /bin/echo "abrt_anon_write"
    /bin/sudo setsebool -P abrt_anon_write 0
    /bin/echo "abrt_handle_event"
    /bin/sudo setsebool -P abrt_handle_event 0
    /bin/echo "abrt_upload_watch_anon_write"
    /bin/sudo setsebool -P abrt_upload_watch_anon_write 1
    /bin/echo "antivirus_can_scan_system"
    /bin/sudo setsebool -P antivirus_can_scan_system 0
    /bin/echo "antivirus_use_jit"
    /bin/sudo setsebool -P antivirus_use_jit 0
    /bin/echo "auditadm_exec_content"
    /bin/sudo setsebool -P auditadm_exec_content 1
    /bin/echo "authlogin_nsswitch_use_ldap"
    /bin/sudo setsebool -P authlogin_nsswitch_use_ldap 0
    /bin/echo "authlogin_radius"
    /bin/sudo setsebool -P authlogin_radius 0
    /bin/echo "authlogin_yubikey"
    /bin/sudo setsebool -P authlogin_yubikey 0
    /bin/echo "awstats_purge_apache_log_files"
    /bin/sudo setsebool -P awstats_purge_apache_log_files 0
    /bin/echo "boinc_execmem"
    /bin/sudo setsebool -P boinc_execmem 1
    /bin/echo "cdrecord_read_content"
    /bin/sudo setsebool -P cdrecord_read_content 0
    /bin/echo "cluster_can_network_connect"
    /bin/sudo setsebool -P cluster_can_network_connect 0
    /bin/echo "cluster_manage_all_files"
    /bin/sudo setsebool -P cluster_manage_all_files 0
    /bin/echo "cluster_use_execmem"
    /bin/sudo setsebool -P cluster_use_execmem 0
    /bin/echo "cobbler_anon_write"
    /bin/sudo setsebool -P cobbler_anon_write 0
    /bin/echo "cobbler_can_network_connect"
    /bin/sudo setsebool -P cobbler_can_network_connect 0
    /bin/echo "cobbler_use_cifs"
    /bin/sudo setsebool -P cobbler_use_cifs 0
    /bin/echo "cobbler_use_nfs"
    /bin/sudo setsebool -P cobbler_use_nfs 0
    /bin/echo "collectd_tcp_network_connect"
    /bin/sudo setsebool -P collectd_tcp_network_connect 0
    /bin/echo "condor_tcp_network_connect"
    /bin/sudo setsebool -P condor_tcp_network_connect 0
    /bin/echo "conman_can_network"
    /bin/sudo setsebool -P conman_can_network 0
    /bin/echo "conman_use_nfs"
    /bin/sudo setsebool -P conman_use_nfs 0
    /bin/echo "container_connect_any"
    /bin/sudo setsebool -P container_connect_any 0
    /bin/echo "cron_can_relabel"
    /bin/sudo setsebool -P cron_can_relabel 0
    /bin/echo "cron_system_cronjob_use_shares"
    /bin/sudo setsebool -P cron_system_cronjob_use_shares 0
    /bin/echo "cron_userdomain_transition"
    /bin/sudo setsebool -P cron_userdomain_transition 1
    /bin/echo "cups_execmem"
    /bin/sudo setsebool -P cups_execmem 0
    /bin/echo "cvs_read_shadow"
    /bin/sudo setsebool -P cvs_read_shadow 0
    /bin/echo "daemons_dump_core"
    /bin/sudo setsebool -P daemons_dump_core 0
    /bin/echo "daemons_enable_cluster_mode"
    /bin/sudo setsebool -P daemons_enable_cluster_mode 0
    /bin/echo "daemons_use_tcp_wrapper"
    /bin/sudo setsebool -P daemons_use_tcp_wrapper 0
    /bin/echo "daemons_use_tty"
    /bin/sudo setsebool -P daemons_use_tty 0
    /bin/echo "dbadm_exec_content"
    /bin/sudo setsebool -P dbadm_exec_content 1
    /bin/echo "dbadm_manage_user_files"
    /bin/sudo setsebool -P dbadm_manage_user_files 0
    /bin/echo "dbadm_read_user_files"
    /bin/sudo setsebool -P dbadm_read_user_files 0
    /bin/echo "deny_execmem"
    /bin/sudo setsebool -P deny_execmem 0
    /bin/echo "deny_ptrace"
    /bin/sudo setsebool -P deny_ptrace 0
    /bin/echo "dhcpc_exec_iptables"
    /bin/sudo setsebool -P dhcpc_exec_iptables 0
    /bin/echo "dhcpd_use_ldap"
    /bin/sudo setsebool -P dhcpd_use_ldap 0
    /bin/echo "domain_can_write_kmsg"
    /bin/sudo setsebool -P domain_can_write_kmsg 0
    /bin/echo "domain_fd_use"
    /bin/sudo setsebool -P domain_fd_use 1
    /bin/echo "domain_kernel_load_modules"
    /bin/sudo setsebool -P domain_kernel_load_modules 0
    /bin/echo "entropyd_use_audio"
    /bin/sudo setsebool -P entropyd_use_audio 1
    /bin/echo "exim_can_connect_db"
    /bin/sudo setsebool -P exim_can_connect_db 0
    /bin/echo "exim_manage_user_files"
    /bin/sudo setsebool -P exim_manage_user_files 0
    /bin/echo "exim_read_user_files"
    /bin/sudo setsebool -P exim_read_user_files 0
    /bin/echo "fcron_crond"
    /bin/sudo setsebool -P fcron_crond 0
    /bin/echo "fenced_can_network_connect"
    /bin/sudo setsebool -P fenced_can_network_connect 0
    /bin/echo "fenced_can_ssh"
    /bin/sudo setsebool -P fenced_can_ssh 0
    /bin/echo "fips_mode"
    /bin/sudo setsebool -P fips_mode 1
    /bin/echo "ftpd_anon_write"
    /bin/sudo setsebool -P ftpd_anon_write 0
    /bin/echo "ftpd_connect_all_unreserved"
    /bin/sudo setsebool -P ftpd_connect_all_unreserved 0
    /bin/echo "ftpd_connect_db"
    /bin/sudo setsebool -P ftpd_connect_db 0
    /bin/echo "ftpd_full_access"
    /bin/sudo setsebool -P ftpd_full_access 0
    /bin/echo "ftpd_use_cifs"
    /bin/sudo setsebool -P ftpd_use_cifs 0
    /bin/echo "ftpd_use_fusefs"
    /bin/sudo setsebool -P ftpd_use_fusefs 0
    /bin/echo "ftpd_use_nfs"
    /bin/sudo setsebool -P ftpd_use_nfs 0
    /bin/echo "ftpd_use_passive_mode"
    /bin/sudo setsebool -P ftpd_use_passive_mode 0
    /bin/echo "ganesha_use_fusefs"
    /bin/sudo setsebool -P ganesha_use_fusefs 0
    /bin/echo "git_cgi_enable_homedirs"
    /bin/sudo setsebool -P git_cgi_enable_homedirs 0
    /bin/echo "git_cgi_use_cifs"
    /bin/sudo setsebool -P git_cgi_use_cifs 0
    /bin/echo "git_cgi_use_nfs"
    /bin/sudo setsebool -P git_cgi_use_nfs 0
    /bin/echo "git_session_bind_all_unreserved_ports"
    /bin/sudo setsebool -P git_session_bind_all_unreserved_ports 0
    /bin/echo "git_session_users"
    /bin/sudo setsebool -P git_session_users 0
    /bin/echo "git_system_enable_homedirs"
    /bin/sudo setsebool -P git_system_enable_homedirs 0
    /bin/echo "git_system_use_cifs"
    /bin/sudo setsebool -P git_system_use_cifs 0
    /bin/echo "git_system_use_nfs"
    /bin/sudo setsebool -P git_system_use_nfs 0
    /bin/echo "gitosis_can_sendmail"
    /bin/sudo setsebool -P gitosis_can_sendmail 0
    /bin/echo "glance_api_can_network"
    /bin/sudo setsebool -P glance_api_can_network 0
    /bin/echo "glance_use_execmem"
    /bin/sudo setsebool -P glance_use_execmem 0
    /bin/echo "glance_use_fusefs"
    /bin/sudo setsebool -P glance_use_fusefs 0
    /bin/echo "global_ssp"
    /bin/sudo setsebool -P global_ssp 0
    /bin/echo "gluster_anon_write"
    /bin/sudo setsebool -P gluster_anon_write 0
    /bin/echo "gluster_export_all_ro"
    /bin/sudo setsebool -P gluster_export_all_ro 0
    /bin/echo "gluster_export_all_rw"
    /bin/sudo setsebool -P gluster_export_all_rw 1
    /bin/echo "gluster_use_execmem"
    /bin/sudo setsebool -P gluster_use_execmem 0
    /bin/echo "gpg_web_anon_write"
    /bin/sudo setsebool -P gpg_web_anon_write 0
    /bin/echo "gssd_read_tmp"
    /bin/sudo setsebool -P gssd_read_tmp 1
    /bin/echo "guest_exec_content"
    /bin/sudo setsebool -P guest_exec_content 1
    /bin/echo "haproxy_connect_any"
    /bin/sudo setsebool -P haproxy_connect_any 0
    /bin/echo "httpd_anon_write"
    /bin/sudo setsebool -P httpd_anon_write 0
    /bin/echo "httpd_builtin_scripting"
    /bin/sudo setsebool -P httpd_builtin_scripting 1
    /bin/echo "httpd_can_check_spam"
    /bin/sudo setsebool -P httpd_can_check_spam 0
    /bin/echo "httpd_can_connect_ftp"
    /bin/sudo setsebool -P httpd_can_connect_ftp 0
    /bin/echo "httpd_can_connect_ldap"
    /bin/sudo setsebool -P httpd_can_connect_ldap 0
    /bin/echo "httpd_can_connect_mythtv"
    /bin/sudo setsebool -P httpd_can_connect_mythtv 0
    /bin/echo "httpd_can_connect_zabbix"
    /bin/sudo setsebool -P httpd_can_connect_zabbix 0
    /bin/echo "httpd_can_network_connect"
    /bin/sudo setsebool -P httpd_can_network_connect 1
    /bin/echo "httpd_can_network_connect_cobbler"
    /bin/sudo setsebool -P httpd_can_network_connect_cobbler 0
    /bin/echo "httpd_can_network_connect_db"
    /bin/sudo setsebool -P httpd_can_network_connect_db 1
    /bin/echo "httpd_can_network_memcache"
    /bin/sudo setsebool -P httpd_can_network_memcache 0
    /bin/echo "httpd_can_network_relay"
    /bin/sudo setsebool -P httpd_can_network_relay 0
    /bin/echo "httpd_can_sendmail"
    /bin/sudo setsebool -P httpd_can_sendmail 0
    /bin/echo "httpd_dbus_avahi"
    /bin/sudo setsebool -P httpd_dbus_avahi 0
    /bin/echo "httpd_dbus_sssd"
    /bin/sudo setsebool -P httpd_dbus_sssd 0
    /bin/echo "httpd_dontaudit_search_dirs"
    /bin/sudo setsebool -P httpd_dontaudit_search_dirs 0
    /bin/echo "httpd_enable_cgi"
    /bin/sudo setsebool -P httpd_enable_cgi 1
    /bin/echo "httpd_enable_ftp_server"
    /bin/sudo setsebool -P httpd_enable_ftp_server 0
    /bin/echo "httpd_enable_homedirs"
    /bin/sudo setsebool -P httpd_enable_homedirs 0
    /bin/echo "httpd_execmem"
    /bin/sudo setsebool -P httpd_execmem 0
    /bin/echo "httpd_graceful_shutdown"
    /bin/sudo setsebool -P httpd_graceful_shutdown 1
    /bin/echo "httpd_manage_ipa"
    /bin/sudo setsebool -P httpd_manage_ipa 0
    /bin/echo "httpd_mod_auth_ntlm_winbind"
    /bin/sudo setsebool -P httpd_mod_auth_ntlm_winbind 0
    /bin/echo "httpd_mod_auth_pam"
    /bin/sudo setsebool -P httpd_mod_auth_pam 0
    /bin/echo "httpd_read_user_content"
    /bin/sudo setsebool -P httpd_read_user_content 0
    /bin/echo "httpd_run_ipa"
    /bin/sudo setsebool -P httpd_run_ipa 0
    /bin/echo "httpd_run_preupgrade"
    /bin/sudo setsebool -P httpd_run_preupgrade 0
    /bin/echo "httpd_run_stickshift"
    /bin/sudo setsebool -P httpd_run_stickshift 0
    /bin/echo "httpd_serve_cobbler_files"
    /bin/sudo setsebool -P httpd_serve_cobbler_files 0
    /bin/echo "httpd_setrlimit"
    /bin/sudo setsebool -P httpd_setrlimit 0
    /bin/echo "httpd_ssi_exec"
    /bin/sudo setsebool -P httpd_ssi_exec 0
    /bin/echo "httpd_sys_script_anon_write"
    /bin/sudo setsebool -P httpd_sys_script_anon_write 0
    /bin/echo "httpd_tmp_exec"
    /bin/sudo setsebool -P httpd_tmp_exec 0
    /bin/echo "httpd_tty_comm"
    /bin/sudo setsebool -P httpd_tty_comm 0
    /bin/echo "httpd_unified"
    /bin/sudo setsebool -P httpd_unified 1
    /bin/echo "httpd_use_cifs"
    /bin/sudo setsebool -P httpd_use_cifs 0
    /bin/echo "httpd_use_fusefs"
    /bin/sudo setsebool -P httpd_use_fusefs 0
    /bin/echo "httpd_use_gpg"
    /bin/sudo setsebool -P httpd_use_gpg 0
    /bin/echo "httpd_use_nfs"
    /bin/sudo setsebool -P httpd_use_nfs 0
    /bin/echo "httpd_use_openstack"
    /bin/sudo setsebool -P httpd_use_openstack 0
    /bin/echo "httpd_use_sasl"
    /bin/sudo setsebool -P httpd_use_sasl 0
    /bin/echo "httpd_verify_dns"
    /bin/sudo setsebool -P httpd_verify_dns 0
    /bin/echo "icecast_use_any_tcp_ports"
    /bin/sudo setsebool -P icecast_use_any_tcp_ports 0
    /bin/echo "irc_use_any_tcp_ports"
    /bin/sudo setsebool -P irc_use_any_tcp_ports 0
    /bin/echo "irssi_use_full_network"
    /bin/sudo setsebool -P irssi_use_full_network 0
    /bin/echo "kdumpgui_run_bootloader"
    /bin/sudo setsebool -P kdumpgui_run_bootloader 0
    /bin/echo "kerberos_enabled"
    /bin/sudo setsebool -P kerberos_enabled 1
    /bin/echo "ksmtuned_use_cifs"
    /bin/sudo setsebool -P ksmtuned_use_cifs 0
    /bin/echo "ksmtuned_use_nfs"
    /bin/sudo setsebool -P ksmtuned_use_nfs 0
    /bin/echo "logadm_exec_content"
    /bin/sudo setsebool -P logadm_exec_content 1
    /bin/echo "logging_syslogd_can_sendmail"
    /bin/sudo setsebool -P logging_syslogd_can_sendmail 0
    /bin/echo "logging_syslogd_run_nagios_plugins"
    /bin/sudo setsebool -P logging_syslogd_run_nagios_plugins 0
    /bin/echo "logging_syslogd_use_tty"
    /bin/sudo setsebool -P logging_syslogd_use_tty 1
    /bin/echo "login_console_enabled"
    /bin/sudo setsebool -P login_console_enabled 1
    /bin/echo "logrotate_read_inside_containers"
    /bin/sudo setsebool -P logrotate_read_inside_containers 0
    /bin/echo "logrotate_use_nfs"
    /bin/sudo setsebool -P logrotate_use_nfs 0
    /bin/echo "logwatch_can_network_connect_mail"
    /bin/sudo setsebool -P logwatch_can_network_connect_mail 0
    /bin/echo "lsmd_plugin_connect_any"
    /bin/sudo setsebool -P lsmd_plugin_connect_any 0
    /bin/echo "mailman_use_fusefs"
    /bin/sudo setsebool -P mailman_use_fusefs 0
    /bin/echo "mcelog_client"
    /bin/sudo setsebool -P mcelog_client 0
    /bin/echo "mcelog_exec_scripts"
    /bin/sudo setsebool -P mcelog_exec_scripts 1
    /bin/echo "mcelog_foreground"
    /bin/sudo setsebool -P mcelog_foreground 0
    /bin/echo "mcelog_server"
    /bin/sudo setsebool -P mcelog_server 0
    /bin/echo "minidlna_read_generic_user_content"
    /bin/sudo setsebool -P minidlna_read_generic_user_content 0
    /bin/echo "mmap_low_allowed"
    /bin/sudo setsebool -P mmap_low_allowed 0
    /bin/echo "mock_enable_homedirs"
    /bin/sudo setsebool -P mock_enable_homedirs 0
    /bin/echo "mount_anyfile"
    /bin/sudo setsebool -P mount_anyfile 1
    /bin/echo "mozilla_plugin_bind_unreserved_ports"
    /bin/sudo setsebool -P mozilla_plugin_bind_unreserved_ports 0
    /bin/echo "mozilla_plugin_can_network_connect"
    /bin/sudo setsebool -P mozilla_plugin_can_network_connect 0
    /bin/echo "mozilla_plugin_use_bluejeans"
    /bin/sudo setsebool -P mozilla_plugin_use_bluejeans 0
    /bin/echo "mozilla_plugin_use_gps"
    /bin/sudo setsebool -P mozilla_plugin_use_gps 0
    /bin/echo "mozilla_plugin_use_spice"
    /bin/sudo setsebool -P mozilla_plugin_use_spice 0
    /bin/echo "mozilla_read_content"
    /bin/sudo setsebool -P mozilla_read_content 0
    /bin/echo "mpd_enable_homedirs"
    /bin/sudo setsebool -P mpd_enable_homedirs 0
    /bin/echo "mpd_use_cifs"
    /bin/sudo setsebool -P mpd_use_cifs 0
    /bin/echo "mpd_use_nfs"
    /bin/sudo setsebool -P mpd_use_nfs 0
    /bin/echo "mplayer_execstack"
    /bin/sudo setsebool -P mplayer_execstack 0
    /bin/echo "mysql_connect_any"
    /bin/sudo setsebool -P mysql_connect_any 0
    /bin/echo "nagios_run_pnp4nagios"
    /bin/sudo setsebool -P nagios_run_pnp4nagios 0
    /bin/echo "nagios_run_sudo"
    /bin/sudo setsebool -P nagios_run_sudo
    /bin/echo "nagios_use_nfs"
    /bin/sudo setsebool -P nagios_use_nfs 0
    /bin/echo "named_tcp_bind_http_port"
    /bin/sudo setsebool -P named_tcp_bind_http_port 0
    /bin/echo "named_write_master_zones"
    /bin/sudo setsebool -P named_write_master_zones 0
    /bin/echo "neutron_can_network"
    /bin/sudo setsebool -P neutron_can_network 0
    /bin/echo "nfs_export_all_ro"
    /bin/sudo setsebool -P nfs_export_all_ro 1
    /bin/echo "nfs_export_all_rw"
    /bin/sudo setsebool -P nfs_export_all_rw 1
    /bin/echo "nfsd_anon_write"
    /bin/sudo setsebool -P nfsd_anon_write 0
    /bin/echo "nis_enabled"
    /bin/sudo setsebool -P nis_enabled 0
    /bin/echo "nscd_use_shm"
    /bin/sudo setsebool -P nscd_use_shm 1
    /bin/echo "openshift_use_nfs"
    /bin/sudo setsebool -P openshift_use_nfs 0
    /bin/echo "openvpn_can_network_connect"
    /bin/sudo setsebool -P openvpn_can_network_connect 1
    /bin/echo "openvpn_enable_homedirs"
    /bin/sudo setsebool -P openvpn_enable_homedirs 1
    /bin/echo "openvpn_run_unconfined"
    /bin/sudo setsebool -P openvpn_run_unconfined 0
    /bin/echo "pcp_bind_all_unreserved_ports"
    /bin/sudo setsebool -P pcp_bind_all_unreserved_ports 0
    /bin/echo "pcp_read_generic_logs"
    /bin/sudo setsebool -P pcp_read_generic_logs 0
    /bin/echo "piranha_lvs_can_network_connect"
    /bin/sudo setsebool -P piranha_lvs_can_network_connect 0
    /bin/echo "polipo_connect_all_unreserved"
    /bin/sudo setsebool -P polipo_connect_all_unreserved 0
    /bin/echo "polipo_session_bind_all_unreserved_ports"
    /bin/sudo setsebool -P polipo_session_bind_all_unreserved_ports 0
    /bin/echo "polipo_session_users"
    /bin/sudo setsebool -P polipo_session_users 0
    /bin/echo "polipo_use_cifs"
    /bin/sudo setsebool -P polipo_use_cifs 0
    /bin/echo "polipo_use_nfs"
    /bin/sudo setsebool -P polipo_use_nfs 0
    /bin/echo "polyinstantiation_enabled"
    /bin/sudo setsebool -P polyinstantiation_enabled 1
    /bin/echo "postfix_local_write_mail_spool"
    /bin/sudo setsebool -P postfix_local_write_mail_spool 1
    /bin/echo "postgresql_can_rsync"
    /bin/sudo setsebool -P postgresql_can_rsync 0
    /bin/echo "postgresql_selinux_transmit_client_label"
    /bin/sudo setsebool -P postgresql_selinux_transmit_client_label 0
    /bin/echo "postgresql_selinux_unconfined_dbadm"
    /bin/sudo setsebool -P postgresql_selinux_unconfined_dbadm 1
    /bin/echo "postgresql_selinux_users_ddl"
    /bin/sudo setsebool -P postgresql_selinux_users_ddl 1
    /bin/echo "pppd_can_insmod"
    /bin/sudo setsebool -P pppd_can_insmod 0
    /bin/echo "pppd_for_user"
    /bin/sudo setsebool -P pppd_for_user 0
    /bin/echo "privoxy_connect_any"
    /bin/sudo setsebool -P privoxy_connect_any 1
    /bin/echo "prosody_bind_http_port"
    /bin/sudo setsebool -P prosody_bind_http_port 0
    /bin/echo "puppetagent_manage_all_files"
    /bin/sudo setsebool -P puppetagent_manage_all_files 0
    /bin/echo "puppetmaster_use_db"
    /bin/sudo setsebool -P puppetmaster_use_db 0
    /bin/echo "racoon_read_shadow"
    /bin/sudo setsebool -P racoon_read_shadow 0
    /bin/echo "radius_use_jit"
    /bin/sudo setsebool -P radius_use_jit 0
    /bin/echo "rpcd_use_fusefs"
    /bin/sudo setsebool -P rpcd_use_fusefs 0
    /bin/echo "rsync_anon_write"
    /bin/sudo setsebool -P rsync_anon_write 0
    /bin/echo "rsync_client"
    /bin/sudo setsebool -P rsync_client 0
    /bin/echo "rsync_export_all_ro"
    /bin/sudo setsebool -P rsync_export_all_ro 0
    /bin/echo "rsync_full_access"
    /bin/sudo setsebool -P rsync_full_access 0
    /bin/echo "samba_create_home_dirs"
    /bin/sudo setsebool -P samba_create_home_dirs 0
    /bin/echo "samba_domain_controller"
    /bin/sudo setsebool -P samba_domain_controller 0
    /bin/echo "samba_enable_home_dirs"
    /bin/sudo setsebool -P samba_enable_home_dirs 0
    /bin/echo "samba_export_all_ro"
    /bin/sudo setsebool -P samba_export_all_ro 0
    /bin/echo "samba_export_all_rw"
    /bin/sudo setsebool -P samba_export_all_rw 0
    /bin/echo "samba_load_libgfapi"
    /bin/sudo setsebool -P samba_load_libgfapi 0
    /bin/echo "samba_portmapper"
    /bin/sudo setsebool -P samba_portmapper 0
    /bin/echo "samba_run_unconfined"
    /bin/sudo setsebool -P samba_run_unconfined 0
    /bin/echo "samba_share_fusefs"
    /bin/sudo setsebool -P samba_share_fusefs 0
    /bin/echo "samba_share_nfs"
    /bin/sudo setsebool -P samba_share_nfs 0
    /bin/echo "sanlock_enable_home_dirs"
    /bin/sudo setsebool -P sanlock_enable_home_dirs 0
    /bin/echo "sanlock_use_fusefs"
    /bin/sudo setsebool -P sanlock_use_fusefs 0
    /bin/echo "sanlock_use_nfs"
    /bin/sudo setsebool -P sanlock_use_nfs 0
    /bin/echo "sanlock_use_samba"
    /bin/sudo setsebool -P sanlock_use_samba 0
    /bin/echo "saslauthd_read_shadow"
    /bin/sudo setsebool -P saslauthd_read_shadow 0
    /bin/echo "secadm_exec_content"
    /bin/sudo setsebool -P secadm_exec_content 1
    /bin/echo "secure_mode"
    /bin/sudo setsebool -P secure_mode 0
    /bin/echo "secure_mode_insmod"
    /bin/sudo setsebool -P secure_mode_insmod 0
    /bin/echo "secure_mode_policyload"
    /bin/sudo setsebool -P secure_mode_policyload 0
    /bin/echo "selinuxuser_direct_dri_enabled"
    /bin/sudo setsebool -P selinuxuser_direct_dri_enabled 1
    /bin/echo "selinuxuser_execheap"
    /bin/sudo setsebool -P selinuxuser_execheap 0
    /bin/echo "selinuxuser_execmod"
    /bin/sudo setsebool -P selinuxuser_execmod 1
    /bin/echo "selinuxuser_execstack"
    /bin/sudo setsebool -P selinuxuser_execstack 1
    /bin/echo "selinuxuser_mysql_connect_enabled"
    /bin/sudo setsebool -P selinuxuser_mysql_connect_enabled 0
    /bin/echo "selinuxuser_ping"
    /bin/sudo setsebool -P selinuxuser_ping 1
    /bin/echo "selinuxuser_postgresql_connect_enabled"
    /bin/sudo setsebool -P selinuxuser_postgresql_connect_enabled 0
    /bin/echo "selinuxuser_rw_noexattrfile"
    /bin/sudo setsebool -P selinuxuser_rw_noexattrfile 1
    /bin/echo "selinuxuser_share_music"
    /bin/sudo setsebool -P selinuxuser_share_music 0
    /bin/echo "selinuxuser_tcp_server"
    /bin/sudo setsebool -P selinuxuser_tcp_server 0
    /bin/echo "selinuxuser_udp_server"
    /bin/sudo setsebool -P selinuxuser_udp_server 0
    /bin/echo "selinuxuser_use_ssh_chroot"
    /bin/sudo setsebool -P selinuxuser_use_ssh_chroot 0
    /bin/echo "sge_domain_can_network_connect"
    /bin/sudo setsebool -P sge_domain_can_network_connect 0
    /bin/echo "sge_use_nfs"
    /bin/sudo setsebool -P sge_use_nfs 0
    /bin/echo "smartmon_3ware"
    /bin/sudo setsebool -P smartmon_3ware 0
    /bin/echo "smbd_anon_write"
    /bin/sudo setsebool -P smbd_anon_write 0
    /bin/echo "spamassassin_can_network"
    /bin/sudo setsebool -P spamassassin_can_network 0
    /bin/echo "spamd_enable_home_dirs"
    /bin/sudo setsebool -P spamd_enable_home_dirs 1
    /bin/echo "spamd_update_can_network"
    /bin/sudo setsebool -P spamd_update_can_network 0
    /bin/echo "squid_connect_any"
    /bin/sudo setsebool -P squid_connect_any 1
    /bin/echo "squid_use_tproxy"
    /bin/sudo setsebool -P squid_use_tproxy 0
    /bin/echo "ssh_chroot_rw_homedirs"
    /bin/sudo setsebool -P ssh_chroot_rw_homedirs 0
    /bin/echo "ssh_keysign"
    /bin/sudo setsebool -P ssh_keysign 0
    /bin/echo "ssh_sysadm_login"
    /bin/sudo setsebool -P ssh_sysadm_login 0
    /bin/echo "staff_exec_content"
    /bin/sudo setsebool -P staff_exec_content 1
    /bin/echo "staff_use_svirt"
    /bin/sudo setsebool -P staff_use_svirt 0
    /bin/echo "swift_can_network"
    /bin/sudo setsebool -P swift_can_network 0
    /bin/echo "sysadm_exec_content"
    /bin/sudo setsebool -P sysadm_exec_content 1
    /bin/echo "telepathy_connect_all_ports"
    /bin/sudo setsebool -P telepathy_connect_all_ports 0
    /bin/echo "telepathy_tcp_connect_generic_network_ports"
    /bin/sudo setsebool -P telepathy_tcp_connect_generic_network_ports 1
    /bin/echo "tftp_anon_write"
    /bin/sudo setsebool -P tftp_anon_write 0
    /bin/echo "tftp_home_dir"
    /bin/sudo setsebool -P tftp_home_dir 0
    /bin/echo "tmpreaper_use_cifs"
    /bin/sudo setsebool -P tmpreaper_use_cifs 0
    /bin/echo "tmpreaper_use_nfs"
    /bin/sudo setsebool -P tmpreaper_use_nfs 0
    /bin/echo "tmpreaper_use_samba"
    /bin/sudo setsebool -P tmpreaper_use_samba 0
    /bin/echo "tomcat_read_rpm_db"
    /bin/sudo setsebool -P tomcat_read_rpm_db 0
    /bin/echo "tor_bind_all_unreserved_ports"
    /bin/sudo setsebool -P tor_bind_all_unreserved_ports 0
    /bin/echo "tor_can_network_relay"
    /bin/sudo setsebool -P tor_can_network_relay 0
    /bin/echo "unconfined_chrome_sandbox_transition"
    /bin/sudo setsebool -P unconfined_chrome_sandbox_transition 1
    /bin/echo "unconfined_login"
    /bin/sudo setsebool -P unconfined_login 1
    /bin/echo "unconfined_mozilla_plugin_transition"
    /bin/sudo setsebool -P unconfined_mozilla_plugin_transition 1
    /bin/echo "unprivuser_use_svirt"
    /bin/sudo setsebool -P unprivuser_use_svirt 0
    /bin/echo "use_ecryptfs_home_dirs"
    /bin/sudo setsebool -P use_ecryptfs_home_dirs 0
    /bin/echo "use_fusefs_home_dirs"
    /bin/sudo setsebool -P use_fusefs_home_dirs 0
    /bin/echo "use_lpd_server"
    /bin/sudo setsebool -P use_lpd_server 0
    /bin/echo "use_nfs_home_dirs"
    /bin/sudo setsebool -P use_nfs_home_dirs 0
    /bin/echo "use_samba_home_dirs"
    /bin/sudo setsebool -P use_samba_home_dirs 0
    /bin/echo "user_exec_content"
    /bin/sudo setsebool -P user_exec_content 1
    /bin/echo "varnishd_connect_any"
    /bin/sudo setsebool -P varnishd_connect_any 0
    /bin/echo "virt_read_qemu_ga_data"
    /bin/sudo setsebool -P virt_read_qemu_ga_data 0
    /bin/echo "virt_rw_qemu_ga_data"
    /bin/sudo setsebool -P virt_rw_qemu_ga_data 0
    /bin/echo "virt_sandbox_use_all_caps"
    /bin/sudo setsebool -P virt_sandbox_use_all_caps 1
    /bin/echo "virt_sandbox_use_audit"
    /bin/sudo setsebool -P virt_sandbox_use_audit 1
    /bin/echo "virt_sandbox_use_fusefs"
    /bin/sudo setsebool -P virt_sandbox_use_fusefs 0
    /bin/echo "virt_sandbox_use_mknod"
    /bin/sudo setsebool -P virt_sandbox_use_mknod 0
    /bin/echo "virt_sandbox_use_netlink"
    /bin/sudo setsebool -P virt_sandbox_use_netlink 0
    /bin/echo "virt_sandbox_use_sys_admin"
    /bin/sudo setsebool -P virt_sandbox_use_sys_admin 0
    /bin/echo "virt_transition_userdomain"
    /bin/sudo setsebool -P virt_transition_userdomain 0
    /bin/echo "virt_use_comm"
    /bin/sudo setsebool -P virt_use_comm 0
    /bin/echo "virt_use_execmem"
    /bin/sudo setsebool -P virt_use_execmem 0
    /bin/echo "virt_use_fusefs"
    /bin/sudo setsebool -P virt_use_fusefs 0
    /bin/echo "virt_use_glusterd"
    /bin/sudo setsebool -P virt_use_glusterd 0
    /bin/echo "virt_use_nfs"
    /bin/sudo setsebool -P virt_use_nfs 0
    /bin/echo "virt_use_rawip"
    /bin/sudo setsebool -P virt_use_rawip 0
    /bin/echo "virt_use_samba"
    /bin/sudo setsebool -P virt_use_samba 0
    /bin/echo "virt_use_sanlock"
    /bin/sudo setsebool -P virt_use_sanlock 0
    /bin/echo "virt_use_usb"
    /bin/sudo setsebool -P virt_use_usb 1
    /bin/echo "virt_use_xserver"
    /bin/sudo setsebool -P virt_use_xserver 0
    /bin/echo "webadm_manage_user_files"
    /bin/sudo setsebool -P webadm_manage_user_files 0
    /bin/echo "webadm_read_user_files"
    /bin/sudo setsebool -P webadm_read_user_files 0
    /bin/echo "wine_mmap_zero_ignore"
    /bin/sudo setsebool -P wine_mmap_zero_ignore 0
    /bin/echo "xdm_bind_vnc_tcp_port"
    /bin/sudo setsebool -P xdm_bind_vnc_tcp_port 0
    /bin/echo "xdm_exec_bootloader"
    /bin/sudo setsebool -P xdm_exec_bootloader 0
    /bin/echo "xdm_sysadm_login"
    /bin/sudo setsebool -P xdm_sysadm_login 0
    /bin/echo "xdm_write_home"
    /bin/sudo setsebool -P xdm_write_home 0
    /bin/echo "xen_use_nfs"
    /bin/sudo setsebool -P xen_use_nfs 0
    /bin/echo "xend_run_blktap"
    /bin/sudo setsebool -P xend_run_blktap 1
    /bin/echo "xend_run_qemu"
    /bin/sudo setsebool -P xend_run_qemu 1
    /bin/echo "xguest_connect_network"
    /bin/sudo setsebool -P xguest_connect_network 1
    /bin/echo "xguest_exec_content"
    /bin/sudo setsebool -P xguest_exec_content 1
    /bin/echo "xguest_mount_media"
    /bin/sudo setsebool -P xguest_mount_media 1
    /bin/echo "xguest_use_bluetooth"
    /bin/sudo setsebool -P xguest_use_bluetooth 1
    /bin/echo "xserver_clients_write_xshm"
    /bin/sudo setsebool -P xserver_clients_write_xshm 0
    /bin/echo "xserver_execmem"
    /bin/sudo setsebool -P xserver_execmem 0
    /bin/echo "xserver_object_manager"
    /bin/sudo setsebool -P xserver_object_manager 0
    /bin/echo "zabbix_can_network"
    /bin/sudo setsebool -P zabbix_can_network 0
    /bin/echo "zarafa_setrlimit"
    /bin/sudo setsebool -P zarafa_setrlimit 0
    /bin/echo "zebra_write_config"
    /bin/sudo setsebool -P zebra_write_config 0
    /bin/echo "zoneminder_anon_write"
    /bin/sudo setsebool -P zoneminder_anon_write 0
    /bin/echo "zoneminder_run_sudo"
    /bin/sudo setsebool -P zoneminder_run_sudo 0
  ;;
esac

