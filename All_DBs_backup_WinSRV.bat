REM **********************************************
REM Author:Sadrul
REM Linkedin Profile:https://www.linkedin.com/in/sadrulalom/

REM **********************************************


@echo off
set PGBINDIR=C:\Program Files\PostgreSQL\14\bin

rem avoid the password and user prompt from pg_dump
set PGHOST=192.168.37.202
set PGUSER=opu
set PGPASSWORD=123
set PGPORT=5432
SET PG_Backup_Path=C:\PGBackup

"%PGBINDIR%\psql" -X -c "select datname from pg_database where datname not in ('postgres','template1','template0')" -A -t -o dblist.txt -d postgres

set hh=%time:~-11,2%
set /a hh=%hh%+100
set hh=%hh:~1%

rem dump all user accounts and roles
"%PGBINDIR%\pg_dumpall" --globals-only --file=%PG_Backup_Path%\postgres_globals.sql 

for /f %%d in (dblist.txt) do (
  echo Backup running: %%d
  "%PGBINDIR%\pg_dump" -F t %%d > %PG_Backup_Path%\%%d_%date:~10,4%%date:~4,2%%date:~7,2%_%hh%%time:~3,2%%time:~6,2%.tar
  rem "%PGBINDIR%\pg_dump" -F t %%d > %PG_Backup_Path%\%%d_%date:~10,4%%date:~4,2%%date:~7,2%.tar
)