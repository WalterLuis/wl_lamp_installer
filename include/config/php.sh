#!/bin/bash

printf "%(%H:%M:%S - Entrando en: $BASH_SOURCE)T\n" -1

# /etc/php.ini

if [ ! -f /etc/php.ini.itop_backup_first ]; then
  /bin/sudo /bin/cp /etc/php.ini /etc/php.ini.itop_backup_first
fi
/bin/sudo /bin/cp /etc/php.ini /etc/php.ini.itop_backup_last

/bin/sudo /bin/sed -i 's/; /;/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/ = /=/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/ =/=/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/= /=/g' /etc/php.ini
/bin/sudo /bin/sed -i".clean_backup" '/;error_log=.*/d' /etc/php.ini

/bin/sudo /bin/sed -i 's/short_open_tag=.*/short_open_tag=On/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;short_open_tag=.*/short_open_tag=On/g' /etc/php.ini

/bin/sudo /bin/sed -i 's/output_buffering=.*/output_buffering=On/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;output_buffering=.*/output_buffering=On/g' /etc/php.ini

/bin/sudo /bin/sed -i 's/serialize_precision=.*/serialize_precision=-1/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;serialize_precision=.*/serialize_precision=-1/g' /etc/php.ini

/bin/sudo /bin/sed -i 's/realpath_cache_size=.*/realpath_cache_size=256k/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;realpath_cache_size=.*/realpath_cache_size=256k/g' /etc/php.ini

/bin/sudo /bin/sed -i 's/realpath_cache_ttl=.*/realpath_cache_ttl=600/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;realpath_cache_ttl=.*/realpath_cache_ttl=600/g' /etc/php.ini

/bin/sudo /bin/sed -i 's/expose_php=.*/expose_php=Off/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;expose_php=.*/expose_php=Off/g' /etc/php.ini

/bin/sudo /bin/sed -i 's/max_execution_time=.*/max_execution_time=3600/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;max_execution_time=.*/max_execution_time=3600/g' /etc/php.ini

/bin/sudo /bin/sed -i 's/max_input_time=.*/max_input_time=3600/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;max_input_time=.*/max_input_time=3600/g' /etc/php.ini

/bin/sudo /bin/sed -i 's/max_input_vars=.*/max_input_vars=20000/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;max_input_vars=.*/max_input_vars=20000/g' /etc/php.ini

/bin/sudo /bin/sed -i 's/memory_limit=.*/memory_limit=1024M/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;memory_limit=.*/memory_limit=1024M/g' /etc/php.ini

# https://maximivanov.github.io/php-error-reporting-calculator/
/bin/sudo /bin/sed -i 's/error_reporting=.*/error_reporting=0/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;error_reporting=.*/error_reporting=0/g' /etc/php.ini

/bin/sudo /bin/sed -i 's/display_errors=.*/display_errors=Off/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;display_errors=.*/display_errors=Off/g' /etc/php.ini

/bin/sudo /bin/sed -i 's/display_startup_errors=.*/display_startup_errors=Off/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;display_startup_errors=.*/display_startup_errors=Off/g' /etc/php.ini

/bin/sudo /bin/sed -i 's/log_errors=.*/log_errors=On/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;log_errors=.*/log_errors=On/g' /etc/php.ini

/bin/sudo /bin/sed -i 's/log_errors_max_len=.*/log_errors_max_len=0/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;log_errors_max_len=.*/log_errors_max_len=0/g' /etc/php.ini

/bin/sudo /bin/sed -i 's/report_memleaks=.*/report_memleaks=On/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;report_memleaks=.*/report_memleaks=On/g' /etc/php.ini

/bin/sudo /bin/sed -i 's/track_errors=.*/track_errors=On/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;track_errors=.*/track_errors=On/g' /etc/php.ini

/bin/sudo /bin/sed -i 's/html_errors=.*/html_errors=Off/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;html_errors=.*/html_errors=Off/g' /etc/php.ini

