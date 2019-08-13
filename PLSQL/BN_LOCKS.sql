
-- Locks entre sessões
select s1.username || '@' || s1.machine
    || ' ( SID=' || s1.sid || ' )  is blocking '
    || s2.username || '@' || s2.machine || ' ( SID=' || s2.sid || ' ) ' AS blocking_status
    from v$lock l1, v$session s1, v$lock l2, v$session s2
    where s1.sid=l1.sid and s2.sid=l2.sid
    and l1.BLOCK=1 and l2.request > 0
    and l1.id1 = l2.id1
    and l2.id2 = l2.id2 
;


/*
   VER: http://www.orafaq.com/node/854
        http://www.datadisk.co.uk/html_docs/oracle/locking.htm
*/


------------------------------------------
-- Objectos Bloqueados (locked objects) --
-------------------------------------------------------------------------------------------------------------

select session_id "sid",SERIAL#  "Serial",
substr(object_name,1,20) "Object",
  substr(os_user_name,1,10) "Terminal",
  substr(oracle_username,1,10) "Locker",
  nvl(lockwait,'active') "Wait",
  decode(locked_mode,
    2, 'row share',
    3, 'row exclusive',
    4, 'share',
    5, 'share row exclusive',
    6, 'exclusive',  'unknown') "Lockmode",
  OBJECT_TYPE "Type"
FROM
  SYS.V_$LOCKED_OBJECT A,
  SYS.ALL_OBJECTS B,
  SYS.V_$SESSION c
WHERE
  A.OBJECT_ID = B.OBJECT_ID AND
  C.SID = A.SESSION_ID
ORDER BY 1 ASC, 5 Desc
;

-- Ver sessão --
Select s.username, s.schemaname, s.logon_time, 
       s.osuser, s.process, s.machine, s.port, s.terminal, s.program, 
       
       s.event, s.seconds_in_wait, s.state,
       s.* 
  from v$session s 
 where s.sid    = '19'
   and s.serial# = '6765'
;

--  Ver sessões demoradas --
Select * 
  from v$session_longops slo
 where slo.sid     = '19'
   and slo.serial# = '6765'
;

-----------------------
-- SESSION / PROCESS --
-----------------------------------------------------------------------------

Select s.sid || ',' || s.serial#  || ' :: ' || p.spid sessao, 
       s.*
  from v$session s,
       v$process p 
 where s.username = 'ERP_MRB' 
   and s.program  = 'ifweb90.exe'
   and s.paddr = p.addr(+)
;   


--------------
-- PROCESSO --
----------------------------------------------------------------------------------------------------------
-- show PROCESS id for all the active sessions
select p.spid,s.sid,s.serial#,s.username,s.status,s.last_call_et,p.program,p.terminal,logon_time,module,s.osuser
from V$process p,V$session s
where s.paddr = p.addr and s.status = 'ACTIVE' and s.username like '%SYS%'
;

-------------------------------------
-- Sessões a bloquear outra sessão --
------------------------------------------------------------------------------------------------------------
select s1.username || '@' || s1.machine
    || ' ( SID=' || s1.sid || ' )  is blocking '
    || s2.username || '@' || s2.machine || ' ( SID=' || s2.sid || ' ) ' AS blocking_status
    from v$lock l1, v$session s1, v$lock l2, v$session s2
    where s1.sid=l1.sid and s2.sid=l2.sid
    and l1.BLOCK=1 and l2.request > 0
    and l1.id1 = l2.id1
    and l2.id2 = l2.id2 
;

-- Modos de "Matar" --
-------------------------------------------------------------------------------------------------------------
alter system kill session '<SID>,<SERIAL#>'
;

alter system disconnect session '<SID>,<SERIAL#>' immediate
;

------------------------------------------
-- Registos bloqueados (locked records) --
-------------------------------------------------------------------------------------------------------------


/*
 * Este procedure permite determinar que registo de uma dada tabela 
 * (neste exemplo a "QAC_SERIES_DOCUMENTOS") está bloqueado. 
 * Ter em atenção que é uma abordagem por brute force, que analiza cada linha da tabela
 *
 * ver: http://www.orafaq.com/forum/t/174616/0/
 **************************************************/
DECLARE
  resource_busy_nowait   EXCEPTION;
  PRAGMA EXCEPTION_INIT (resource_busy_nowait, -00054);
  FOUND   BOOLEAN := FALSE;
  x       number;
BEGIN
  -- get subset of records of interest
  FOR i IN  (SELECT ROWID rid FROM erp.qac_series_documentos)
  LOOP
    BEGIN
      SELECT 1 into X FROM erp.qac_series_documentos WHERE ROWID = i.rid FOR UPDATE NOWAIT;
      commit;  -- release the lock asap
    EXCEPTION
      WHEN resource_busy_nowait
      THEN
        FOUND := TRUE;
        DBMS_OUTPUT.put_line ('Locked rec: ROWID='||i.rid ); -- ||' ENAME='||rpad(i.ENAME, 8, ' ')||', JOB='||i.JOB);
      END;
   END LOOP;
 
   IF NOT FOUND
   THEN
     DBMS_OUTPUT.put_line ('No records locked in QAC_SERIE_DOCUMENTOS');
   END IF;
END;