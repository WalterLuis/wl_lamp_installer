if (Test-Path "C:\wamp64\bin\" -PathType Any) {
    $pathWamp = "C:\wamp64\bin\";
}
else {
    $pathWamp = "C:\wamp\bin\";
}

$versionsApache = @(
    "apache\apache2.4."
)
$postApache = @(
    "\conf\httpd.conf",
    "\conf\extra\httpd-vhosts.conf"
)

$versionsMariaDB = @(
    "mariadb\mariadb10.1.",
    "mariadb\mariadb10.2.",
    "mariadb\mariadb10.3.",
    "mariadb\mariadb10.4.",
    "mariadb\mariadb10.5.",
    "mariadb\mariadb10.6.",
    "mariadb\mariadb10.7."
)
$postMariaDB = @(
    "\my.ini"
)

$versionsPHP = @(
    "apache\apache2.4.",
    "php\php5.6.",
    "php\php7.0.",
    "php\php7.1.",
    "php\php7.2.",
    "php\php7.3.",
    "php\php7.4.",
    "php\php8.0.",
    "php\php8.1."
)
$postPHP = @(
    "\bin\php.ini",
    "\php.ini",
    "\phpForApache.ini"
)

Write-Output 'Configuration applied in:'
for ($i = 0; $i -le 99; $i++) {
    foreach ($versionPath in $versionsApache) {
        foreach ($postPath in $postApache) {
            $path = $pathWamp + $prePath + $versionPath + $i + $postPath;
            if (Test-Path $path -PathType leaf) {
                Write-Output $path
                $original_backup = $path + '.original_backup';
                $previous_backup = $path + '.previous_backup';
                if (Test-Path $original_backup -PathType leaf) {
                    Copy-Item $path -Destination $previous_backup
                }
                else {
                    Copy-Item $path -Destination $original_backup
                }
                foreach ($file in get-ChildItem $path) {
                    (Get-Content $path) -replace " = ", "=" | Set-Content $path
                    (Get-Content $path) -replace "= ", "=" | Set-Content $path
                    (Get-Content $path) -replace " =", "=" | Set-Content $path
                    (Get-Content $path) -replace "# ", "#" | Set-Content $path
                    (Get-Content $path) -replace "ServerSignature .*", "ServerSignature Off" | Set-Content $path
                    (Get-Content $path) -replace "ServerTokens .*", "ServerTokens Prod" | Set-Content $path
                    (Get-Content $path) -replace "Require .*", "Require all granted" | Set-Content $path
                    (Get-Content $path) -replace "#.*", "" | Set-Content $path
                    (Get-Content $path) | Where-Object { $_.trim() -ne "" } | Set-Content $path
                }
            }
        }
    }
}
for ($i = 0; $i -le 99; $i++) {
    foreach ($versionPath in $versionsMariaDB) {
        foreach ($postPath in $postMariaDB) {
            $path = $pathWamp + $prePath + $versionPath + $i + $postPath;
            if (Test-Path $path -PathType leaf) {
                Write-Output $path
                $original_backup = $path + '.original_backup';
                $previous_backup = $path + '.previous_backup';
                if (Test-Path $original_backup -PathType leaf) {
                    Copy-Item $path -Destination $previous_backup
                }
                else {
                    Copy-Item $path -Destination $original_backup
                }
                foreach ($file in get-ChildItem $path) {
                    (Get-Content $path) -replace " = ", "=" | Set-Content $path
                    (Get-Content $path) -replace "= ", "=" | Set-Content $path
                    (Get-Content $path) -replace " =", "=" | Set-Content $path
                    (Get-Content $path) -replace "; ", ";" | Set-Content $path
                    (Get-Content $path) -replace ";sql-mode=.*", 'sql-mode="NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"' | Set-Content $path
                    (Get-Content $path) -replace "sql-mode=.*", 'sql-mode="NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"' | Set-Content $path
                    (Get-Content $path) -replace ";innodb_lock_wait_timeout=.*", "innodb_lock_wait_timeout=3600" | Set-Content $path
                    (Get-Content $path) -replace "innodb_lock_wait_timeout=.*", "innodb_lock_wait_timeout=3600" | Set-Content $path
                    (Get-Content $path) -replace ";max_allowed_packet=.*", "max_allowed_packet=32M" | Set-Content $path
                    (Get-Content $path) -replace "max_allowed_packet=.*", "max_allowed_packet=32M" | Set-Content $path
                    (Get-Content $path) -replace ";innodb_lock_wait_timeout=.*", "innodb_lock_wait_timeout=3600" | Set-Content $path
                    (Get-Content $path) -replace "innodb_lock_wait_timeout=.*", "innodb_lock_wait_timeout=3600" | Set-Content $path
                    (Get-Content $path) -replace ";default-storage-engine=.*", "default-storage-engine=innodb" | Set-Content $path
                    (Get-Content $path) -replace "default-storage-engine=.*", "default-storage-engine=innodb" | Set-Content $path
                    (Get-Content $path) -replace ";.*", "" | Set-Content $path
                    (Get-Content $path) | Where-Object { $_.trim() -ne "" } | Set-Content $path
                }
            }
        }
    }
}
for ($i = 0; $i -le 99; $i++) {
    foreach ($versionPath in $versionsPHP) {
        foreach ($postPath in $postPHP) {
            $path = $pathWamp + $prePath + $versionPath + $i + $postPath;
            if (Test-Path $path -PathType leaf) {
                Write-Output $path
                $original_backup = $path + '.original_backup';
                $previous_backup = $path + '.previous_backup';
                if (Test-Path $original_backup -PathType leaf) {
                    Copy-Item $path -Destination $previous_backup
                }
                else {
                    Copy-Item $path -Destination $original_backup
                }
                foreach ($file in get-ChildItem $path) {
                    (Get-Content $path) -replace " = ", "=" | Set-Content $path
                    (Get-Content $path) -replace "= ", "=" | Set-Content $path
                    (Get-Content $path) -replace " =", "=" | Set-Content $path
                    (Get-Content $path) -replace "; ", ";" | Set-Content $path
                    (Get-Content $path) -replace '"Off"', '=Off' | Set-Content $path
                    (Get-Content $path) -replace '=""Off""', '=Off' | Set-Content $path
                    (Get-Content $path) -replace '="On"', '=On' | Set-Content $path
                    (Get-Content $path) -replace '=""On""', '=On' | Set-Content $path
                    
                    (Get-Content $path) -replace ";short_open_tag=.*", "short_open_tag=On" | Set-Content $path
                    (Get-Content $path) -replace "short_open_tag=.*", "short_open_tag=On" | Set-Content $path
                    
                    (Get-Content $path) -replace ";output_buffering=.*", "output_buffering=On" | Set-Content $path
                    (Get-Content $path) -replace "output_buffering=.*", "output_buffering=On" | Set-Content $path
                    
                    (Get-Content $path) -replace ";realpath_cache_size=.*", "realpath_cache_size=2048k" | Set-Content $path
                    (Get-Content $path) -replace "realpath_cache_size=.*", "realpath_cache_size=2048k" | Set-Content $path
                    
                    (Get-Content $path) -replace ";realpath_cache_ttl=.*", "realpath_cache_ttl=600" | Set-Content $path
                    (Get-Content $path) -replace "realpath_cache_ttl=.*", "realpath_cache_ttl=600" | Set-Content $path
                    
                    (Get-Content $path) -replace ";expose_php=.*", "expose_php=Off" | Set-Content $path
                    (Get-Content $path) -replace "expose_php=.*", "expose_php=Off" | Set-Content $path
                    
                    (Get-Content $path) -replace ";max_execution_time=.*", "max_execution_time=3600" | Set-Content $path
                    (Get-Content $path) -replace "max_execution_time=.*", "max_execution_time=3600" | Set-Content $path
                    
                    (Get-Content $path) -replace ";max_input_time=.*", "max_input_time=3600" | Set-Content $path
                    (Get-Content $path) -replace "max_input_time=.*", "max_input_time=3600" | Set-Content $path
                    
                    (Get-Content $path) -replace ";max_input_vars=.*", "max_input_vars=50000" | Set-Content $path
                    (Get-Content $path) -replace "max_input_vars=.*", "max_input_vars=50000" | Set-Content $path
                    
                    (Get-Content $path) -replace ";memory_limit=.*", "memory_limit=4096M" | Set-Content $path
                    (Get-Content $path) -replace "memory_limit=.*", "memory_limit=4096M" | Set-Content $path
                    
                    (Get-Content $path) -replace ";log_errors_max_len=.*", "log_errors_max_len=0" | Set-Content $path
                    (Get-Content $path) -replace "log_errors_max_len=.*", "log_errors_max_len=0" | Set-Content $path
                    
                    (Get-Content $path) -replace ";track_errors=.*", ";track_errors=On" | Set-Content $path
                    (Get-Content $path) -replace "track_errors=.*", ";track_errors=On" | Set-Content $path
                    
                    (Get-Content $path) -replace ";post_max_size=.*", "post_max_size=1024M" | Set-Content $path
                    (Get-Content $path) -replace "post_max_size=.*", "post_max_size=1024M" | Set-Content $path
                    
                    (Get-Content $path) -replace ";upload_max_filesize=.*", "upload_max_filesize=1024M" | Set-Content $path
                    (Get-Content $path) -replace "upload_max_filesize=.*", "upload_max_filesize=1024M" | Set-Content $path
                    
                    (Get-Content $path) -replace ";max_file_uploads=.*", "max_file_uploads=50" | Set-Content $path
                    (Get-Content $path) -replace "max_file_uploads=.*", "max_file_uploads=50" | Set-Content $path
                    
                    (Get-Content $path) -replace ";auto_detect_line_endings=.*", "auto_detect_line_endings=On" | Set-Content $path
                    (Get-Content $path) -replace "auto_detect_line_endings=.*", "auto_detect_line_endings=On" | Set-Content $path
                    
                    (Get-Content $path) -replace ";default_socket_timeout=.*", "default_socket_timeout=3600" | Set-Content $path
                    (Get-Content $path) -replace "default_socket_timeout=.*", "default_socket_timeout=3600" | Set-Content $path
                    
                    (Get-Content $path) -replace ";date.timezone=.*", 'date.timezone="Atlantic/Canary"' | Set-Content $path
                    (Get-Content $path) -replace "date.timezone=.*", 'date.timezone="Atlantic/Canary"' | Set-Content $path
                    
                    (Get-Content $path) -replace ";date.default_latitude=.*", "date.default_latitude=28.4716" | Set-Content $path
                    (Get-Content $path) -replace "date.default_latitude=.*", "date.default_latitude=28.4716" | Set-Content $path
                    
                    (Get-Content $path) -replace ";date.default_longitude=.*", "date.default_longitude=-16.2472" | Set-Content $path
                    (Get-Content $path) -replace "date.default_longitude=.*", "date.default_longitude=-16.2472" | Set-Content $path
                    
                    (Get-Content $path) -replace ";mysqlnd.collect_statistics=.*", "mysqlnd.collect_statistics=Off" | Set-Content $path
                    (Get-Content $path) -replace "mysqlnd.collect_statistics=.*", "mysqlnd.collect_statistics=Off" | Set-Content $path
                    
                    (Get-Content $path) -replace ";mysqlnd.collect_memory_statistics=.*", "mysqlnd.collect_memory_statistics=Off" | Set-Content $path
                    (Get-Content $path) -replace "mysqlnd.collect_memory_statistics=.*", "mysqlnd.collect_memory_statistics=Off" | Set-Content $path
                    
                    (Get-Content $path) -replace ";session.use_strict_mode=.*", "session.use_strict_mode=1" | Set-Content $path
                    (Get-Content $path) -replace "session.use_strict_mode=.*", "session.use_strict_mode=1" | Set-Content $path
                    
                    (Get-Content $path) -replace ";session.name=.*", "session.name=IMCSESSID" | Set-Content $path
                    (Get-Content $path) -replace "session.name=.*", "session.name=IMCSESSID" | Set-Content $path
                    
                    (Get-Content $path) -replace ";session.gc_divisor=.*", "session.gc_divisor=500" | Set-Content $path
                    (Get-Content $path) -replace "session.gc_divisor=.*", "session.gc_divisor=500" | Set-Content $path
                    
                    (Get-Content $path) -replace ";session.gc_maxlifetime=.*", "session.gc_maxlifetime=43200" | Set-Content $path
                    (Get-Content $path) -replace "session.gc_maxlifetime=.*", "session.gc_maxlifetime=43200" | Set-Content $path
                    
                    (Get-Content $path) -replace ";session.sid_length=.*", "session.sid_length=64" | Set-Content $path
                    (Get-Content $path) -replace "session.sid_length=.*", "session.sid_length=64" | Set-Content $path
                    
                    (Get-Content $path) -replace ";session.sid_bits_per_character=.*", "session.sid_bits_per_character=6" | Set-Content $path
                    (Get-Content $path) -replace "session.sid_bits_per_character=.*", "session.sid_bits_per_character=6" | Set-Content $path
                    
                    (Get-Content $path) -replace ";mbstring.func_overload=.*", "mbstring.func_overload=0" | Set-Content $path
                    (Get-Content $path) -replace "mbstring.func_overload=.*", "mbstring.func_overload=0" | Set-Content $path
                    
                    (Get-Content $path) -replace ";opcache.enable=.*", "opcache.enable=0" | Set-Content $path
                    (Get-Content $path) -replace "opcache.enable=.*", "opcache.enable=0" | Set-Content $path
                    
                    (Get-Content $path) -replace ";opcache.enable_cli=.*", "opcache.enable_cli=0" | Set-Content $path
                    (Get-Content $path) -replace "opcache.enable_cli=.*", "opcache.enable_cli=0" | Set-Content $path
                    (Get-Content $path) -replace ";opcache.interned_strings_buffer=.*", "opcache.interned_strings_buffer=16" | Set-Content $path
                    (Get-Content $path) -replace ";opcache.max_accelerated_files=.*", "opcache.max_accelerated_files=65407" | Set-Content $path
                    (Get-Content $path) -replace ";opcache.memory_consumption=.*", "opcache.memory_consumption=128" | Set-Content $path
                    (Get-Content $path) -replace ";opcache.revalidate_freq=.*", "opcache.revalidate_freq=30" | Set-Content $path
                    (Get-Content $path) -replace ";opcache.validate_timestamps=.*", "opcache.validate_timestamps=1" | Set-Content $path
                    (Get-Content $path) -replace ";opcache.revalidate_freq=.*", "opcache.revalidate_freq=30" | Set-Content $path
                    (Get-Content $path) -replace ";opcache.save_comments=.*", "opcache.save_comments=0" | Set-Content $path

                    (Get-Content $path) -replace ";extension=ftp", "extension=ftp" | Set-Content $path
                    (Get-Content $path) -replace ";extension=odbc", "extension=odbc" | Set-Content $path
                    (Get-Content $path) -replace ";extension=pdo_pgsql", "extension=pdo_pgsql" | Set-Content $path
                    (Get-Content $path) -replace ";extension=pgsql", "extension=pgsql" | Set-Content $path
                    (Get-Content $path) -replace ";extension=sodium", "extension=sodium" | Set-Content $path
                    (Get-Content $path) -replace ";extension=tidy", "extension=tidy" | Set-Content $path

                    (Get-Content $path) -replace ";zend_extension=", "###zend_extension=" | Set-Content $path
                    (Get-Content $path) -replace ";extension=", "###extension=" | Set-Content $path
                    (Get-Content $path) -replace ";.*", "" | Set-Content $path
                    (Get-Content $path) -replace "###zend_extension=", ";zend_extension=" | Set-Content $path
                    (Get-Content $path) -replace "###extension=", ";extension=" | Set-Content $path
                    (Get-Content $path) | Where-Object { $_.trim() -ne "" } | Set-Content $path
                }
            }
        }
    }
}
Write-Output 'END'
pause
