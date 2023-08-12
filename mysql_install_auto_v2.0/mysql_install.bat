@echo off
set fullversion=%1
set fullname=""
set server_default_character_set=default_character_set
set arch=%2
set ROOTDIR=%3
set server_port=%4
set mysql_dir=""

:: example:
:: mysql_install.bat 4.1.22
:: mysql_install.bat 5.0.95 winx64
:: mysql_install.bat 5.6.14 winx64
:: mysql_install.bat 5.1.72 winx64
:: mysql_install.bat 5.5.34 winx64
:: mysql_install.bat 6.0.11-alpha win32
:: mysql_install.bat 5.7.37
:: mysql_install.bat 8.0.28

if "[%fullversion%]" == "[]" goto HELP
if not "[%fullversion%]" == "[]" goto TOINSTALL
:HELP
    echo mysql_install.bat ^<fullversion^> [arch] [ROOTDIR] [server_port]
    echo valid ^<fullversion^> ：4.1.22, 5.1.xx, 5.5.xx, e.g. 5.1.72, 5.6.14, 5.7.37, 6.0.11-alpha, 8.0.28 etc.
    echo valid xx, you can open https://mirrors.sohu.com/mysql/MySQL-^<major_version^> to find it.
    echo e.g. to get the target fullversion of 5.7, you can open:
    echo https://mirrors.sohu.com/mysql/MySQL-5.7.37 to get the full name end with winx64.zip or win32.zip.
    echo valid value of arch:  win32,  winx64, default is winx64
    echo ROOTDIR,  the root directory of mysql installation. The default value is c:\mysql  It should be already existed/created.
    echo default server_port is 3306
    echo Please input valid value of the fullversion.
    goto END
    
:TOINSTALL    
if "%arch%" == "" set arch=winx64
if "%server_port%" == "" set server_port=3306
if "[%ROOTDIR%]" == "[]" echo ROOTDIR is not set, will be using default value. && set ROOTDIR=c:\mysql
set version=%fullversion:~0,3%
echo The major version is: %version%
set version_arch=%fullversion%-%arch%
echo The full version with arch is: %version_arch%
:: 4.1版本只有32位的
if "%version%" == "4.1" (
    set fullname="mysql-noinstall-%version_arch%"
    set mysql_dir="%ROOTDIR%\mysql-%version_arch%"
    echo You will fetch %fullname% ......
    goto DOWNLOAD
)

if "%version%" == "5.0" (
    set fullname="mysql-noinstall-%version_arch%"
    set mysql_dir="%ROOTDIR%\mysql-%version_arch%"
    echo You will fetch %fullname% ......
    goto DOWNLOAD
)

if "%version%" == "5.1" (
    set fullname="mysql-noinstall-%version_arch%"
    set mysql_dir="%ROOTDIR%\mysql-%version_arch%"
    echo You will fetch %fullname% ......
    goto DOWNLOAD
)

if "%version%" == "5.5" (
    set fullname="mysql-%version_arch%"
    set mysql_dir="%ROOTDIR%\mysql-%version_arch%"
    set server_default_character_set=character_set_server
    echo You will fetch %fullname% ......
    goto DOWNLOAD
)

if "%version%" == "5.6" (
    set fullname="mysql-%version_arch%"
    set mysql_dir="%ROOTDIR%\mysql-%version_arch%"
    set server_default_character_set=character_set_server
    echo You will fetch %fullname% ......
    goto DOWNLOAD
)

if "%version%" == "5.7" (
    set fullname="mysql-%version_arch%"
    set mysql_dir="%ROOTDIR%\mysql-%version_arch%"
    set server_default_character_set=character_set_server
    echo You will fetch %fullname% ......
    goto DOWNLOAD
)

if "%version%" == "6.0" (
    set fullname="mysql-noinstall-%version_arch%"
    set mysql_dir="%ROOTDIR%\mysql-%version_arch%"
    set server_default_character_set=character_set_server
    echo You will fetch %fullname% ......
    goto DOWNLOAD
)

if "%version%" == "8.0" (
    set fullname="mysql-%version_arch%"
    set mysql_dir="%ROOTDIR%\mysql-%version_arch%"
    set server_default_character_set=character_set_server
    echo You will fetch %fullname% ......
    goto DOWNLOAD
)

:ERROR
    echo the version should be 4.1, 5.0, 5.1, 5.5, 5.6, 5.7, 6.0, 8.0 for now!!

:DOWNLOAD
if not exist %fullname%.zip (
    wget https://mirrors.dotsrc.org/mysql/Downloads/MySQL-%version%/%fullname%.zip
::  wget https://mirrors.aliyun.com/mysql/MySQL-%version%/%fullname%.zip
::	wget https://mirrors.sohu.com/mysql/MySQL-%version%/%fullname%.zip
    if not exist %fullname%.zip (
        echo download %fullname% error!!
        goto EOF
    )
)
if not exist %mysql_dir% (
    7z x -y -o%ROOTDIR%\ -x!*\data\ib* %fullname%.zip
)
copy /Y my_ini_gen.bat %mysql_dir%
copy /Y initdb.sql %mysql_dir%
cd /d %mysql_dir%

call my_ini_gen.bat
:EOF
echo The installation finished for %fullname%....

del/Q/F "%mysql_dir%\initdb.sql"
del/Q/F "%mysql_dir%\my_ini_gen.bat"

:END
@echo on