/bin/sudo /bin/sed -i "s/error_prepend_string=.*/error_prepend_string=\"<pre style='color:#ff0000'>\"/g" /etc/php.ini
/bin/sudo /bin/sed -i "s/;error_prepend_string=.*/error_prepend_string=\"<pre style='color:#ff0000'>\"/g" /etc/php.ini

/bin/sudo /bin/sed -i "s/error_append_string=.*/error_append_string=\"\<\/pre\>\"\nerror_log=\"\/var\/log\/apache\/php_error.log/g" /etc/php.ini
/bin/sudo /bin/sed -i "s/;error_append_string=.*/error_append_string=\"\<\/pre\>\"\nerror_log=\"\/var\/log\/apache\/php_error.log/g" /etc/php.ini

/bin/sudo /bin/sed -i "s/error_log=php.*/\"/g" /etc/php.ini
/bin/sudo /bin/sed -i "s/;error_log=php.*/error_log=\"\/var\/log\/apache\/php_error.log\"/g" /etc/php.ini

/bin/sudo /bin/sed -i 's/post_max_size=.*/post_max_size=256M/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;post_max_size=.*/post_max_size=256M/g' /etc/php.ini

/bin/sudo /bin/sed -i 's/always_populate_raw_post_data=.*/always_populate_raw_post_data=-1/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;always_populate_raw_post_data=.*/always_populate_raw_post_data=-1/g' /etc/php.ini

/bin/sudo /bin/sed -i 's/upload_max_filesize=.*/upload_max_filesize=256M/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;upload_max_filesize=.*/upload_max_filesize=256M/g' /etc/php.ini

/bin/sudo /bin/sed -i 's/max_file_uploads=.*/max_file_uploads=60/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;max_file_uploads=.*/max_file_uploads=60/g' /etc/php.ini

/bin/sudo /bin/sed -i 's/auto_detect_line_endings=.*/auto_detect_line_endings=On/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;auto_detect_line_endings=.*/auto_detect_line_endings=On/g' /etc/php.ini

/bin/sudo /bin/sed -i".clean_backup" "/auto_detect_line_endings.*/d" /etc/php.ini

/bin/sudo /bin/sed -i 's/default_socket_timeout=.*/default_socket_timeout=3600\nauto_detect_line_endings=On/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;default_socket_timeout=.*/default_socket_timeout=3600\nauto_detect_line_endings=On/g' /etc/php.ini

/bin/sudo /bin/sed -i 's/date.timezone=.*/date.timezone=Atlantic\/Canary/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;date.timezone=.*/date.timezone=Atlantic\/Canary/g' /etc/php.ini

/bin/sudo /bin/sed -i 's/date.default_latitude=.*/date.default_latitude=28.4716/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;date.default_latitude=.*/date.default_latitude=28.4716/g' /etc/php.ini

/bin/sudo /bin/sed -i 's/date.default_longitude=.*/date.default_longitude=-16.2472/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;date.default_longitude=.*/date.default_longitude=-16.2472/g' /etc/php.ini

/bin/sudo /bin/sed -i "s/mail.log=.*/mail.log=\"\/var\/log\/apache\/mail_error.log\"/g" /etc/php.ini
/bin/sudo /bin/sed -i "s/;mail.log=.*/mail.log=\"\/var\/log\/apache\/mail_error.log\"/g" /etc/php.ini

/bin/sudo /bin/sed -i 's/mysql.connect_timeout=.*/mysql.connect_timeout=3600/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;mysql.connect_timeout=.*/mysql.connect_timeout=3600/g' /etc/php.ini

/bin/sudo /bin/sed -i 's/mysqlnd.collect_statistics=.*/mysqlnd.collect_statistics=Off/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;mysqlnd.collect_statistics=.*/mysqlnd.collect_statistics=Off/g' /etc/php.ini

