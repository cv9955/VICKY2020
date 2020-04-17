﻿# install ORACLE18c

## BACKUP
- SCHEMA 	>VICKY19.SQL
- APP 		>F400.SQL
- COPIAR CARPETA XE

## DESINSTALAR ORACLE 11
- REINICIAR PC

## INSTALL 18c
- SETUP.EXE
  - DIRECTORY 'C:\oracle\18.0.0\'
  - SYS SYSTEM PDBADMIN Pass: 40**

## preparar PDB1
- cmd as admin
- sqlplus / as sysdba

> SHOW PDBS;   -- PDB1 ONLINE
> ALTER SESSION SET CONTAINER=XEPDB1;
> CREATE DIRECTORY DUMP_DIR AS 'C:\ORACLE\DUMP_DIR';
> GRANT READ, WRITE ON DIRECTORY DUMP_DIR TO SYSTEM;

> CREATE TABLESPACE VICKY 
> DATAFILE ‘C:\ORACLE\18.0.0\ORADATA\XE\XEPDB1\VICKY.DBF’
> SIZE 100M AUTOEXTEND ON NEXT 10M;

> CREATE TABLESPACE VICKY_LOB 
> DATAFILE ‘C:\ORACLE\18.0.0\ORADATA\XE\XEPDB1\VICKY_LOB.DBF’
> SIZE 100M AUTOEXTEND ON NEXT 10M;

> CREATE TABLESPACE ARBA 
> DATAFILE ‘C:\ORACLE\18.0.0\ORADATA\XE\XEPDB1\ARBA.DBF’
> SIZE 100M AUTOEXTEND ON NEXT 10M;

> CREATE USER VIC IDENTIFIED BY Ag20** default tablespace vicky;

## importar

c:\>impdp system/40**@192.168.2.99:1521/xepdb1 full=Y directory=DUMP_DIR dumpfile=vicky19.dmp logfile=vicky19.log


## INSTALAR APEX
C:\APEX_19.2\APEX>SQLPLUS /NOLOG
> CONN / AS SYSDBA
> ALTER SESSION SET CONTAINER=XEPDB1;

> CREATE TABLESPACE APEX 
> DATAFILE ‘C:\ORACLE\18.0.0\ORADATA\XE\XEPDB1\APEX.DBF’
> SIZE 100M AUTOEXTEND ON NEXT 10M;

> @APEXINS.SQL APEX APEX TEMP /i/

> @apxchpwd.sql    >> CAV Agos?2020

> @apex_rest_config.sql    >> 40

> @apex_epg_config.sql c:/apex_19.2

## Habilitar Puertos 
> EXEC DBMS_XDB.GETHTTPPORT(9090);

> EXEC DBMS_XDB.SETLISTENERLOCALACCESS(FALSE);

> ALTER SESSION SET CONTAINER=CDB$ROOT;
> ALTER USER ANONYMOUS ACCOUNT UNLOCK;


-- PARA QUE LA BASE PRENDA SOLA 
> ALTER PLUGGABLE DATABASE XEPDB1 SAVE STATE;


!! abrir firewall

## Importar Apex
http:localhost:9090/apex/f?p=4550

* IMPORT WORKSPACE 
  - VICKY19.SQL
    !! REUSE SCHEMA VIC !!

* IMPORT APP
  - F400.SQL
    !! REUSE APP ID 400 !!

* CREATE APEX USER



8080 - SRVICKY20 / XEPDB2    
8081 - SRVICKY20 / XEPDB1  !! VICKY 2.0 - ROJO
     - SRVICKY20 / XEPDB2     UNPLUG 	- GRIS 


9090 - PC-CAV    / XEPDB1  !! VICKY19   - AZUL

