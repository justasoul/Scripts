REM
REM  USAGE:
REM    call_sqlplus.bat  schema/password@SID  filename
REM

@echo off

set oracle_connect_string=%1
set sql_file_to_run=%2

chcp 1252

set "callsqlplus=exit | sqlplus %oracle_connect_string% @"

set runme=%callsqlplus%%sql_file_to_run%

REM %runme%