/bin/sudo /bin/sed -i 's/mysqlnd.collect_memory_statistics=.*/mysqlnd.collect_memory_statistics=Off/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;mysqlnd.collect_memory_statistics=.*/mysqlnd.collect_memory_statistics=Off/g' /etc/php.ini

/bin/sudo /bin/sed -i 's/session.use_strict_mode=.*/session.use_strict_mode=1/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;session.use_strict_mode=.*/session.use_strict_mode=1/g' /etc/php.ini

/bin/sudo /bin/sed -i 's/session.cookie_httponly=.*/session.cookie_httponly=1/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;session.cookie_httponly=.*/session.cookie_httponly=1/g' /etc/php.ini

/bin/sudo /bin/sed -i 's/session.name=.*/session.name=IMCSESSID/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;session.name=.*/session.name=IMCSESSID/g' /etc/php.ini

/bin/sudo /bin/sed -i 's/session.gc_divisor=.*/session.gc_divisor=500/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;session.gc_divisor=.*/session.gc_divisor=500/g' /etc/php.ini

/bin/sudo /bin/sed -i 's/session.gc_maxlifetime=.*/session.gc_maxlifetime=43200/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;session.gc_maxlifetime=.*/session.gc_maxlifetime=43200/g' /etc/php.ini

/bin/sudo /bin/sed -i 's/session.sid_length=.*/session.sid_length=64/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;session.sid_length=.*/session.sid_length=64/g' /etc/php.ini

/bin/sudo /bin/sed -i 's/session.sid_bits_per_character=.*/session.sid_bits_per_character=6\nsession.hash_function=\"SHA512\"/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;session.sid_bits_per_character=.*/session.sid_bits_per_character=6\nsession.hash_function=\"SHA512\"/g' /etc/php.ini

/bin/sudo /bin/sed -i 's/mbstring.func_overload=.*/mbstring.func_overload=0/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/;mbstring.func_overload=.*/mbstring.func_overload=0/g' /etc/php.ini

/bin/sudo /bin/sed -i 's/Off/"Off"/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/""Off""/"Off"/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/On/"On"/g' /etc/php.ini
/bin/sudo /bin/sed -i 's/""On""/"On"/g' /etc/php.ini

/bin/sudo /bin/sed -i".clean_backup" '/;.*/d' /etc/php.ini
/bin/sudo /bin/sed -i".clean_backup" '/^$/d' /etc/php.ini
/bin/sudo /bin/sed -i".clean_backup" '/./!d' /etc/php.ini
/bin/sudo /bin/rm -f /etc/php.ini.clean_backup >> ${SCRIPT_DIR}/debug.log

# /etc/php.d/10-opcache.ini
if [ ! -f /etc/php.d/10-opcache.ini.itop_backup_first ]; then
  /bin/sudo /bin/cp /etc/php.d/10-opcache.ini /etc/php.d/10-opcache.ini.itop_backup_first
fi
/bin/sudo /bin/cp /etc/php.d/10-opcache.ini /etc/php.d/10-opcache.ini.itop_backup_last

/bin/sudo /bin/sed -i 's/; /;/g' /etc/php.d/10-opcache.ini
/bin/sudo /bin/sed -i 's/ = /=/g' /etc/php.d/10-opcache.ini
/bin/sudo /bin/sed -i 's/ =/=/g' /etc/php.d/10-opcache.ini
/bin/sudo /bin/sed -i 's/= /=/g' /etc/php.d/10-opcache.ini

/bin/sudo /bin/sed -i 's/opcache.enable=.*/opcache.enable=1/g' /etc/php.d/10-opcache.ini
/bin/sudo /bin/sed -i 's/;opcache.enable=.*/opcache.enable=1/g' /etc/php.d/10-opcache.ini

/bin/sudo /bin/sed -i 's/opcache.enable_cli=.*/opcache.enable_cli=1/g' /etc/php.d/10-opcache.ini
/bin/sudo /bin/sed -i 's/;opcache.enable_cli=.*/opcache.enable_cli=1/g' /etc/php.d/10-opcache.ini

