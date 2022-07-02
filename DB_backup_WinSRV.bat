REM **********************************************
REM Author:Sadrul
REM Linkedin Profile:https://www.linkedin.com/in/sadrulalom/

REM **********************************************

@echo off
SET PG_BIN="C:\Program Files\PostgreSQL\14\bin\pg_dump.exe"
SET PG_HOST=192.168.37.202
SET PG_PORT=5432
SET PG_DATABASE=pgtest
SET PG_USER=opu
SET PGPASSWORD=123
SET PG_PATH=C:\PGBackup\

set TIMESTAMP=%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%%TIME:~0,2%%TIME:~3,2%
SET PG_FILENAME=%PG_PATH%\%PG_DATABASE%_%TIMESTAMP%.tar

%PG_BIN% -h %PG_HOST% -p %PG_PORT% -U %PG_USER% -F t %PG_DATABASE% > %PG_FILENAME%

REM %PG_BIN% -h %PG_HOST% -p %PG_PORT% -U %PG_USER% -F t %PG_DATABASE% > %PG_FILENAME%

@echo Backup Done: %PG_PATH%%PG_FILENAME%
