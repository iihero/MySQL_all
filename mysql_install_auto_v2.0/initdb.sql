alter user 'root'@'localhost' identified with mysql_native_password by 'test123';
flush privileges; 

create database mydb;

CREATE USER 'mydb'@'localhost' IDENTIFIED WITH mysql_native_password BY 'test123';
CREATE USER 'mydb'@'%' IDENTIFIED WITH mysql_native_password BY 'test123';
grant all on mydb.* to 'mydb'@'localhost','mydb'@'%';

flush privileges;