/bin/sudo /bin/sed -i 's/opcache.file_update_protection=.*/opcache.file_update_protection=0/g' /etc/php.d/10-opcache.ini
/bin/sudo /bin/sed -i 's/;opcache.file_update_protection=.*/opcache.file_update_protection=0/g' /etc/php.d/10-opcache.ini

/bin/sudo /bin/sed -i 's/opcache.interned_strings_buffer=.*/opcache.interned_strings_buffer=16/g' /etc/php.d/10-opcache.ini
/bin/sudo /bin/sed -i 's/;opcache.interned_strings_buffer=.*/opcache.interned_strings_buffer=16/g' /etc/php.d/10-opcache.ini

/bin/sudo /bin/sed -i 's/opcache.max_accelerated_files=.*/opcache.max_accelerated_files=65407/g' /etc/php.d/10-opcache.ini
/bin/sudo /bin/sed -i 's/;opcache.max_accelerated_files=.*/opcache.max_accelerated_files=65407/g' /etc/php.d/10-opcache.ini

/bin/sudo /bin/sed -i 's/opcache.memory_consumption=.*/opcache.memory_consumption=128/g' /etc/php.d/10-opcache.ini
/bin/sudo /bin/sed -i 's/;opcache.memory_consumption=.*/opcache.memory_consumption=128/g' /etc/php.d/10-opcache.ini

/bin/sudo /bin/sed -i 's/opcache.revalidate_freq=.*/opcache.revalidate_freq=30/g' /etc/php.d/10-opcache.ini
/bin/sudo /bin/sed -i 's/;opcache.revalidate_freq=.*/opcache.revalidate_freq=30/g' /etc/php.d/10-opcache.ini

/bin/sudo /bin/sed -i 's/opcache.save_comments=.*/opcache.save_comments=0/g' /etc/php.d/10-opcache.ini
/bin/sudo /bin/sed -i 's/;opcache.save_comments=.*/opcache.save_comments=0/g' /etc/php.d/10-opcache.ini

/bin/sudo /bin/sed -i 's/opcache.validate_timestamps=.*/opcache.validate_timestamps=1/g' /etc/php.d/10-opcache.ini
/bin/sudo /bin/sed -i 's/;opcache.validate_timestamps=.*/opcache.validate_timestamps=1/g' /etc/php.d/10-opcache.ini

/bin/sudo /bin/sed -i 's/Off/"Off"/g' /etc/php.d/10-opcache.ini
/bin/sudo /bin/sed -i 's/""Off""/"Off"/g' /etc/php.d/10-opcache.ini
/bin/sudo /bin/sed -i 's/On/"On"/g' /etc/php.d/10-opcache.ini
/bin/sudo /bin/sed -i 's/""On""/"On"/g' /etc/php.d/10-opcache.ini

/bin/sudo /bin/sed -i".clean_backup" '/;.*/d' /etc/php.d/10-opcache.ini
/bin/sudo /bin/sed -i".clean_backup" '/^$/d' /etc/php.d/10-opcache.ini
/bin/sudo /bin/sed -i".clean_backup" '/./!d' /etc/php.d/10-opcache.ini
/bin/sudo /bin/rm -f /etc/php.d/10-opcache.ini.clean_backup >> ${SCRIPT_DIR}/debug.log

# /etc/php.d/40-apcu.ini
if [ ! -f /etc/php.d/40-apcu.ini.itop_backup_first ]; then
  /bin/sudo /bin/cp /etc/php.d/40-apcu.ini /etc/php.d/40-apcu.ini.itop_backup_first
fi
/bin/sudo /bin/cp /etc/php.d/40-apcu.ini /etc/php.d/40-apcu.ini.itop_backup_last

