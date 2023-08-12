set password for 'root'@'localhost'=password('test123');
-- update mysql.user set password=password('test123') where user='root';
flush privileges; 

create database mydb;

set password for 'mydb'@'localhost'=password('test123');
set password for 'mydb'@'%'=password('test123');
grant all on mydb.* to 'mydb'@'localhost','mydb'@'%';
flush privileges;
