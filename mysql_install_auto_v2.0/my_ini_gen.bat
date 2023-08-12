@echo off
echo "This is a demo script for auto installation of noninstall version of MySQL on Windows.  "
echo "Copyright: iihero, when you distribute it, please copy this section above the head."
echo "================================iihero.com====================================="
set MYSQL_HOME=%~dp0
echo MYSQL_HOME=%MYSQL_HOME%
del /F my.ini
echo [client] >> my.ini
echo port = %server_port% >> my.ini
echo default_character_set=gbk >> my.ini
echo [mysqld] >> my.ini
echo %server_default_character_set%=utf8 >> my.ini
echo default_storage_engine=InnoDB >> my.ini
echo default-time-zone='+0:00' >> my.ini
echo basedir=%MYSQL_HOME%>>my.ini
echo innodb_data_home_dir=%MYSQL_HOME%data>> my.ini
echo innodb_data_file_path=ibdata1:50M;ibdata2:10M:autoextend >> my.ini
echo transaction-isolation=READ-COMMITTED >> my.ini
echo port=%server_port% >> my.ini
echo max_allowed_packet = 64M >> my.ini
echo "my.ini in %MYSQL_HOME% created."
set PATH=%MYSQL_HOME%\bin;%PATH%
echo Forcely delete the service mysql-%fullversion% if existing.
sc delete mysql-%fullversion%
if exist "%MYSQL_HOME%\bin\mysqld-nt.exe" call %MYSQL_HOME%\bin\mysqld-nt --install-manual "mysql-%fullversion%" --defaults-file="%MYSQL_HOME%my.ini"
if not exist "%MYSQL_HOME%\bin\mysqld-nt.exe" call %MYSQL_HOME%\bin\mysqld --install-manual "mysql-%fullversion%" --defaults-file="%MYSQL_HOME%\my.ini"


echo .........................................................................................
echo Finished creating service "mysql-%fullversion%" for mysql-%fullversion_arch%. Please check it in the service panel.
echo You can use net start mysql-%fullversion% to start the mysql service. Good luck.
echo If you want to delete the install, just do as below:
echo 1. If you have started the service, just run: net stop mysql-%fullversion% to stop it.
echo 2. sc delete mysql-%fullversion% to delete the service
echo 3. Delete the whole directory of %MYSQL_HOME%
echo .........................................................................................


call %MYSQL_HOME%\bin\mysqld --initialize-insecure --user=mysql --console

echo start mysql-%fullversion% service and init the database and users.

net start mysql-%fullversion%

echo "Let's sleep 3 seconds"
PING -n 3 127.0.0.1>nul

"%MYSQL_HOME%\bin\mysql" -u root < "%MYSQL_HOME%\initdb.sql"

echo "Initialization finished.  "
echo "The password of root and mydb are both test123, and please don't forget to modify if required!!!"