/bin/sudo /bin/sed -i 's/; /;/g' /etc/php.d/40-apcu.ini
/bin/sudo /bin/sed -i 's/ = /=/g' /etc/php.d/40-apcu.ini
/bin/sudo /bin/sed -i 's/ =/=/g' /etc/php.d/40-apcu.ini
/bin/sudo /bin/sed -i 's/= /=/g' /etc/php.d/40-apcu.ini

/bin/sudo /bin/sed -i 's/apc.enabled=.*/apc.enabled=1/g' /etc/php.d/40-apcu.ini
/bin/sudo /bin/sed -i 's/;apc.enabled=.*/apc.enabled=1/g' /etc/php.d/40-apcu.ini

/bin/sudo /bin/sed -i 's/apc.enable_cli=.*/apc.enable_cli=1/g' /etc/php.d/40-apcu.ini
/bin/sudo /bin/sed -i 's/;apc.enable_cli=.*/apc.enable_cli=1/g' /etc/php.d/40-apcu.ini

/bin/sudo /bin/sed -i 's/apc.shm_size=.*/apc.shm_size=128M/g' /etc/php.d/40-apcu.ini
/bin/sudo /bin/sed -i 's/;apc.shm_size=.*/apc.shm_size=128M/g' /etc/php.d/40-apcu.ini

/bin/sudo /bin/sed -i 's/apc.gc_ttl=.*/apc.gc_ttl=600/g' /etc/php.d/40-apcu.ini
/bin/sudo /bin/sed -i 's/;apc.gc_ttl=.*/apc.gc_ttl=600/g' /etc/php.d/40-apcu.ini

/bin/sudo /bin/sed -i 's/apc.entries_hint=.*/apc.entries_hint=8192/g' /etc/php.d/40-apcu.ini
/bin/sudo /bin/sed -i 's/;apc.entries_hint=.*/apc.entries_hint=8192/g' /etc/php.d/40-apcu.ini

/bin/sudo /bin/sed -i 's/Off/"Off"/g' /etc/php.d/40-apcu.ini
/bin/sudo /bin/sed -i 's/""Off""/"Off"/g' /etc/php.d/40-apcu.ini
/bin/sudo /bin/sed -i 's/On/"On"/g' /etc/php.d/40-apcu.ini
/bin/sudo /bin/sed -i 's/""On""/"On"/g' /etc/php.d/40-apcu.ini

/bin/sudo /bin/sed -i".clean_backup" '/;.*/d' /etc/php.d/40-apcu.ini
/bin/sudo /bin/sed -i".clean_backup" '/^$/d' /etc/php.d/40-apcu.ini
/bin/sudo /bin/sed -i".clean_backup" '/./!d' /etc/php.d/40-apcu.ini
/bin/sudo /bin/rm -f /etc/php.d/40-apcu.ini.clean_backup >> ${SCRIPT_DIR}/debug.log

if ! rpm -qa | grep -q "wget"; then
  /bin/sudo /bin/yum -y -q --skip-broken install wget > /dev/null 2>&1
fi
/bin/sudo wget -q https://browscap.org/stream?q=Full_PHP_BrowsCapINI -O full_php_browscap.ini >> ${SCRIPT_DIR}/debug.log
if [ ! -d /etc/httpd/php-plugins ]; then
  /bin/sudo mkdir /etc/httpd/php-plugins >> ${SCRIPT_DIR}/debug.log
fi
/bin/sudo /bin/rm -Rf /etc/httpd/php-plugins/* >> ${SCRIPT_DIR}/debug.log
/bin/sudo /bin/mv -f full_php_browscap.ini /etc/httpd/php-plugins/full_php_browscap.ini
/bin/sudo /bin/sed -i 's/;browscap=.*/browscap=\/etc\/httpd\/php-plugins\/full_php_browscap.ini/g' /etc/php.ini
/bin/sudo chown apache:apache /etc/httpd/php-plugins/full_php_browscap.ini

/bin/sudo /bin/echo 'disable_functions="shell_exec,exec,system,passthru"' > /etc/php.d/99-security.ini
